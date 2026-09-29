import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/usecases/consultar_conexion.dart';
import '../../domain/usecases/observar_conexion.dart';

class ConexionCubit extends Cubit<EstadoConexion> {
  ConexionCubit({
    required this.consultarConexion,
    required this.observarConexion,
  }) : super(EstadoConexion.otro);

  final ConsultarConexion consultarConexion;
  final ObservarConexion observarConexion;
  StreamSubscription<EstadoConexion>? _suscripcion;
  final ValueNotifier<int> cambiosRecibidos = ValueNotifier(0);

  Future<void> iniciar() async {
    if (_suscripcion != null) return;

    emit(await consultarConexion());
    _suscripcion = observarConexion().listen((estado) {
      cambiosRecibidos.value++;
      emit(estado);
    });
  }

  @override
  Future<void> close() async {
    await _suscripcion?.cancel();
    cambiosRecibidos.dispose();
    return super.close();
  }
}