import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../estado/contador_provider.dart';
import 'pantalla_control.dart';

class PantallaVisor extends ConsumerStatefulWidget {
  const PantallaVisor({super.key});

  @override
  ConsumerState<PantallaVisor> createState() => _PantallaVisorState();
}

class _PantallaVisorState extends ConsumerState<PantallaVisor> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref.read(contadorProvider.notifier).cargar(),
    );
  }

  Future<void> _irAControl() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const PantallaControl()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contador = ref.watch(contadorProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Visor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Contador', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('$contador', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _irAControl,
              icon: const Icon(Icons.tune),
              label: const Text('Ir a Control'),
            ),
          ],
        ),
      ),
    );
  }
}