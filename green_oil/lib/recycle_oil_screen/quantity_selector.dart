import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantitySelector extends StatelessWidget {
  final double quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final TextEditingController controller;
  final Function(String) onSubmitted;

  QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = quantity.toStringAsFixed(0);

    return Center(
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 45),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Minus Button
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove_circle),
              color: const Color.fromARGB(117, 158, 158, 158),
              iconSize: 58,
              padding: EdgeInsets.all(0),
            ),

            // Editable Quantity Display
            SizedBox(
              width: 60,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w500,
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

            // Plus Button
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add_circle),
              color: Colors.green,
              iconSize: 58,
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
