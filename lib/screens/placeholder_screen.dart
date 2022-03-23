import 'package:flutter/material.dart';
import 'package:wt_versus/utilities/constants.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Page under development',
              style: roboto22blackBold,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                "Unfortunately, we didn't have much time to complete this page, as we often hear airstrike alarm and go down to the bomb shelter, but we'll be sure to add this page in future updates. \nWe hope for victory and peace 🇺🇦",
                style: roboto14blackBold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
