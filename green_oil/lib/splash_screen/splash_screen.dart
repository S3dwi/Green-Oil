import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          // Check if the widget is still in the tree
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Tabs(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5, // Dim the background image
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash_img.png'),
                  // Ensures the image covers the entire screen
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icon/logo.png'),
                //SvgPicture.asset('assets/images/logo.svg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
