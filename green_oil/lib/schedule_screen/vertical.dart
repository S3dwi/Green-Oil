import 'package:flutter/material.dart';

class Vertical extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels; // List of step labels
  final List<String> stepSubtitles; // List of subtitles for each step

  const Vertical({
    super.key,
    required this.currentStep,
    required this.stepLabels,
    required this.stepSubtitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(stepLabels.length, (index) {
        final bool isActiveStep = index == currentStep;
        final bool isCompletedStep = index < currentStep;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActiveStep || isCompletedStep
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).disabledColor,
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActiveStep || isCompletedStep
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                    ),
                    if (index < stepLabels.length - 1)
                      Container(
                        width: 3.5,
                        height: 70,
                        color: isCompletedStep
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ), // Space between step indicator and text
                // Step text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stepLabels[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isActiveStep
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isActiveStep || isCompletedStep
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stepSubtitles[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: isActiveStep || isCompletedStep
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
