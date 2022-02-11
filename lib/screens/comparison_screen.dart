import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/providers/firestore_provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({Key? key}) : super(key: key);

  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  Future<List<String>>? listOfVehiclesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("I'm comparison screen"),
          ElevatedButton(
              child: const Text('Test'),
              onPressed: () {
                listOfVehiclesFuture = context.read<FirestoreProvider>().getPlanes();
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('Test cahce'),
              onPressed: () {
                context.read<FirestoreProvider>().getDocs();
                setState(() {});
              }),
        ],
      ),
    );
  }
}
