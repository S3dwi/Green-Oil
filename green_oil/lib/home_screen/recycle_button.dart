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
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recycle Your Oil Now!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Schedule your used oil pickup in seconds",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.onSecondary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
