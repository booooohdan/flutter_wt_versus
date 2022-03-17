import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/providers/google_signin_provider.dart';
import 'package:wt_versus/screens/signup_screen.dart';
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
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (_) => GoogleSignInProvider(),
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
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return BottomNavBar();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went Wrong!'));
            } else {
              return SignUpScreen();
            }
          },
        ), //BottomNavBar(),
      ),
    ),
  );
}
