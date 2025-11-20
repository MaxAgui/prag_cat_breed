import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/widgets/chip_platform.dart';

void main() {
  testWidgets('ChipPlatform muestra Chip en Android', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ChipPlatform(text: 'Hola')),
      ),
    );

    // Verifica que renderiza Chip
    expect(find.byType(Chip), findsOneWidget);
    expect(find.byType(CupertinoButton), findsNothing);

    // Limpieza obligatoria
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('ChipPlatform muestra CupertinoButton en iOS', (tester) async {
    // Fuerza la plataforma iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(MaterialApp(home: ChipPlatform(text: 'Hola')));

    // CupertinoButton.filled crea un CupertinoButton con filled styling
    expect(find.byType(CupertinoButton), findsOneWidget);
    expect(find.byType(Chip), findsNothing);

    // Tocar el botón (aunque no hace nada)
    await tester.tap(find.byType(CupertinoButton));
    await tester.pump();

    // Limpieza obligatoria
    debugDefaultTargetPlatformOverride = null;
  });
}
