import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/usecases/consultar_conexion.dart';
import '../../domain/usecases/observar_conexion.dart';
import '../estado/conexion_cubit.dart';
import '../widgets/estado_conexion_vista.dart';

class PantallaStream extends StatelessWidget {
  const PantallaStream({
    required this.consultarConexion,
    required this.observarConexion,
    super.key,
  });

  final ConsultarConexion consultarConexion;
  final ObservarConexion observarConexion;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConexionCubit(
        consultarConexion: consultarConexion,
        observarConexion: observarConexion,
      )..iniciar(),
      child: const _PantallaStreamContenido(),
    );
  }
}

class _PantallaStreamContenido extends StatelessWidget {
  const _PantallaStreamContenido();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConexionCubit, EstadoConexion>(
      builder: (context, estado) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EstadoConexionVista(estado: estado),
              const SizedBox(height: 24),
                ValueListenableBuilder<int>(
                valueListenable: context
                  .read<ConexionCubit>()
                  .cambiosRecibidos,
                builder: (context, cambios, child) =>
                  Text('Cambios recibidos: $cambios'),
                ),
            ],
          ),
        );
      },
    );
  }
}