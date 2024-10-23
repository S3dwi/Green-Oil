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
              height: 320,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
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
                        const Positioned(
                          top: 55,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage:
                                AssetImage('assets/images/home_img.png'),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          left: 10,
                          top: 30,
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
                                icon: const Icon(Icons.edit),
                                iconSize: 40,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 65,
                          child: Text(
                            'RAEF SHAH'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    bottom: 5,
                    right: 18.2,
                    left: 18.2,
                    child: AccountDetailCard(
                      label: "Name",
                      value: "RAEF ATEF SHAH",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
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
              height: 10,
            ),
            const AccountDetailCard(
              label: "Location",
              value: "Saudi Arabia, Jeddah",
            ),
            const SizedBox(
              height: 25,
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
