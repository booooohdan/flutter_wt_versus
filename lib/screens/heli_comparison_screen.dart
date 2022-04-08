import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/models/heli.dart';

import '../models/vehicles.dart';
import '../providers/comparison_provider.dart';
import '../utilities/ads_collection.dart';
import '../utilities/constants.dart';
import '../widgets/compare_icon_widget.dart';
import '../widgets/compare_text_widget.dart';
import '../widgets/compare_tiles_widget.dart';
import '../widgets/scroll_vehicles_widget.dart';

class HeliComparisonScreen extends StatefulWidget {
  const HeliComparisonScreen({
    required this.receivedData,
    Key? key,
  }) : super(key: key);
  final List<Heli> receivedData;

  @override
  State<HeliComparisonScreen> createState() => _HeliComparisonScreenState();
}

class _HeliComparisonScreenState extends State<HeliComparisonScreen> {
  int _gameMode = 1;

  late PageController _controller1;
  late PageController _controller2;
  late PageController _controller3;
  late PageController _controller4;
  bool isFirstInit = false;
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  final List<Vehicle> simplifiedVehicle = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstInit) {
      isFirstInit = true;
      bannerAdLoad();
      convertToVehicle(); //this one need for PageView scroll widget
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
          centerTitle: false,
          title: Text(localizations.comparison),
          leading: CupertinoButton(
            child: const Icon(Icons.chevron_left),
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
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Expanded(child: ScrollVehiclesWidget(_controller1, simplifiedVehicle, 1)),
                    Expanded(child: ScrollVehiclesWidget(_controller2, simplifiedVehicle, 2)),
                    Expanded(child: ScrollVehiclesWidget(_controller3, simplifiedVehicle, 3)),
                    Expanded(child: ScrollVehiclesWidget(_controller4, simplifiedVehicle, 4)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    CompareTextWidget(
                      title: '',
                      noTitle: localizations.no_data,
                      textStyle: roboto14blackBold,
                      list: [
                        [widget.receivedData[indexController1].BRs[_gameMode]],
                        [widget.receivedData[indexController2].BRs[_gameMode]],
                        [widget.receivedData[indexController3].BRs[_gameMode]],
                        [widget.receivedData[indexController4].BRs[_gameMode]],
                      ],
                    ),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.game_data,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      children: [
                        CompareTilesWidget(
                          title: localizations.repair_cost,
                          moreIsBetter: false,
                          data: [
                            double.parse(widget.receivedData[indexController1].repairCosts[_gameMode].replaceAll(' ', '').replaceAll('free', '0')),
                            double.parse(widget.receivedData[indexController2].repairCosts[_gameMode].replaceAll(' ', '').replaceAll('free', '0')),
                            double.parse(widget.receivedData[indexController3].repairCosts[_gameMode].replaceAll(' ', '').replaceAll('free', '0')),
                            double.parse(widget.receivedData[indexController4].repairCosts[_gameMode].replaceAll(' ', '').replaceAll('free', '0')),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CompareIconWidget(
                          title: '',
                          data: [
                            'assets/icons/${widget.receivedData[indexController1].nation}.svg',
                            'assets/icons/${widget.receivedData[indexController2].nation}.svg',
                            'assets/icons/${widget.receivedData[indexController3].nation}.svg',
                            'assets/icons/${widget.receivedData[indexController4].nation}.svg',
                          ],
                          tooltipData: [
                            widget.receivedData[indexController1].nation,
                            widget.receivedData[indexController2].nation,
                            widget.receivedData[indexController3].nation,
                            widget.receivedData[indexController4].nation,
                          ],
                        ),
                        const SizedBox(height: 8),
                        CompareTextWidget(
                          title: '',
                          noTitle: localizations.no_data,
                          textStyle: roboto12blackMedium,
                          list: [
                            [widget.receivedData[indexController1].rank],
                            [widget.receivedData[indexController2].rank],
                            [widget.receivedData[indexController3].rank],
                            [widget.receivedData[indexController4].rank],
                          ],
                        ),
                        const SizedBox(height: 8),
                        CompareTextWidget(
                          title: '',
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].heliClass,
                            widget.receivedData[indexController2].heliClass,
                            widget.receivedData[indexController3].heliClass,
                            widget.receivedData[indexController4].heliClass,
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.flight_characteristics,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        CompareTextWidget(
                          title: 'Features',
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].features,
                            widget.receivedData[indexController2].features,
                            widget.receivedData[indexController3].features,
                            widget.receivedData[indexController4].features,
                          ],
                        ),
                        //TODO Add icons
                        // CompareImagesWidget(
                        //   title: 'Features',
                        //   noTitle: localizations.no_data,
                        //   list: [
                        //     widget.receivedData[indexController1].features,
                        //     widget.receivedData[indexController2].features,
                        //     widget.receivedData[indexController3].features,
                        //     widget.receivedData[indexController4].features,
                        //   ],
                        // ),
                        CompareTilesWidget(
                          title: localizations.max_speed_km_h,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].speed.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].speed.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].speed.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].speed.replaceAll(' ', '')),
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.weight_t,
                          moreIsBetter: false,
                          data: [
                            double.parse(widget.receivedData[indexController1].weight.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].weight.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].weight.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].weight.replaceAll(' ', '')),
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.max_altitude_m,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].maxAltitude.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].maxAltitude.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].maxAltitude.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].maxAltitude.replaceAll(' ', '')),
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.structural_destruction_km_h,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].flutterStructural.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].flutterStructural.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].flutterStructural.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].flutterStructural.replaceAll(' ', '')),
                          ],
                        ),
                        CompareTextWidget(
                          title: localizations.engine_name,
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            [widget.receivedData[indexController1].engineName],
                            [widget.receivedData[indexController2].engineName],
                            [widget.receivedData[indexController3].engineName],
                            [widget.receivedData[indexController4].engineName],
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.crew_people,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].crew.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].crew.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].crew.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].crew.replaceAll(' ', '')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.weapon_and_turret,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        CompareTextWidget(
                          title: localizations.offensive_armament,
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].weapons,
                            widget.receivedData[indexController2].weapons,
                            widget.receivedData[indexController3].weapons,
                            widget.receivedData[indexController4].weapons,
                          ],
                        ),
                        CompareTextWidget(
                          title: localizations.defensive_armament,
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].turrets,
                            widget.receivedData[indexController2].turrets,
                            widget.receivedData[indexController3].turrets,
                            widget.receivedData[indexController4].turrets,
                          ],
                        ),
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

  void convertToVehicle() {
    for (final i in widget.receivedData) {
      simplifiedVehicle.add(Vehicle(
        link: i.link,
        name: i.name,
        image: i.image,
        nation: i.nation,
        rank: i.rank,
        isPremium: i.isPremium,
        BRs: i.BRs,
        vehicleClass: i.heliClass,
      ));
    }
  }

  void bannerAdLoad() {
    final adsCollection = AdsCollection();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    // final adsCollection = DebugAdsCollection();
    _bannerAd = BannerAd(
      adUnitId: adsCollection.bannerHeliAdUnitId(),
      request: const AdRequest(),
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
