import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/profile_screen/account_detail_card.dart';
import 'package:green_oil/profile_screen/edit_profile_screen.dart';
import 'package:green_oil/profile_screen/help_center.dart';
import 'package:green_oil/profile_screen/log_out.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil/support_screen/support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('provider')
            .doc(firebaseUser.uid)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;
          setState(() {
            userName = userData['Name'] ?? "No Name provided";
            userEmail = userData['Email'] ?? "No email provided";
            userPhone = userData['Phone'] ?? "No phone number provided";
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error fetching user data: $e'),
            ),
          );
        }
      }
    }
  }

  void helpCenter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SupportScreen(),
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 310,
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
                      const Positioned(
                        top: 65,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/profile_picture.png'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 35,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                          iconSize: 36,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Positioned(
                        bottom: 65,
                        child: Text(
                          userName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 18,
                  left: 18,
                  child: AccountDetailCard(
                    label: "Name",
                    value: userName,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          AccountDetailCard(
            label: "Email",
            value: userEmail,
          ),
          const SizedBox(
            height: 10,
          ),
          AccountDetailCard(
            label: "Phone Number",
            value: userPhone,
          ),
          const SizedBox(
            height: 30,
          ),
          HelpCenter(
            onTap: () {
              helpCenter(context);
            },
          ),
          const SizedBox(
            height: 6,
          ),
          LogOut(
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}
