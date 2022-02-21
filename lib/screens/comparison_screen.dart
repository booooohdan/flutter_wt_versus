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

  bool isIntroductionNeed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isIntroductionNeed
            ? IntroductionScreen(
                pages: getPages(),
                showBackButton: true,
                back: const Icon(Icons.navigate_before),
                next: const Icon(Icons.navigate_next),
                done: Text('Done'),
                onDone: () {},
              )
            : FutureBuilder<List<Plane>>(
                future: context.read<FirestoreProvider>().getPlanes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Text('dddddddd'),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(title: Text(snapshot.data![index].link));
                          },
                          //children: snapshot.data!.docs
                        ),
                      ],
                    );
                  }
                })
        // Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text("I'm comparison screen"),
        //           ElevatedButton(
        //               child: const Text('getPlanes'),
        //               onPressed: () {
        //                 listOfVehiclesFuture = context.read<FirestoreProvider>().getPlanes();
        //                 setState(() {});
        //               }),
        //           ElevatedButton(
        //               child: const Text('getDocs'),
        //               onPressed: () {
        //                 context.read<FirestoreProvider>().getDocs();
        //                 setState(() {});
        //               }),
        //         ],
        //       ),
        );
  }
}
