import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../providers/firestore_provider.dart';
import '../providers/google_signin_provider.dart';
import '../screens/signup_screen.dart';
import '../widgets/bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
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
            //FirebaseCrashlytics.instance.crash();
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
