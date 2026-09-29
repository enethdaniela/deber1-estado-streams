// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parte_a_contador/domain/repositories/contador_repository.dart';
import 'package:parte_a_contador/main.dart';
import 'package:parte_a_contador/presentation/estado/contador_provider.dart';

class RepositorioDePrueba implements ContadorRepository {
  int valor = 0;

  @override
  Future<int> leer() async => valor;

  @override
  Future<void> guardar(int valor) async {
    this.valor = valor;
  }
}

void main() {
  testWidgets('el visor se actualiza sin devolver un valor de Control', (
    tester,
  ) async {
    final repositorio = RepositorioDePrueba();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contadorRepositoryProvider.overrideWithValue(repositorio),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ir a Control'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('Contador: 1'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
}
