import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/profile_screen/account_detail_card.dart';
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

    // Navigate to the initial route without async gaps
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  // void fetchInfo() async {
  //   final firebaseUser = FirebaseAuth.instance.currentUser;

  //   if (firebaseUser != null) {
  //     await FirebaseFirestore.instance
  //         .collection('provider')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then(
  //       (value) {
  //         email = value.data['email'];
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 330,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 290,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 82, 156, 87),
                          Color(0xff6db571),
                          Color.fromARGB(255, 161, 213, 164),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        const Positioned(
                          top: 56,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                AssetImage('assets/images/home_img.png'),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          left: 10,
                          top: 36,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.language),
                                iconSize: 40,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit_outlined),
                                iconSize: 36,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 60,
                          child: Text(
                            'RAEF SHAH'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 18,
                    left: 18,
                    child: AccountDetailCard(
                      label: "Name",
                      value: "Raef Atef Shah",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const AccountDetailCard(
              label: "Email",
              value: "RaefAshah@gmail.com",
            ),
            const SizedBox(
              height: 10,
            ),
            const AccountDetailCard(
              label: "Phone Number",
              value: "0505406458",
            ),
            const SizedBox(
              height: 50,
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
      ),
    );
  }
}
