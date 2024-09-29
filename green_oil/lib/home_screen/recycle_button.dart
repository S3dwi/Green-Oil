import 'package:flutter/material.dart';

class RecycleButton extends StatelessWidget {
  const RecycleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recycle Your Oil Now!",
                style: TextStyle(
                  color: Color(0xFFF8F8F8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Schedule your used oil pickup in seconds",
                style: TextStyle(
                  color: Color(0xFFF8F8F8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFF8F8F8),
            size: 16,
          ),
        ],
      ),
    );
  }
}
