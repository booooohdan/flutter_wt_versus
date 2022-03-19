import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/plane.dart';
import '../providers/firestore_provider.dart';
import '../utilities/constants.dart';
import 'plane_comparison_screen.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool _isFirstInit = false;
  int? _groupValue = 0;

  List<Plane> _selectedVehicles = [];
  List<Plane> _allResults = [];
  List<Plane> _searchResult = [];
  final _searchController = TextEditingController();

  void _onSearchChanged() {
    List<Plane> showResult = [];
    if (_searchController.text != '') {
      for (var item in _allResults) {
        final name = item.name.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(item);
        }
      }
    } else {
      showResult = _allResults;
    }
    setState(() {
      _searchResult = showResult;
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
      _allResults = await context.watch<FirestoreProvider>().getPlanes();
      _searchResult = _allResults;
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
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: appbarSize * 3,
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
                          backgroundColor: kDarkGreyColor,
                          thumbColor: kLightGreyColor,
                          groupValue: _groupValue,
                          padding: EdgeInsets.all(8),
                          children: {
                            0: Container(
                              child: Text(
                                localizations.planes,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            1: Container(
                              child: Text(
                                localizations.army,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            2: Container(
                              child: Text(
                                localizations.heli,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            3: Container(
                              child: Text(
                                localizations.fleet,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Planes: ',
                            style: theme.textTheme.caption,
                          ),
                          Text(
                            _searchResult.length.toString(),
                            style: theme.textTheme.caption,
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
                      SizedBox(width: 16),
                      CupertinoButton(
                        child: Icon(Icons.tune),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            labelStyle: TextStyle(color: Colors.white),
                            suffixIcon: Icon(Icons.search),
                            suffixIconColor: Colors.white,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectedVehicles.clear();
                          setState(() {});
                        },
                        child: Text(
                          'Clear',
                          style: theme.textTheme.button,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final _vehicleSelected = _selectedVehicles.contains(_searchResult[index]);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            child: SvgPicture.asset(
                              'assets/icons/${_searchResult[index].nation}.svg',
                              height: screenSize.height / 20,
                            ),
                          ),
                          title: Text('[${_searchResult[index].BRs[1]}] ${_searchResult[index].name}'),
                          subtitle: Text(_searchResult[index].nation),
                          trailing: _vehicleSelected ? Icon(Icons.check) : Icon(Icons.check, size: 0),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            setState(() {
                              if (_vehicleSelected) {
                                _selectedVehicles.remove(_searchResult[index]);
                              } else {
                                _selectedVehicles.add(_searchResult[index]);
                              }
                            });
                          },
                          selected: _vehicleSelected,
                        ),
                      ),
                    ],
                  );
                },
                childCount: _searchResult.length,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          icon: Icon(Icons.image),
          label: Text(localizations.compare), //TODO: Add counter of selected vehicles
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaneComparisonScreen(receivedData: _selectedVehicles)),
            );
          },
        ),
      ),
    );
  }
}
