import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Title for the FAQ section
          Text(
            "FAQs",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // Logo section
          const SizedBox(height: 24),
          Image.asset(
            'assets/icon/logo.png',
            height: 60,
            width: 60,
          ),
          const SizedBox(height: 16), // Space between logo and FAQ items

          Expanded(
            child: ListView(
              children: const [
                FAQItem(
                  title: "How does GreenOil work?",
                  description:
                      "Simple! List your used oil, wait for a buyer, and schedule a pickup.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                FAQItem(
                  title: "What types of used oil can I sell?",
                  description:
                      "Currently, we primarily support used cooking oil. We plan to expand our services to include other types of used oil soon.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                FAQItem(
                  title: "How much can I earn?",
                  description:
                      "The price depends on market demand and the buyer's offer.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                FAQItem(
                  title: "Is there a minimum quantity?",
                  description:
                      "Yes, there is a minimum quantity of 10 liters required for pickup. Please ensure you meet this requirement to proceed with your listing.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                FAQItem(
                  title: "Is my information safe?",
                  description:
                      "Yes, we prioritize your privacy and protect your information.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                FAQItem(
                  title: "How do I get paid?",
                  description:
                      "You will receive payment directly from the buyer through a method agreed upon by both parties. GreenOil may facilitate the payment process, but the final transaction is between you and the buyer.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// Inner class for Accordion component
class FAQItem extends StatelessWidget {
  final String title;
  final String description;

  const FAQItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      collapsedShape: const RoundedRectangleBorder(),
      shape: const RoundedRectangleBorder(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ), // Add extra space between description and divider
      ],
    );
  }
}
