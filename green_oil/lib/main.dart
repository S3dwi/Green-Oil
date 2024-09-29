import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/home_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
