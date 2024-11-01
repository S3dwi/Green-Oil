import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 80,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 4,
          shadowColor: Theme.of(context).shadowColor,
          color: Theme.of(context).cardColor,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Text(
                  "Log out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.logout,
                  size: 27,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
