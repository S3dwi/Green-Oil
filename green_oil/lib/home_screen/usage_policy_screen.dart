import 'package:flutter/material.dart';

class UsagePolicyScreen extends StatelessWidget {
  const UsagePolicyScreen({super.key});

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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns content to the left
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    "Usage Policy",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/icon/logo.png',
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const PolicyItem(
              title: "1. User Agreement",
              description: "By using GreenOil, you agree to our policies.",
            ),
            const Divider(),
            const PolicyItem(
              title: "2. Service Fees",
              description: "We may charge a nominal fee for our services.",
            ),
            const Divider(),
            const PolicyItem(
              title: "3. User Responsibility",
              description: "Ensure accurate listing information.",
            ),
            const Divider(),
            const PolicyItem(
              title: "4. Intellectual Property",
              description: "All rights belong to GreenOil.",
            ),
            const Divider(),
            const PolicyItem(
              title: "5. Disclaimer",
              description:
                  "The platform is provided \"as is\" without warranties.",
            ),
            const Divider(),
            const PolicyItem(
              title: "6. Privacy Policy",
              description:
                  "We respect your privacy and handle your data with care.",
            ),
          ],
        ),
      ),
    );
  }
}

// Inner class for each policy item
class PolicyItem extends StatelessWidget {
  final String title;
  final String description;

  const PolicyItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Consistent padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
