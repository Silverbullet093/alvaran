import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alvaran_cafe/main.dart';

void main() {
  testWidgets('Alvaran app smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(430, 932); // iPhone 14/15 Pro resolution
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const AlvaranApp());
    await tester.pump();

    // Verify ALVARAN logo text exists
    expect(find.text('ALVARAN'), findsOneWidget);

    // Verify Welcome message exists
    expect(find.text('SELAMAT DATANG, PLAYER'), findsOneWidget);

    // Verify Quick Actions exist
    expect(find.text('Buy\nTickets'), findsOneWidget);
    expect(find.text('Game\nLibrary'), findsOneWidget);

    // 'Reviews' appears in quick actions and in bottom nav bar
    expect(find.text('Reviews'), findsNWidgets(2));
  });
}
