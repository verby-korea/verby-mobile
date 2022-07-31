import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:verby_mobile/main.dart';

void main() {
  testWidgets('Default MyApp Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Verby Mobile'), findsOneWidget);
    expect(find.byType(AppBar), findsNothing);
  });
}
