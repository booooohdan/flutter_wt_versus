import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../models/plane.dart';
import '../providers/comparison_provider.dart';
import '../utilities/ads_collection.dart';
import '../utilities/constants.dart';
import '../widgets/compare_text_widget.dart';
import '../widgets/compare_tiles_widget.dart';
import '../widgets/scroll_vehicles_widget.dart';

class PlaneComparisonScreen extends StatefulWidget {
  PlaneComparisonScreen({Key? key, required this.receivedData}) : super(key: key);
  final List<Plane> receivedData;

  @override
  _PlaneComparisonScreenState createState() {
    return _PlaneComparisonScreenState();
  }
}

class _PlaneComparisonScreenState extends State<PlaneComparisonScreen> {
  int _gameMode = 1;

  late PageController _controller1;
  late PageController _controller2;
  late PageController _controller3;
  late PageController _controller4;
  bool isFirstInit = false;
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstInit) {
      isFirstInit = true;
      bannerAdLoad();
      _controller1 = PageController(viewportFraction: 0.6, initialPage: context.watch<ComparisonProvider>().indexController1);
      _controller2 = PageController(viewportFraction: 0.6, initialPage: context.watch<ComparisonProvider>().indexController2);
      _controller3 = PageController(viewportFraction: 0.6, initialPage: context.watch<ComparisonProvider>().indexController3);
      _controller4 = PageController(viewportFraction: 0.6, initialPage: context.watch<ComparisonProvider>().indexController4);
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indexController1 = context.watch<ComparisonProvider>().indexController1;
    final indexController2 = context.watch<ComparisonProvider>().indexController2;
    final indexController3 = context.watch<ComparisonProvider>().indexController3;
    final indexController4 = context.watch<ComparisonProvider>().indexController4;
    final screenSize = MediaQuery.of(context).size;
    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 48,
          titleSpacing: 0,
          title: Text(localizations.comparison),
          leading: CupertinoButton(
            child: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: kLightGreyColor,
                thumbColor: kBlackColor,
                groupValue: _gameMode,
                children: {
                  0: Container(
                    child: Text(
                      localizations.ab,
                      style: roboto14greyMedium,
                    ),
                  ),
                  1: Container(
                    child: Text(
                      localizations.rb,
                      style: roboto14greyMedium,
                    ),
                  ),
                  2: Container(
                    child: Text(
                      localizations.sb,
                      style: roboto14greyMedium,
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _gameMode = value!;
                  });
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: screenSize.height / 7,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ScrollVehiclesWidget(_controller1, widget.receivedData, 1),
                    ),
                    Expanded(
                      flex: 1,
                      child: ScrollVehiclesWidget(_controller2, widget.receivedData, 2),
                    ),
                    Expanded(
                      flex: 1,
                      child: ScrollVehiclesWidget(_controller3, widget.receivedData, 3),
                    ),
                    Expanded(
                      flex: 1,
                      child: ScrollVehiclesWidget(_controller4, widget.receivedData, 4),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.receivedData[indexController1].BRs[_gameMode],
                          style: roboto14blackBold,
                        ),
                        Container(height: 20, width: 1, color: kButtonGreyColor),
                        Text(
                          widget.receivedData[indexController2].BRs[_gameMode],
                          style: roboto14blackBold,
                        ),
                        Container(height: 20, width: 1, color: kButtonGreyColor),
                        Text(
                          widget.receivedData[indexController3].BRs[_gameMode],
                          style: roboto14blackBold,
                        ),
                        Container(height: 20, width: 1, color: kButtonGreyColor),
                        Text(
                          widget.receivedData[indexController4].BRs[_gameMode],
                          style: roboto14blackBold,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        'Game Data',
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      children: [
                        Text(
                          'Repair Cost',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].repairCosts[_gameMode].replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].repairCosts[_gameMode].replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].repairCosts[_gameMode].replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].repairCosts[_gameMode].replaceAll(' ', '')),
                        ], true),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/${widget.receivedData[indexController1].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            SvgPicture.asset(
                              'assets/icons/${widget.receivedData[indexController2].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            SvgPicture.asset(
                              'assets/icons/${widget.receivedData[indexController3].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            SvgPicture.asset(
                              'assets/icons/${widget.receivedData[indexController4].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.receivedData[indexController1].rank,
                              style: roboto12blackMedium,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController2].rank,
                              style: roboto12blackMedium,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController3].rank,
                              style: roboto12blackMedium,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController4].rank,
                              style: roboto12blackMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        CompareTextWidget([
                          widget.receivedData[indexController1].planeClass,
                          widget.receivedData[indexController2].planeClass,
                          widget.receivedData[indexController3].planeClass,
                          widget.receivedData[indexController4].planeClass,
                        ], 'No class'),
                      ],
                    ),
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        'Flight characteristics',
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        Text(
                          'Max Speed (km/h)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].speed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].speed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].speed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].speed.replaceAll(' ', '')),
                        ], true),
                        SizedBox(height: 8),
                        Text(
                          'at altitude (m)',
                          style: roboto12greySemiBold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.receivedData[indexController1].altitudeForSpeed,
                              style: roboto12greySemiBold,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController2].altitudeForSpeed,
                              style: roboto12greySemiBold,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController3].altitudeForSpeed,
                              style: roboto12greySemiBold,
                            ),
                            Container(height: 20, width: 1, color: kButtonGreyColor),
                            Text(
                              widget.receivedData[indexController4].altitudeForSpeed,
                              style: roboto12greySemiBold,
                            ),
                          ],
                        ),
                        Text(
                          'Max Altitude (m)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].altitudeForSpeed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].altitudeForSpeed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].altitudeForSpeed.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].altitudeForSpeed.replaceAll(' ', '')),
                        ], true),
                        SizedBox(height: 8),
                        Text(
                          'Turn Time (s)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].turnTime.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].turnTime.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].turnTime.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].turnTime.replaceAll(' ', '')),
                        ], false),
                        SizedBox(height: 8),
                        Text(
                          'Weight (t)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].weight.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].weight.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].weight.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].weight.replaceAll(' ', '')),
                        ], false),
                        SizedBox(height: 8),
                        Text(
                          'Structural destruction (km/h)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].flutterStructural.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].flutterStructural.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].flutterStructural.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].flutterStructural.replaceAll(' ', '')),
                        ], true),
                        SizedBox(height: 8),
                        Text(
                          'Gear destruction (km/h)',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTilesWidget([
                          double.parse(widget.receivedData[indexController1].flutterGear.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController2].flutterGear.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController3].flutterGear.replaceAll(' ', '')),
                          double.parse(widget.receivedData[indexController4].flutterGear.replaceAll(' ', '')),
                        ], true),
                        SizedBox(height: 8),
                        Text(
                          'Features',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTextWidget([
                          widget.receivedData[indexController1].features,
                          widget.receivedData[indexController2].features,
                          widget.receivedData[indexController3].features,
                          widget.receivedData[indexController4].features,
                        ], 'No features'),
                        SizedBox(height: 8),
                        Text(
                          'Engine name',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController1].engineName,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController2].engineName,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController3].engineName,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController4].engineName,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Cooling system',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController1].coolingSystem,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController2].coolingSystem,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController3].coolingSystem,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController4].coolingSystem,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Engine type',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController1].engineType,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController2].engineType,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController3].engineType,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController4].engineType,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Crew',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController1].crew,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController2].crew,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController3].crew,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.receivedData[indexController4].crew,
                                style: roboto10blackRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        'Weapons & Turrets',
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        Text(
                          'Offensive armament',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTextWidget([
                          widget.receivedData[indexController1].weapons,
                          widget.receivedData[indexController2].weapons,
                          widget.receivedData[indexController3].weapons,
                          widget.receivedData[indexController4].weapons,
                        ], 'No armament'),
                        SizedBox(height: 8),
                        Text(
                          'Defensive armament',
                          style: roboto12greySemiBold,
                        ),
                        SizedBox(height: 8),
                        CompareTextWidget([
                          widget.receivedData[indexController1].turrets,
                          widget.receivedData[indexController2].turrets,
                          widget.receivedData[indexController3].turrets,
                          widget.receivedData[indexController4].turrets,
                        ], 'No armament'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _isBannerAdReady
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void bannerAdLoad() {
    final adsCollection = AdsCollection();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    // final adsCollection = DebugAdsCollection();
    _bannerAd = BannerAd(
      adUnitId: adsCollection.bannerAdUnitId(),
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }
}
