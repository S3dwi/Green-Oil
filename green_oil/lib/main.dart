import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:green_oil/sign_up_screen/verify_email_screen.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil/app_theme.dart';
import 'package:green_oil/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      // StreamBuilder monitors auth state, navigating based on email verification=
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              return FutureBuilder(
                future: user.reload(),
                builder: (context, futureSnapshot) {
                  if (user.emailVerified) {
                    return const NavBar(wantedPage: 0);
                  } else {
                    return const VerifyEmailScreen();
                  }
                },
              );
            }
          }

          return const SignInScreen();
        },
      ),
    );
  }
}
