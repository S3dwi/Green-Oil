import 'package:flutter/material.dart';
import 'package:green_oil/profile_screen/account_detail_card.dart';
import 'package:green_oil/profile_screen/help_center.dart';
import 'package:green_oil/profile_screen/log_out.dart';
import 'package:green_oil/support_screen/support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void helpCenter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SupportScreen(),
      ),
    );
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
            // const SizedBox(
            //   height: 10,
            // ),
            // const AccountDetailCard(
            //   label: "Password",
            //   value: "***************",
            // ),
            const SizedBox(
              height: 6,
            ),
            const AccountDetailCard(
              label: "Location",
              value: "Saudi Arabia, Jeddah",
            ),
            const SizedBox(
              height: 32,
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
