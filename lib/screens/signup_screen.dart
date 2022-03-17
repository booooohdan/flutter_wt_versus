import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/providers/google_signin_provider.dart';

import '../providers/firestore_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(child: FlutterLogo(size: 120)),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey There,\nWelcome back',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<GoogleSignInProvider>().googleLogin();
                      },
                      icon: FaIcon(FontAwesomeIcons.google),
                      label: Text('Sign Up with Google'),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     context.read<GoogleSignInProvider>().AnonymousSignIn();
                    //   },
                    //   icon: FaIcon(FontAwesomeIcons.google),
                    //   label: Text('Sign Up as Guest'),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
