import 'package:app/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Find HomePage widgets', (tester) async {
    await _createWidget(tester);

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Alunos'), findsOneWidget);
    expect(find.text('Cursos'), findsOneWidget);
    expect(find.text('Matrícula'), findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}
