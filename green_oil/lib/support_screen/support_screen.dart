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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff5EAF63),
                        Color(0xff6db571),
                        Color(0xff8dc491),
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
                          color: Colors.black,
                        ),
                      ),
                      const Positioned(
                        top: 42,
                        child: Text(
                          "Help Center",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
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
          const SizedBox(
            height: 10,
          ),
          HelpCard(
            onTap: () {},
            titel: "Contact Live Chat",
            description: "Live chat support",
          ),
          const SizedBox(
            height: 10,
          ),
          HelpCard(
            onTap: () {},
            titel: "FAQs",
            description: "Look for the answers of your questions",
          ),
          const SizedBox(
            height: 50,
          ),
          DeleteAccount(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
