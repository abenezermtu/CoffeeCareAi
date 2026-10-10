import 'package:flutter_test/flutter_test.dart';
import 'package:coffeecareai/main.dart';

void main() {
  testWidgets('CoffeeCareAI loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CoffeeCareAI());

    expect(find.byType(CoffeeCareAI), findsOneWidget);
  });
}
