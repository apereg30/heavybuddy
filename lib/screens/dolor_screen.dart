import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P06 - Autoevaluación de dolor post-entrenamiento.
Color _painColor(int level) {
  if (level <= 2) return AppColors.successSurface;
  if (level <= 5) return AppColors.warnSurface;
  return AppColors.dangerSurface;
}

class DolorScreen extends StatelessWidget {
  const DolorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return HbScaffold(
      title: '¿Cómo te encuentras?',
      bottomAction: FilledButton(
        onPressed: () => Routes.goHome(context),
        child: const Text('Finalizar sesión de entrenamiento'),
      ),
      children: [
        const Text('Indica la molestia o dolor tras la sesión.'),
        const SizedBox(height: AppSpacing.m),
        Text('Nivel de dolor (0 a 10)', style: t.bodySmall),
        const SizedBox(height: AppSpacing.s),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (var i = 0; i <= 10; i++)
              SizedBox(
                width: 52,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.text,
                    backgroundColor: _painColor(i),
                  ),
                  child: Text('$i', semanticsLabel: 'Nivel de dolor $i', style: const TextStyle(fontSize: 18)),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Sin molestia', style: t.bodySmall), Text('Dolor máximo', style: t.bodySmall)],
        ),
        const SizedBox(height: AppSpacing.m),
        const FieldBox(label: 'Zona afectada', value: '[Seleccionar zona]'),
        const FieldBox(label: 'Observaciones (opcional)', value: '[Texto libre]', minHeight: 96),
      ],
    );
  }
}
