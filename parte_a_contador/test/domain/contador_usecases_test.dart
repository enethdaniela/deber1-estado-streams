import 'package:flutter_test/flutter_test.dart';
import 'package:parte_a_contador/domain/repositories/contador_repository.dart';
import 'package:parte_a_contador/domain/usecases/decrementar.dart';
import 'package:parte_a_contador/domain/usecases/incrementar.dart';
import 'package:parte_a_contador/domain/usecases/obtener_contador.dart';

class RepositorioEnMemoria implements ContadorRepository {
  int valor = 0;

  @override
  Future<int> leer() async => valor;

  @override
  Future<void> guardar(int valor) async {
    this.valor = valor;
  }
}

void main() {
  test('los casos de uso leen, incrementan y decrementan el valor guardado', () async {
    final repositorio = RepositorioEnMemoria();

    expect(await ObtenerContador(repositorio)(), 0);
    expect(await Incrementar(repositorio)(), 1);
    expect(await Decrementar(repositorio)(), 0);
  });
}