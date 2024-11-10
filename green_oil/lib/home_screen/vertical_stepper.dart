// components/vertical_step_progress.dart
import 'package:flutter/material.dart';

class VerticalStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const VerticalStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(totalSteps, (index) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 25, // Increased width for outer circle
                  height: 25, // Increased height for outer circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: index <= currentStep
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 15, // Increased width for inner circle
                  height: 15, // Increased height for inner circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index <= currentStep
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor,
                  ),
                ),
              ],
            ),
            if (index < totalSteps - 1)
              Container(
                width: 3.5,
                height: 90,
                color: index < currentStep
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
              ),
          ],
        );
      }),
    );
  }
}
