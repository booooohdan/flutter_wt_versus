import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/heli.dart';
import '../models/plane.dart';
import '../models/ship.dart';
import '../models/tank.dart';
import '../models/vehicles.dart';
import '../providers/comparison_provider.dart';
import '../providers/firestore_provider.dart';
import '../screens/placeholder_screen.dart';
import '../utilities/constants.dart';
import 'heli_comparison_screen.dart';
import 'plane_comparison_screen.dart';
import 'ship_comparison_screen.dart';
import 'tank_comparison_screen.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool _isFirstInit = false;
  int? _vehicleTypeValue = 1;

  List<Vehicle> _selectedVehicles = [];
  List<Vehicle> _allVehiclesResults = [];
  List<Vehicle> _searchVehiclesResult = [];
  final _searchController = TextEditingController();

  void _onSearchChanged() {
    List<Vehicle> showResult = [];
    if (_searchController.text != '') {
      for (final item in _allVehiclesResults) {
        final name = item.name.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(item);
        }
      }
    } else {
      showResult = _allVehiclesResults;
    }
    setState(() {
      _searchVehiclesResult = showResult;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isFirstInit) {
      _isFirstInit = true;

      _allVehiclesResults = await context.read<FirestoreProvider>().getSimplifiedTanks();
      _searchVehiclesResult = _allVehiclesResults;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appbarSize = AppBar().preferredSize.height;
    final localizations = AppLocalizations.of(context)!;
    var vehicleName = localizations.army;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: appbarSize * 2.5,
              floating: true,
              snap: true,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(16),
                  color: kLightGreyColor,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: kBlackColor,
                          thumbColor: Color(0xfff39393),
                          groupValue: _vehicleTypeValue,
                          padding: EdgeInsets.all(8),
                          children: {
                            0: Container(
                              child: Text(
                                localizations.planes,
                                style: roboto14whiteSemiBold,
                              ),
                            ),
                            1: Container(
                              child: Text(
                                localizations.army,
                                style: roboto14whiteSemiBold,
                              ),
                            ),
                            2: Container(
                              child: Text(
                                localizations.heli,
                                style: roboto14whiteSemiBold,
                              ),
                            ),
                            3: Container(
                              child: Text(
                                localizations.fleet,
                                style: roboto14whiteSemiBold,
                              ),
                            ),
                          },
                          onValueChanged: (value) async {
                            if (value == 0) {
                              _allVehiclesResults = await context.read<FirestoreProvider>().getSimplifiedPlanes();
                              vehicleName = localizations.planes;
                            }
                            if (value == 1) {
                              _allVehiclesResults = await context.read<FirestoreProvider>().getSimplifiedTanks();
                              vehicleName = localizations.army;
                            }
                            if (value == 2) {
                              _allVehiclesResults = await context.read<FirestoreProvider>().getSimplifiedHelis();
                              vehicleName = localizations.helicopters;
                            }
                            if (value == 3) {
                              _allVehiclesResults = await context.read<FirestoreProvider>().getSimplifiedShips();
                              vehicleName = localizations.fleet;
                            }
                            _searchVehiclesResult = _allVehiclesResults;
                            _selectedVehicles.clear();

                            setState(() {
                              _vehicleTypeValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$vehicleName: ${_searchVehiclesResult.length.toString()}',
                            style: roboto12greySemiBold,
                          ),
                          Text(
                            '${localizations.selected_vehicles}: ${_selectedVehicles.length.toString()}',
                            style: roboto12greySemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(appbarSize),
                child: Container(
                  color: kLightGreyColor,
                  child: Row(
                    children: [
                      CupertinoButton(
                        //TODO: Add filters
                        child: Icon(Icons.tune, color: kIconGreyColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlaceholderScreen()),
                          );
                        },
                      ),
                      Expanded(
                        child: CupertinoTextField(
                          controller: _searchController,
                          onChanged: (value) {},
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.search,
                              color: kTextGreyColor,
                            ),
                          ),
                          placeholder: localizations.search,
                          style: roboto14greyMedium,
                        ),
                      ),
                      _selectedVehicles.isNotEmpty
                          ? CupertinoButton(
                              child: Text(localizations.clear, style: roboto14darkGreyMedium),
                              onPressed: () {
                                _selectedVehicles.clear();
                                setState(() {});
                              },
                            )
                          : Container(width: 16),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final _vehicleSelected = _selectedVehicles.contains(_searchVehiclesResult[index]);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          dense: true,
                          leading: SizedBox(
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/icons/${_searchVehiclesResult[index].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                          ),
                          title: Text(
                            '[${_searchVehiclesResult[index].BRs[1]}] ${getSpaceFont(_searchVehiclesResult[index].name)}',
                            style: TextStyle(color: kBlackColor, fontSize: 14, fontFamily: 'Symbols', fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            _searchVehiclesResult[index].vehicleClass[0],
                            style: roboto12greySemiBold,
                          ),
                          trailing: _vehicleSelected ? Icon(Icons.check, size: 24) : Icon(Icons.check, size: 0),
                          tileColor: _searchVehiclesResult[index].isPremium ? kYellow : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            setState(() {
                              if (_vehicleSelected) {
                                _selectedVehicles.remove(_searchVehiclesResult[index]);
                              } else {
                                _selectedVehicles.add(_searchVehiclesResult[index]);
                              }
                            });
                          },
                          selected: _vehicleSelected,
                          selectedTileColor: kLightGreyColor,
                        ),
                      ),
                    ],
                  );
                },
                childCount: _searchVehiclesResult.length,
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 50,
          child: FloatingActionButton.extended(
            elevation: 0,
            label: Text(localizations.compare),
            onPressed: () async {
              switch (_selectedVehicles.length) {
                case 0:
                case 1:
                  buildShowDialog(context);
                  return;
                case 2:
                  setInitValueForComparison(0, 0, 1, 1);
                  break;
                case 3:
                  setInitValueForComparison(0, 1, 2, 2);
                  break;
                default:
                  setInitValueForComparison(0, 1, 2, 3);
                  break;
              }

              await floatingButtonNavigation(context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> floatingButtonNavigation(BuildContext context) async {
    switch (_vehicleTypeValue) {
      case 0:
        final List<Plane> vehiclesForComparison = [];
        final vehiclesFromFirebase = await context.read<FirestoreProvider>().getPlanes();

        for (final item in _selectedVehicles) {
          vehiclesForComparison.add(vehiclesFromFirebase.where((element) => element.link == item.link).first);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaneComparisonScreen(receivedData: vehiclesForComparison)));
        break;

      case 1:
        final List<Tank> vehiclesForComparison = [];
        final vehiclesFromFirebase = await context.read<FirestoreProvider>().getTanks();

        for (final item in _selectedVehicles) {
          vehiclesForComparison.add(vehiclesFromFirebase.where((element) => element.link == item.link).first);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => TankComparisonScreen(receivedData: vehiclesForComparison)));
        break;

      case 2:
        final List<Heli> vehiclesForComparison = [];
        final vehiclesFromFirebase = await context.read<FirestoreProvider>().getHelis();

        for (final item in _selectedVehicles) {
          vehiclesForComparison.add(vehiclesFromFirebase.where((element) => element.link == item.link).first);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => HeliComparisonScreen(receivedData: vehiclesForComparison)));
        break;

      case 3:
        final List<Ship> vehiclesForComparison = [];
        final vehiclesFromFirebase = await context.read<FirestoreProvider>().getShips();

        for (final item in _selectedVehicles) {
          vehiclesForComparison.add(vehiclesFromFirebase.where((element) => element.link == item.link).first);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShipComparisonScreen(receivedData: vehiclesForComparison)));
        break;

      // final vehiclesFromFirebaseTest = await context.read<FirestoreProvider>().getShips();
      //
      // List<String> testList = [];
      // for(final i in vehiclesFromFirebaseTest){
      //   if(!testList.contains(i.crew)){
      //     testList.add(i.crew);
      //   }
      // }
      // List<String> testListList = [];
      // for(final i in vehiclesFromFirebaseTest){
      //   for(final k in i.features){
      //     if(!testListList.contains(k)){
      //       testListList.add(k);
      //     }
      //   }
      // }
    }
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.please_select_2_vehicles),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Center(child: const Text('OK')),
          ),
        ],
      ),
    );
  }

  void setInitValueForComparison(int i, int j, int k, int l) {
    context.read<ComparisonProvider>().setInt1Value(i);
    context.read<ComparisonProvider>().setInt2Value(j);
    context.read<ComparisonProvider>().setInt3Value(k);
    context.read<ComparisonProvider>().setInt4Value(l);
  }
}
