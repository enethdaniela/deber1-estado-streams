import 'package:flutter/material.dart';

import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';

class PantallaControl extends StatefulWidget {
  const PantallaControl({
    required this.contadorInicial,
    required this.incrementar,
    required this.decrementar,
    super.key,
  });

  final int contadorInicial;
  final Incrementar incrementar;
  final Decrementar decrementar;

  @override
  State<PantallaControl> createState() => _PantallaControlState();
}

class _PantallaControlState extends State<PantallaControl> {
  late int _contador = widget.contadorInicial;

  Future<void> _incrementar() async {
    final valor = await widget.incrementar();
    if (mounted) {
      setState(() => _contador = valor);
    }
  }

  Future<void> _decrementar() async {
    final valor = await widget.decrementar();
    if (mounted) {
      setState(() => _contador = valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_contador', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _incrementar,
              icon: const Icon(Icons.add),
              label: const Text('+1'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _decrementar,
              icon: const Icon(Icons.remove),
              label: const Text('-1'),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(_contador),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}