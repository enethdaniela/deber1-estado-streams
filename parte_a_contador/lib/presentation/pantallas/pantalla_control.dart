import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../estado/contador_cubit.dart';

class PantallaControl extends StatelessWidget {
  const PantallaControl({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContadorCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ContadorCubit, int>(
              builder: (context, contador) => Text(
                'Contador: $contador',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: cubit.incrementar,
              icon: const Icon(Icons.add),
              label: const Text('+1'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: cubit.decrementar,
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