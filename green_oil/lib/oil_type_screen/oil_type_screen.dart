import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';

class OilTypeScreen extends StatelessWidget {
  const OilTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: const Text(
          "Oil Type",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              PrimaryButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).disabledColor,
                label: "NEXT",
                horizontal: 145,
                vertical: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
