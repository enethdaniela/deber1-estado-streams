// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parte_b_conexion/domain/entities/estado_conexion.dart';
import 'package:parte_b_conexion/domain/repositories/conexion_repository.dart';
import 'package:parte_b_conexion/domain/usecases/consultar_conexion.dart';
import 'package:parte_b_conexion/domain/usecases/observar_conexion.dart';
import 'package:parte_b_conexion/main.dart';

class RepositorioDePrueba implements ConexionRepository {
  RepositorioDePrueba(this.cambios);

  final StreamController<EstadoConexion> cambios;

  @override
  Future<EstadoConexion> consultarAhora() async => EstadoConexion.wifi;

  @override
  Stream<EstadoConexion> observarCambios() => cambios.stream;
}

void main() {
  testWidgets('Future consulta una vez y Stream muestra cambios nuevos', (
    tester,
  ) async {
    final cambios = StreamController<EstadoConexion>.broadcast();
    final repositorio = RepositorioDePrueba(cambios);
    await tester.pumpWidget(
      MyApp(
        consultarConexion: ConsultarConexion(repositorio),
        observarConexion: ObservarConexion(repositorio),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Consultar ahora'));
    await tester.pumpAndSettle();
    expect(find.text('Wi-Fi'), findsOneWidget);
    expect(find.textContaining('Consulta: '), findsOneWidget);

    await tester.tap(find.text('Con Stream'));
    await tester.pumpAndSettle();
    cambios.add(EstadoConexion.datosMoviles);
    await tester.pumpAndSettle();
    expect(find.text('Datos móviles'), findsOneWidget);
    expect(find.text('Cambios recibidos: 1'), findsOneWidget);

    cambios.add(EstadoConexion.datosMoviles);
    await tester.pumpAndSettle();
    expect(find.text('Cambios recibidos: 2'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await cambios.close();
  });
}
