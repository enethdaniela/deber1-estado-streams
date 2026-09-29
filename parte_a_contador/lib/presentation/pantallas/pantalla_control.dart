import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../estado/contador_provider.dart';

class PantallaControl extends ConsumerWidget {
  const PantallaControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contador = ref.watch(contadorProvider);
    final controlador = ref.read(contadorProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $contador', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: controlador.incrementar,
              icon: const Icon(Icons.add),
              label: const Text('+1'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: controlador.decrementar,
              icon: const Icon(Icons.remove),
              label: const Text('-1'),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}