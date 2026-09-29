import 'package:flutter_test/flutter_test.dart';
import 'package:parte_b_conexion/domain/entities/estado_conexion.dart';
import 'package:parte_b_conexion/domain/repositories/conexion_repository.dart';
import 'package:parte_b_conexion/domain/usecases/consultar_conexion.dart';
import 'package:parte_b_conexion/domain/usecases/observar_conexion.dart';

class RepositorioConexionDePrueba implements ConexionRepository {
  @override
  Future<EstadoConexion> consultarAhora() async => EstadoConexion.wifi;

  @override
  Stream<EstadoConexion> observarCambios() =>
      Stream.value(EstadoConexion.datosMoviles);
}

void main() {
  test('consulta una foto y expone los cambios como un flujo', () async {
    final repository = RepositorioConexionDePrueba();

    expect(await ConsultarConexion(repository)(), EstadoConexion.wifi);
    expect(
      await ObservarConexion(repository)().first,
      EstadoConexion.datosMoviles,
    );
  });
}