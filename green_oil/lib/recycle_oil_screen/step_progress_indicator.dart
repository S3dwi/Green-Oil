// components/step_progress_indicator.dart
import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: index <= currentStep ? Colors.green : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index <= currentStep ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
            if (index < totalSteps - 1)
              Container(
                width: 70,
                height: 2,
                color: index < currentStep ? Colors.green : Colors.grey[300],
              ),
          ],
        );
      }),
    );
  }
}
