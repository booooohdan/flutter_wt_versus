import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/providers/firestore_provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({Key? key}) : super(key: key);

  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  Future<List<String>>? listOfVehiclesFuture;

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: 'Title test sample',
        body: 'Body test sample',
      ),
      PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: 'Title test sample 2',
        body: 'Body test sample 2',
      ),
      PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: 'Title test sample 3',
        body: 'Body test sample 3',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: Text(
          'Done',
          //style: TextStyle(color: Colors.black),
        ),
        onDone: () {},
        pages: getPages(),
        globalBackgroundColor: Colors.white,
        showBackButton: true,
        back: const Icon(Icons.navigate_before),
        next: const Icon(Icons.navigate_next),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text("I'm comparison screen"),
      //     ElevatedButton(
      //         child: const Text('Test'),
      //         onPressed: () {
      //           listOfVehiclesFuture = context.read<FirestoreProvider>().getPlanes();
      //           setState(() {});
      //         }),
      //     ElevatedButton(
      //         child: const Text('Test cahce'),
      //         onPressed: () {
      //           context.read<FirestoreProvider>().getDocs();
      //           setState(() {});
      //         }),
      //   ],
      // ),
    );
  }
}
