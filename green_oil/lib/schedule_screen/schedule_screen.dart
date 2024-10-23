import 'package:flutter/material.dart';
import 'package:green_oil/schedule_screen/order_switcher.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Schedule",
              style: TextStyle(
                  //* TO BE CHANGED TO THEME LATER
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: OrderSwitcher(),
            ),
          ],
        ),
      ),
    );
  }
}
