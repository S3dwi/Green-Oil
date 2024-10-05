import 'package:flutter/material.dart';
import 'package:green_oil/profile_screen/account_detail_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 330,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff5EAF63),
                            Color(0xff6db571),
                            Color(0xff8dc491),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/home_img.png'),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'RAEF SHAH'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
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
                height: 10,
              ),
              const AccountDetailCard(
                label: "Name",
                value: "RAEF ATEF SHAH",
              ),
              const SizedBox(
                height: 10,
              ),
              const AccountDetailCard(
                label: "Name",
                value: "RAEF ATEF SHAH",
              ),
              const SizedBox(
                height: 10,
              ),
              const AccountDetailCard(
                label: "Name",
                value: "RAEF ATEF SHAH",
              ),
              const SizedBox(
                height: 10,
              ),
              const AccountDetailCard(
                label: "Name",
                value: "RAEF ATEF SHAH",
              ),
              const SizedBox(
                height: 10,
              ),
              const AccountDetailCard(
                label: "Name",
                value: "RAEF ATEF SHAH",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
