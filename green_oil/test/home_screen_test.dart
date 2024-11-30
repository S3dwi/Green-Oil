import 'package:flutter_test/flutter_test.dart';
import 'package:your_project/main.dart'; // Adjust the path
import 'package:/home_screen/home_screen.dart'; // Adjust the path


testWidgets('Navigate to Order Summary when all data is valid', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.tap(find.text('Recycle Now'));
  await tester.pumpAndSettle();

  expect(find.byType(OrderSummary), findsOneWidget);
});
