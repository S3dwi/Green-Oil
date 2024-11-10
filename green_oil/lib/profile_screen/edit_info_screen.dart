import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/profile_screen/account_detail_card.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

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
                          top: 80,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage: AssetImage(
                              'assets/images/home_img.png',
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
                      value: "ssss",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AccountDetailCard(
              label: "Phone Number",
              value: "ssss",
            ),
            const SizedBox(
              height: 50,
            ),
            PrimaryButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: "Save",
              vertical: 13,
              horizontal: 145,
            )
          ],
        ),
      ),
    );
  }
}
