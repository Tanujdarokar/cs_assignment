import 'package:flutter_test/flutter_test.dart';
import 'package:machine_test/main.dart';

void main() {
  testWidgets('CalleyApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalleyApp());
    expect(find.text('Choose Your Language'), findsOneWidget);
  });
}
