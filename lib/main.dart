import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/widgets/bottom_navigation_bar.dart';

import '../providers/firestore_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xFF0000FF)));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirestoreProvider>(
          create: (_) => FirestoreProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'WT Versus',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
          ),
          textTheme: TextTheme(
            button: GoogleFonts.oxygen(fontSize: 14, color: Colors.yellow, fontWeight: FontWeight.bold),
            headline1: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
          ),
          scaffoldBackgroundColor: Color(0xFFDCDCDC),
        ),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      ),
    ),
  );
}
