import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rechner/main.dart';

void main() {
  testWidgets('Add: 7 + 8 = 15', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // OutlinedButton tappen
    await tester.tap(find.byKey(Key('Taste7')));
    await tester.tap(find.byKey(Key('Taste+')));
    await tester.tap(find.byKey(Key('Taste8')));
    await tester.tap(find.byKey(Key('Taste=')));

    // pump triggert ein Frame
    // pumpAndSettle triggert weiter neue Frames, bis sich nichts mehr ändert
    await tester.pumpAndSettle();

    expect(tester.widget<Text>(find.byKey(Key('Resultat'))).data, '15');
  });

  testWidgets('Minus: 7 - 8 = -1', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // OutlinedButton tappen
    await tester.tap(find.byKey(Key('Taste7')));
    await tester.tap(find.byKey(Key('Taste-')));
    await tester.tap(find.byKey(Key('Taste8')));
    await tester.tap(find.byKey(Key('Taste=')));

    await tester.pumpAndSettle();

    expect(tester.widget<Text>(find.byKey(Key('Resultat'))).data, '-1');
  });
}
