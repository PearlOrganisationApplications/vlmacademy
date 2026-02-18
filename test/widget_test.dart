
import 'package:flutter_test/flutter_test.dart';
import 'package:vlm_academy/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VlmAcademyApp());

    // Verify that our app title is present.
    expect(find.text('VLM Academy'), findsOneWidget);
  });
}
