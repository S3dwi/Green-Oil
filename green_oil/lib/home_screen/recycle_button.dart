import 'package:flutter/material.dart';

class RecycleButton extends StatelessWidget {
  const RecycleButton({
    super.key,
    required this.onRecycleOil,
  });

  final void Function() onRecycleOil;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onRecycleOil();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Colors.black.withOpacity(0.9), // Shadow color
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
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
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
