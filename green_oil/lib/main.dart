import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  cardColor: const Color(0xFFFFFFFF),
  primaryColor: const Color(0xFF47AB4D),
  disabledColor: const Color(0xFFA9A9AC),
  fontFamily: 'Lato',
  shadowColor: Colors.black.withOpacity(0.24),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF47AB4D),
  ),
  iconTheme: IconThemeData(
    color: const Color(0xFF47AB4D), 
  ),
);

final colorScheme = ColorScheme(
  primary: Color(0xFF47AB4D), // Main color used for primary interactive elements
  primaryContainer: Color(0xFF388E3C), // Variant of primary (lighter or darker), used for contrast on surfaces
  secondary: Color(0xFF000000), // Accent color for secondary UI components
  surface: Color(0xFFFFFFFF), // Color for surfaces like cards and sheets
  error: Colors.red, // Error color for showing validation issues
  
  onPrimary: Colors.white, // Text/icon color on primary-colored backgrounds
  onSecondary: Colors.white, // Text/icon color on secondary-colored backgrounds
  onSurface: Colors.black, // Text/icon color on surface backgrounds
  onError: Colors.white, // Text/icon color on error backgrounds
  brightness: Brightness.light, // Theme brightness: light or dark
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
