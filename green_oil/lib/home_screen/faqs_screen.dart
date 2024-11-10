import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "FAQs",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        centerTitle: true, // Center the title text, if needed
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Image.asset(
            'assets/icon/logoWithTitle.png',
          ),
          // Add a Center widget containing the Green Oil logo here, if needed.

          Expanded(
            child: ListView(
              children: [
                // FAQ Item 1
                // Add an expansion panel or list tile for "How does GreenOil work?"

                Divider(),

                // FAQ Item 2
                // Add an expansion panel or list tile for "What types of used oil can I sell?"

                Divider(),

                // FAQ Item 3
                // Add an expansion panel or list tile for "How much can I earn?"

                Divider(),

                // FAQ Item 4
                // Add an expansion panel or list tile for "Is there a minimum quantity?"

                Divider(),

                // FAQ Item 5
                // Add an expansion panel or list tile for "Is my information safe?"

                Divider(),

                // FAQ Item 6
                // Add an expansion panel or list tile for "How do I get paid?"
              ],
            ),
          ),
        ],
      ),
    );
  }
}
