import 'package:flutter/material.dart';
import 'package:green_oil/support_screen/delete_account.dart';
import 'package:green_oil/support_screen/help_card.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 340,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.surfaceContainer,
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        left: 0,
                        top: 40,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Positioned(
                        top: 42,
                        child: Text(
                          "Help Center",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        child: HelpCard(
                          onTap: () {},
                          titel: "Forgot My Password",
                          description: "Restore your password",
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: HelpCard(
                    onTap: () {},
                    titel: "Send us an E-mail",
                    description: "Contact us via email",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          HelpCard(
            onTap: () {},
            titel: "Contact Live Chat",
            description: "Live chat support",
          ),
          const SizedBox(height: 50),
          DeleteAccount(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
