import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_oil/home_screen/usage_policy_screen.dart';

void main() {
  testWidgets('UsagePolicyScreen - Back Button Navigation', (WidgetTester tester) async {
    // Create a MaterialApp with UsagePolicyScreen as the home screen
    await tester.pumpWidget(MaterialApp(
      home: UsagePolicyScreen(),
    ));

    // Verify the UsagePolicyScreen is displayed
    expect(find.text('Usage Policy'), findsOneWidget);

    // Tap the back button in the AppBar
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    // After tapping the back button, ensure the screen pops off the navigator stack
    expect(find.text('Usage Policy'), findsNothing);  // Should no longer be visible
  });
}
