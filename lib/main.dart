import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../providers/firestore_provider.dart';
import '../screens/comparison_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirestoreProvider>(
          create: (_) => FirestoreProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'WT Versus',
        theme: ThemeData(brightness: Brightness.light),
        routes: {
          '/': (context) => const ComparisonScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
