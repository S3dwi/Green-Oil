import 'package:flutter/material.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  // Builds a card UI that displays a "Delete My Account" button.
  // The card has a shadow, custom padding, and a bold red label.
  // When tapped, it triggers the provided [onTap] function.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 85,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 6,
          shadowColor: Theme.of(context).shadowColor,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delete My Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Are you sure?",
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.close,
                  size: 15,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
