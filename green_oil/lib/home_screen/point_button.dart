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
        elevation: 20,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 187, 16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.eco, // Leaf icon
            color: Theme.of(context).primaryColor,
            size: 40, // Increased icon size
          ),
          const SizedBox(width: 10), // Spacing between the icon and the text
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns text to the left
            children: [
              const Text(
                'Your Points',
                style: TextStyle(
                  fontSize: 16, // Slightly larger for emphasis
                  fontWeight: FontWeight.bold, // Bold black text
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
    );
  }
}

//     Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(12),
//       width: double.infinity, // Full width of the screen
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5), // Increased shadow opacity
//             spreadRadius: 4, // Increased spread radius
//             blurRadius: 8, // Increased blur radius
//             offset: const Offset(0, 4), // Adjusted shadow position
//           ),
//         ],
//       ),

//     );

