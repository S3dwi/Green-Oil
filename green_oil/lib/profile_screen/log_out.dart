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
      height: 85,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 6,
          shadowColor: Theme.of(context).shadowColor,
          color: Theme.of(context).cardColor,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  "Log out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
