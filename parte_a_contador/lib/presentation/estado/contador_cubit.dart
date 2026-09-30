import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';
import '../../domain/usecases/obtener_contador.dart';

class ContadorCubit extends Cubit<int> {
  ContadorCubit({
    required this.obtenerContador,
    required this.incrementarCasoUso,
    required this.decrementarCasoUso,
  }) : super(0);

  final ObtenerContador obtenerContador;
  final Incrementar incrementarCasoUso;
  final Decrementar decrementarCasoUso;

  Future<void> cargar() async => emit(await obtenerContador());

  Future<void> incrementar() async => emit(await incrementarCasoUso());

  Future<void> decrementar() async => emit(await decrementarCasoUso());
}