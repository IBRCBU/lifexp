import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifexp_app/core/app.dart';

void main() {
  testWidgets('LifeXP app loads onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeXPApp());

    expect(find.text('Turn goals into XP'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('router follows authentication state changes', (tester) async {
    final authChanges = StreamController<bool>();
    addTearDown(authChanges.close);

    await tester.pumpWidget(LifeXPApp(authStateChanges: authChanges.stream));
    expect(find.text('Turn goals into XP'), findsOneWidget);

    authChanges.add(true);
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsWidgets);

    authChanges.add(false);
    await tester.pumpAndSettle();
    expect(find.text('Turn goals into XP'), findsOneWidget);
  });
}
