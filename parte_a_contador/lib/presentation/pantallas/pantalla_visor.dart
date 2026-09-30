import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../estado/contador_cubit.dart';
import 'pantalla_control.dart';

class PantallaVisor extends StatelessWidget {
  const PantallaVisor({super.key});

  Future<void> _irAControl(BuildContext context) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const PantallaControl()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Contador', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            BlocBuilder<ContadorCubit, int>(
              builder: (context, contador) => Text(
                '$contador',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () => _irAControl(context),
              icon: const Icon(Icons.tune),
              label: const Text('Ir a Control'),
            ),
          ],
        ),
      ),
    );
  }
}