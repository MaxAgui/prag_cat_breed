import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/screens/breed_detail_screen.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/widgets/mas_button.dart';
import 'package:flutter/foundation.dart';

import '../../../../fixtures/breed_fixture.dart';

void main() {
  testWidgets('MasButton navega a BreedDetailScreen al presionar', (
    tester,
  ) async {
    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: MasButton(breed: breed)),
      ),
    );

    // Presionamos el botón
    await tester.tap(find.text("Más..."));
    await tester.pumpAndSettle();

    // Debe navegar a BreedDetailScreen
    expect(find.byType(BreedDetailScreen), findsOneWidget);

    // Y debe recibir el breed correcto
    final screen = tester.widget<BreedDetailScreen>(
      find.byType(BreedDetailScreen),
    );
    expect(screen.breed.id, equals("abys"));
  });

  testWidgets('MasButton navega en iOS con CupertinoButton', (tester) async {
    // Fuerzas a Flutter a creer que está en iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    await tester.pumpWidget(MaterialApp(home: MasButton(breed: breed)));

    // Encuentra el botón Cupertino
    expect(find.byType(CupertinoButton), findsOneWidget);

    await tester.tap(find.byType(CupertinoButton));
    await tester.pumpAndSettle();

    // La pantalla de detalle debería aparecer
    expect(find.byType(BreedDetailScreen), findsOneWidget);

    // Verificamos parámetro
    final screen = tester.widget<BreedDetailScreen>(
      find.byType(BreedDetailScreen),
    );
    expect(screen.breed.id, equals('abys'));

    // Siempre resetear
    debugDefaultTargetPlatformOverride = null;
  });
}
