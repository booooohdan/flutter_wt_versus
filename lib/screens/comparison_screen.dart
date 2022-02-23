import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/models/plane.dart';
import 'package:wt_versus/providers/firestore_provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({Key? key}) : super(key: key);

  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
          title: 'Welcome',
          body: 'to War Thunder Versus 3',
          decoration: PageDecoration()),
      PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: 'All vehicles available',
        body: 'Even a bombers and boats. Premium, rare, platform exclusive, deleted vehicle, all of them in the app',
      ),
      PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: "It's not final data",
        body: 'Another characteristics will be add some later, approximately at this spring',
      ),
    ];
  }

  bool _isFirstLaunch = false;
  List<bool> _toggleButtons = [false, false, false, false];
  List<String> _selectedVehicles = [];
  final _searchController = TextEditingController();
  List<Plane> _allResults = [];
  List<Plane> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

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
    setState(() {_searchResult = showResult;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _allResults = await context.watch<FirestoreProvider>().getPlanes();
    _searchResult = _allResults;
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Please select vehicles to compare',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        shadowColor: Colors.red,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
      ),
      body: _isFirstLaunch
          ? IntroductionScreen(
              pages: getPages(),
              showBackButton: true,
              back: const Icon(Icons.navigate_before),
              next: const Icon(Icons.navigate_next),
              done: Text('Done'),
              onDone: () {},
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ToggleButtons(
                    children: [
                      Icon(Icons.airplanemode_active),
                      Icon(Icons.agriculture),
                      Icon(Icons.not_accessible),
                      Icon(Icons.directions_boat),
                    ],
                    isSelected: _toggleButtons,
                    constraints: BoxConstraints(minWidth: (screenSize.width - 36) / 4),
                    borderRadius: BorderRadius.circular(30),
                    onPressed: (int index) {
                      setState(() {
                        _toggleButtons = [false, false, false, false];
                        _toggleButtons[index] = true;
                      });
                    },
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('Filter')),
                      SizedBox(width: 30),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {},
                          decoration: const InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        final _vehicleSelected = _selectedVehicles.contains(_searchResult[index].link);
                        return ListTile(
                          leading: Container(
                            height: 50,
                            child: Image.network(
                              _searchResult[index].image,
                              fit: BoxFit.cover,
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
                                _selectedVehicles.remove(_searchResult[index].link);
                              } else {
                                _selectedVehicles.add(_searchResult[index].link);
                              }
                            });
                          },
                          selected: _vehicleSelected,
                        );
                      },
                      //children: snapshot.data!.docs
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          elevation: 0,
          icon: Icon(Icons.image),
          label: Text('Compare'),
          onPressed: () {},
        ),
      ),
    );
  }
}
