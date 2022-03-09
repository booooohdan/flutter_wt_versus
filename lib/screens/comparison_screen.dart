import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  int? groupValue = 0;

  //List<bool> _toggleButtons = [false, false, false, false];
  List<String> _selectedVehicles = [];
  final _searchController = TextEditingController();
  List<Plane> _allResults = [];
  List<Plane> _searchResult = [];

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
    final screenSize = MediaQuery.of(context).size;
    final appbarSize = AppBar().preferredSize.height;
    return Scaffold(
      body: SafeArea(
        child: _isFirstLaunch
            ? IntroductionScreen(
                pages: getPages(),
                showBackButton: true,
                back: const Icon(Icons.navigate_before),
                next: const Icon(Icons.navigate_next),
                done: Text('Done'),
                onDone: () {},
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                    automaticallyImplyLeading: false,
                    expandedHeight: appbarSize*3,
                    floating: true,
                    snap: true,
                    pinned: true,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('https://cdn.pixabay.com/photo/2017/06/09/10/40/colour-2386473_960_720.jpg'), fit: BoxFit.fill),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            CupertinoSlidingSegmentedControl<int>(
                              backgroundColor: CupertinoColors.white,
                              thumbColor: Theme.of(context).colorScheme.primary,
                              groupValue: groupValue,
                              children: {
                                0: Container(
                                  child: Text(
                                    "Aviation",
                                    style: TextStyle(fontSize: 22, color: Colors.black),
                                  ),
                                ),
                                1: Container(
                                  child: Text(
                                    "Army",
                                    style: TextStyle(fontSize: 22, color: Colors.black),
                                  ),
                                ),
                                2: Container(
                                  child: Text(
                                    "Ships",
                                    style: TextStyle(fontSize: 22, color: Colors.black),
                                  ),
                                ),
                              },
                              onValueChanged: (value) {
                                setState(() {
                                  groupValue = value;
                                });
                              },
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Planes: ',
                                  style: TextStyle(color: Colors.white, fontSize: 30),
                                ),
                                Text(
                                  '640',
                                  style: TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(appbarSize),
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          ElevatedButton(onPressed: () {}, child: Text('Filter',style: TextStyle(color: Colors.white),)),
                          SizedBox(width: 30),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
                  // SliverFillRemaining(
                  //   child: Column(
                  //     children: [
                  //
                  //       Expanded(
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: _searchResult.length,
                  //           itemBuilder: (context, index) {
                  //             final _vehicleSelected = _selectedVehicles.contains(_searchResult[index].link);
                  //             return ListTile(
                  //               leading: Container(
                  //                 height: 50,
                  //                 child: SvgPicture.asset(
                  //                   'assets/icons/${_searchResult[index].nation}.svg',
                  //                   height: screenSize.height / 20,
                  //                 ),
                  //               ),
                  //               title: Text('[${_searchResult[index].BRs[1]}] ${_searchResult[index].name}'),
                  //               subtitle: Text(_searchResult[index].nation),
                  //               trailing: _vehicleSelected ? Icon(Icons.check) : Icon(Icons.check, size: 0),
                  //               tileColor: Colors.white,
                  //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  //               onTap: () {
                  //                 setState(() {
                  //                   if (_vehicleSelected) {
                  //                     _selectedVehicles.remove(_searchResult[index].link);
                  //                   } else {
                  //                     _selectedVehicles.add(_searchResult[index].link);
                  //                   }
                  //                 });
                  //               },
                  //               selected: _vehicleSelected,
                  //             );
                  //           },
                  //           //children: snapshot.data!.docs
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final _vehicleSelected = _selectedVehicles.contains(_searchResult[index].link);
                        return Padding(
                          padding: const EdgeInsets.all(8),
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
                                  _selectedVehicles.remove(_searchResult[index].link);
                                } else {
                                  _selectedVehicles.add(_searchResult[index].link);
                                }
                              });
                            },
                            selected: _vehicleSelected,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        icon: Icon(Icons.image),
        label: Text('Compare'),
        onPressed: () {},
      ),
    );
  }
}
