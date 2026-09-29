import 'package:flutter/material.dart';

import '../../domain/entities/estado_conexion.dart';

class EstadoConexionVista extends StatelessWidget {
  const EstadoConexionVista({required this.estado, super.key});

  final EstadoConexion estado;

  @override
  Widget build(BuildContext context) {
    final conectado = estado != EstadoConexion.sinConexion;
    final color = conectado ? const Color(0xFF21845A) : Colors.red.shade700;
    final (etiqueta, icono) = switch (estado) {
      EstadoConexion.wifi => ('Wi-Fi', Icons.wifi),
      EstadoConexion.datosMoviles => ('Datos móviles', Icons.signal_cellular_alt),
      EstadoConexion.otro => ('Otra conexión', Icons.device_hub),
      EstadoConexion.sinConexion => ('Sin conexión', Icons.wifi_off),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, size: 76, color: color),
        const SizedBox(height: 16),
        Text(
          etiqueta,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}