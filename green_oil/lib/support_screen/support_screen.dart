import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil/support_screen/change_password_screen.dart';
import 'package:green_oil/support_screen/delete_account.dart';
import 'package:green_oil/support_screen/help_card.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SupportScreenState();
  }
}

class _SupportScreenState extends State<SupportScreen> {
  void _sendEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'xxazooozeexx@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Green Oil',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  void _openWhatsApp() async {
    Uri whatsappUrl = Uri.parse("https://wa.me/9660505406459");

    launchUrl(whatsappUrl);
  }

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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(),
                              ),
                            );
                          },
                          titel: "Change My Password",
                          description: "Restore your password",
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: HelpCard(
                    onTap: _sendEmail,
                    titel: "Send us an E-mail",
                    description: "Contact us via email",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          HelpCard(
            onTap: _openWhatsApp,
            titel: "Contact us on WhatsApp",
            description: "Contact us via WhatsApp",
          ),
          // const SizedBox(height: 10),
          // HelpCard(
          //   onTap: () {},
          //   titel: "Contact Live Chat",
          //   description: "Live chat support",
          // ),
          const SizedBox(height: 50),
          DeleteAccount(
            onTap: _deleteUserAccount,
          ),
        ],
      ),
    );
  }

  void _deleteUserAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel Button (Outlined)
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // Spacing between buttons

                  // Delete Account Button
                  ElevatedButton(
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        final userDocRef = FirebaseFirestore.instance
                            .collection('provider')
                            .doc(user.uid);
                        try {
                          await userDocRef.delete();

                          try {
                            await user.delete();
                            if (mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            }
                          } catch (authError) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to delete user authentication.',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (firestoreError) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to delete user data.'),
                              ),
                            );
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
