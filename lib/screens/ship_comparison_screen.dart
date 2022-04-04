import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/models/ship.dart';

import '../models/tank.dart';
import '../models/vehicles.dart';
import '../providers/comparison_provider.dart';
import '../utilities/ads_collection.dart';
import '../utilities/constants.dart';
import '../utilities/debug_ads_collection.dart';
import '../widgets/compare_icon_widget.dart';
import '../widgets/compare_text_widget.dart';
import '../widgets/compare_tiles_widget.dart';
import '../widgets/scroll_vehicles_widget.dart';

class ShipComparisonScreen extends StatefulWidget {
  const ShipComparisonScreen({
    required this.receivedData,
    Key? key,
  }) : super(key: key);
  final List<Ship> receivedData;

  @override
  State<ShipComparisonScreen> createState() => _ShipComparisonScreenState();
}

class _ShipComparisonScreenState extends State<ShipComparisonScreen> {
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
                    Expanded(flex: 1, child: ScrollVehiclesWidget(_controller1, simplifiedVehicle, 1)),
                    Expanded(flex: 1, child: ScrollVehiclesWidget(_controller2, simplifiedVehicle, 2)),
                    Expanded(flex: 1, child: ScrollVehiclesWidget(_controller3, simplifiedVehicle, 3)),
                    Expanded(flex: 1, child: ScrollVehiclesWidget(_controller4, simplifiedVehicle, 4)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8),
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
                    SizedBox(height: 8),
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
                        SizedBox(height: 8),
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
                        SizedBox(height: 8),
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
                        SizedBox(height: 8),
                        CompareTextWidget(
                          title: '',
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].shipClass,
                            widget.receivedData[indexController2].shipClass,
                            widget.receivedData[indexController3].shipClass,
                            widget.receivedData[indexController4].shipClass,
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.cannons,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        CompareTextWidget(
                          title: localizations.turrets,
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
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.vehicle_characteristics,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        CompareTilesWidget(
                          title: localizations.max_speed_km_h,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].speeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].speeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].speeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].speeds[_gameMode].replaceAll(' ', '')),
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.reverse_speed_km_h,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].reverseSpeeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].reverseSpeeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].reverseSpeeds[_gameMode].replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].reverseSpeeds[_gameMode].replaceAll(' ', '')),
                          ],
                        ),
                        CompareTilesWidget(
                          title: localizations.displacement,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].displacement.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].displacement.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].displacement.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].displacement.replaceAll(' ', '')),
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
                        CompareTilesWidget(
                          title: localizations.number_of_sections,
                          moreIsBetter: true,
                          data: [
                            double.parse(widget.receivedData[indexController1].numbOfSection.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController2].numbOfSection.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController3].numbOfSection.replaceAll(' ', '')),
                            double.parse(widget.receivedData[indexController4].numbOfSection.replaceAll(' ', '')),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ExpansionTile(
                      collapsedBackgroundColor: kLightGreyColor,
                      title: Text(
                        localizations.armor_and_defense,
                        style: roboto12greySemiBold,
                      ),
                      iconColor: kTextGreyColor,
                      collapsedIconColor: kTextGreyColor,
                      initiallyExpanded: true,
                      children: [
                        CompareTextWidget(
                          title: localizations.armor_front_side_back_mm,
                          noTitle: localizations.no_data,
                          textStyle: roboto10blackRegular,
                          list: [
                            widget.receivedData[indexController1].armors,
                            widget.receivedData[indexController2].armors,
                            widget.receivedData[indexController3].armors,
                            widget.receivedData[indexController4].armors,
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
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
        isPremium: i.isPremium,
        BRs: i.BRs,
        vehicleClass: i.shipClass,
      ));
    }
  }

  void bannerAdLoad() {
    final adsCollection = AdsCollection();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    // final adsCollection = DebugAdsCollection();
    _bannerAd = BannerAd(
      adUnitId: adsCollection.bannerShipAdUnitId(),
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
