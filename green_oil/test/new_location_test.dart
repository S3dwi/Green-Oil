import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/new_location.dart';

void main() {
  testWidgets('NewLocation - Render and Close Button Test',
      (WidgetTester tester) async {
    // Build the NewLocation widget within a MaterialApp for context
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewLocation(),
      ),
    ));

    // Verify the title is displayed
    expect(find.text("Choose your delivery address"), findsOneWidget);

    // Verify the close button is displayed
    final closeButton = find.byIcon(Icons.close);
    expect(closeButton, findsOneWidget);

    // Tap the close button
    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    // Verify the close button action (Navigator.pop)
    expect(find.byType(NewLocation), findsNothing);
  });
}
