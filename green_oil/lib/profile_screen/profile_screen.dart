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
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String companyName = "";
  String userEmail = "";
  String userPhone = "";
  String userImageUrl = "";

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
            companyName = userData['Company Name'] ?? "No company provided";
            userEmail = userData['Email'] ?? "No email provided";
            userPhone = userData['Phone'] ?? "No phone number provided";
            userImageUrl =
                userData['image_url'] ?? 'assets/images/profile_picture.png';
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
              const Text('Log Out'),
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
                'Are you sure you want to log out?',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 20),
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
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(width: 12), // Reduced space between buttons

                  // Log Out Button
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close the dialog
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 17,
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

  
  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 320,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 290,
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
                          top: 55,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage: isValidUrl(userImageUrl.trim())
                                ? NetworkImage(userImageUrl)
                                : AssetImage(
                                        'assets/images/profile_picture.png')
                                    as ImageProvider,
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
              label: "Company Name",
              value: companyName,
            ),
            const SizedBox(
              height: 10,
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
              height: 10,
            ),
            HelpCenter(
              onTap: () {
                helpCenter(context);
              },
            ),
            const SizedBox(
              height: 10,
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
