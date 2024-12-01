import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_oil/home_screen/Location/map_screen.dart';

void main() {
  testWidgets('MapScreen - Verify Basic Map Rendering', (WidgetTester tester) async {
    // Build the MapScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: MapScreen(),
    ));

    // Verify the GoogleMap widget is displayed
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
