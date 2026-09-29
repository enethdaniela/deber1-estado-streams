import 'package:flutter/material.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/usecases/consultar_conexion.dart';
import '../widgets/estado_conexion_vista.dart';

class PantallaFoto extends StatefulWidget {
  const PantallaFoto({required this.consultarConexion, super.key});

  final ConsultarConexion consultarConexion;

  @override
  State<PantallaFoto> createState() => _PantallaFotoState();
}

class _PantallaFotoState extends State<PantallaFoto> {
  EstadoConexion? _estado;
  DateTime? _horaConsulta;
  bool _cargando = false;
  String? _error;

  Future<void> _consultar() async {
    setState(() {
      _cargando = true;
      _error = null;
    });
    try {
      final estado = await widget.consultarConexion();
      if (mounted) {
        setState(() {
          _estado = estado;
          _horaConsulta = DateTime.now();
        });
      }
    } catch (_) {
      if (mounted) setState(() => _error = 'No se pudo consultar la conexión');
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  String _formatearHora(DateTime? hora) {
    if (hora == null) return 'Sin consultar';
    final horas = hora.hour.toString().padLeft(2, '0');
    final minutos = hora.minute.toString().padLeft(2, '0');
    final segundos = hora.second.toString().padLeft(2, '0');
    return '$horas:$minutos:$segundos';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_estado case final estado?)
              EstadoConexionVista(estado: estado)
            else
              const Text('Pulsa para consultar el estado actual'),
            const SizedBox(height: 24),
            Text('Consulta: ${_formatearHora(_horaConsulta)}'),
            if (_error case final error?) ...[
              const SizedBox(height: 8),
              Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _cargando ? null : _consultar,
              icon: _cargando
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: const Text('Consultar ahora'),
            ),
          ],
        ),
      ),
    );
  }
}