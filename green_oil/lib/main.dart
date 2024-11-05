import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  cardColor: const Color(0xFFFFFFFF),
  // Primary color used for elements like buttons and icon.
  primaryColor: const Color(0xFF47AB4D),
  disabledColor: const Color(0xFFA9A9AC),
  fontFamily: 'Lato',
  shadowColor: Colors.black.withOpacity(0.9),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (fn) {
      runApp(const App());
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      themeMode: ThemeMode.system,
      home: const SignInScreen(),
    );
  }
}
