import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P04 - Objetivos y fechas.
class ObjetivosScreen extends StatelessWidget {
  const ObjetivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HbScaffold(
      title: 'Objetivos y fechas',
      bottomAction: FilledButton(
        onPressed: () => Routes.goHome(context),
        child: const Text('Guardar objetivo'),
      ),
      children: [
        const FieldBox(label: 'Fecha del examen', value: '[dd/mm/aaaa]'),
        const FieldBox(label: 'Prueba objetivo', value: '[Seleccionar prueba]'),
        const FieldBox(label: 'Marca objetivo', value: '[Valor]', trailing: Text('unidad')),
        Text('Marca mínima oficial: [Valor]', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 16),
        const InfoCard(
          title: 'Progreso calculado',
          child: Text('[Días restantes] · [Porcentaje hacia la marca objetivo]'),
        ),
      ],
    );
  }
}
