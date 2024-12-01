import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/recycle_oil_screen/quantity_selector.dart';

void main() {
  testWidgets('Quantity Selector - Verify Initial Value', (WidgetTester tester) async {
    // Build the QuantitySelector widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: QuantitySelector(
          quantity: 10.0,
          controller: TextEditingController(),
          onIncrement: () {},
          onDecrement: () {},
          onSubmitted: (String value) {},
        ),
      ),
    ));

    // Verify the initial value is displayed correctly
    expect(find.text('10.00'), findsOneWidget);
  });
}
