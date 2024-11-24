import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantitySelector extends StatelessWidget {
  final double quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    controller.text =
        quantity.toStringAsFixed(2); // Display as a fixed 2 decimal point

    return Center(
      child: Container(
        height: 90, // Adjust height to accommodate extra text
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 45),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Minus Button
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove_circle),
              color: Theme.of(context).disabledColor,
              iconSize: 58,
              padding: EdgeInsets.all(0),
            ),

            // Editable Quantity Display with Additional Text
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Quantity Text Field
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onSubmitted: onSubmitted, // Call validation on submit
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                ),

                // Additional Text
                Text(
                  "1 Liter (L) = 1 SR",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // Plus Button
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add_circle),
              color: Theme.of(context).colorScheme.primary,
              iconSize: 58,
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
