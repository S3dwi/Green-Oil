import 'package:flutter/material.dart';

class PointButton extends StatefulWidget {
  const PointButton({super.key});

  @override
  State<PointButton> createState() {
    return _PointButtonState();
  }
}

class _PointButtonState extends State<PointButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.fromLTRB(
            20, 16, 20, 16), // Adjusted padding to balance the arrow icon
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Ensure the icon is aligned to the far right
        children: [
          // Icon and Text on the left
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.eco, // Leaf icon
                color: Theme.of(context).primaryColor,
                size: 40, // Icon size
              ),
              const SizedBox(
                  width: 10), // Spacing between the icon and the text
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns text to the left
                children: [
                  const Text(
                    'Your Points',
                    style: TextStyle(
                      fontSize: 16, // Slightly larger for emphasis
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                      height: 2), // Reduced space between text and points
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '20',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '/200',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Arrow icon on the right
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black, // You can adjust the color if needed
            size: 16, // Same size as in RecycleButton
          ),
        ],
      ),
    );
  }
}
