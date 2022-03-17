import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/google_signin_provider.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<GoogleSignInProvider>().googleLogOut();
              },
              child: Text('Logout'),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
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
                              actions: <Widget>[
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
                    child: FlutterLogo(size: 150),
                    //TODO: Change to main logo
                    // child: Container(
                    //   width: 150,
                    //   height: 150,
                    //   decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //       fit: BoxFit.scaleDown,
                    //       image: AssetImage('assets/icons/icon.png'),
                    //     ),
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //   ),
                    // ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Version $version',
                    //style: chakra18greyBold,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    width: 500,
                    child: Text(
                      'WT Versus can compare aircrafts, helicopters, tanks and ships from the game War Thunder'
                      '\nAll images and description have been taken from wiki.warthunder.com',
                      //style: oxygen14whiteRegular,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 340,
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
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    width: 560,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.star),
                            label: Text('RATE APP'),
                            onPressed: () async {
                              if (await inAppReview.isAvailable()) {
                                inAppReview.requestReview();
                              } else {
                                inAppReview.openStoreListing(appStoreId: '1606469760'); //TODO: AppStore ID
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.share),
                            label: Text('SHARE'),
                            onPressed: () {
                              var url = '';
                              if (Platform.isAndroid) {
                                url = 'https://play.google.com/store/apps/details?id=com.wave.wtversus';
                              } else if (Platform.isIOS) {
                                url = 'https://apps.apple.com/us/app/thunder-quiz/id1606469760'; //TODO: AppStore ID
                              }
                              Share.share('Check this cool comparison app for War Thunder: $url');
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.envelope),
                            label: Text('EMAIL'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Warning!'),
                                  content: const Text('Please use the GitHub button for bug report or suggestions (Sign-in via Google). '
                                      '\nOn GitHub you are guaranteed to get an answer and a quick response'
                                      '\n\nemail: waveappfeedback@gmail.com'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Got it'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.shieldAlt),
                            const SizedBox(width: 10),
                            Text(
                              'PRIVACY',
                              //style: oxygen10greyBold,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
