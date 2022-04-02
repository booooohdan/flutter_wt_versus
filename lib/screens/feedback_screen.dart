import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wt_versus/providers/apple_signin_provider.dart';

import '../providers/google_signin_provider.dart';
import '../utilities/constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  String? appName;
  String? version;
  String? buildNumber;
  String? deviceName;
  String? deviceOs;

  @override
  void initState() {
    super.initState();
    getPackageInfo();
    getDeviceInfo();
  }

  Future<void> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
  }

  Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = '${deviceInfo.brand} ${deviceInfo.model}';
      deviceOs = 'Android ${deviceInfo.version.release}';
    } else if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = '${deviceInfo.name}';
      deviceOs = 'iOS ${deviceInfo.systemVersion}';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.of(context).size;
    double tabletScreenWidth = screenSize.width - 40;
    if (screenSize.width > 600) {
      tabletScreenWidth = 600;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.feedback),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  label: Text(
                    localizations.logout,
                    style: TextStyle(color: kTextGreyColor),
                  ),
                  icon: Icon(
                    Icons.logout,
                    size: 20,
                    color: kTextGreyColor,
                  ),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      context.read<GoogleSignInProvider>().googleLogOut();
                    }
                    if (Platform.isIOS) {
                      context.read<AppleSignInProvider>().signOutWithApple();
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: kLightGreyColor, splashFactory: NoSplash.splashFactory),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onDoubleTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Debug info'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('App data', style: TextStyle(fontWeight: FontWeight.bold)),
                                const Divider(),
                                Text('App Name: $appName'),
                                Text('Version: $version'),
                                Text('Build Number: $buildNumber'),
                                const Divider(),
                                const Text('Device data', style: TextStyle(fontWeight: FontWeight.bold)),
                                const Divider(),
                                Text('Device Name: $deviceName'),
                                Text('Device OS: $deviceOs'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          'App Name: $appName | Version: $version | Build Number: $buildNumber | Device Name: $deviceName | Device OS: $deviceOs'));
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copied to clipboard'),
                                    ),
                                  );
                                },
                                child: const Text('Copy'),
                              ),
                            ],
                          )),
                  child: Image.asset(
                    'assets/icons/icon.png',
                    width: 144,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${localizations.version} $version',
                    style: roboto12greySemiBold,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    width: tabletScreenWidth,
                    child: Text(
                      localizations.versus_description,
                      style: roboto12blackMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: tabletScreenWidth,
                    height: 50,
                    child: ElevatedButton.icon(
                      //context: context,
                      icon: FaIcon(FontAwesomeIcons.github),
                      label: Text('GitHub'),
                      onPressed: () async {
                        const url = 'https://github.com/booooohdan/flutter_wt_versus/issues';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch $url'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: tabletScreenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: tabletScreenWidth / 3 - 10,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.star_border, color: kBlackColor),
                            label: Text(localizations.rate, style: roboto12blackMedium),
                            style: ElevatedButton.styleFrom(
                              primary: kButtonGreyColor,
                            ),
                            onPressed: () async {
                              if (await inAppReview.isAvailable()) {
                                inAppReview.requestReview();
                              } else {
                                inAppReview.openStoreListing(appStoreId: '1606469760'); //TODO: AppStore ID
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: tabletScreenWidth / 3 - 10,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.share_outlined, color: kBlackColor),
                            label: Text(localizations.share, style: roboto12blackMedium),
                            style: ElevatedButton.styleFrom(
                              primary: kButtonGreyColor,
                            ),
                            onPressed: () {
                              var url = '';
                              if (Platform.isAndroid) {
                                url = 'https://play.google.com/store/apps/details?id=com.wave.wtversus';
                              } else if (Platform.isIOS) {
                                url = ''; //TODO: AppStore ID
                              }
                              Share.share('Check this cool comparison app for War Thunder: $url');
                            },
                          ),
                        ),
                        SizedBox(
                          width: tabletScreenWidth / 3 - 10,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.email_outlined, color: kBlackColor),
                            label: Text(localizations.email, style: roboto12blackMedium),
                            style: ElevatedButton.styleFrom(
                              primary: kButtonGreyColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(localizations.warning),
                                  content: Text(localizations.email_description),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text(localizations.got_it),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.policy_outlined, color: kTextGreyColor),
                    label: Text(localizations.privacy, style: roboto14greyMedium),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      String url = '';
                      if (Platform.isAndroid) {
                        url = 'https://pages.flycricket.io/war-thunder-versus/privacy.html';
                      } else if (Platform.isIOS) {
                        url = 'https://pages.flycricket.io/thunder-versus/privacy.html';
                      }
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Could not launch $url'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
