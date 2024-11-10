import 'package:flutter/material.dart';

class SigninSignup extends StatelessWidget {
  const SigninSignup({
    super.key,
    required this.onPressed,
    required this.child,
    required this.vertical,
    required this.horizontal,
  });

  final void Function() onPressed;
  final double vertical;
  final double horizontal;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: child,
    );
  }
}
