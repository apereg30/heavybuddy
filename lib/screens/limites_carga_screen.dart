import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P05 - Límites de carga y alertas de rehabilitación.
class LimitesCargaScreen extends StatelessWidget {
  const LimitesCargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return HbScaffold(
      title: 'Límites de carga',
      bottomAction: FilledButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.registro),
        child: const Text('Entendido, comenzar serie'),
      ),
      children: [
        Text('[Nombre del ejercicio]', style: t.titleLarge),
        const SizedBox(height: AppSpacing.m),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.m),
          margin: const EdgeInsets.only(bottom: AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.errorSurface,
            border: Border.all(color: AppColors.error, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.error),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ALERTA: no superar este límite',
                        style: t.titleMedium?.copyWith(color: AppColors.error)),
                    const SizedBox(height: 4),
                    const Text('Mensaje de texto e icono, no solo color.'),
                  ],
                ),
              ),
            ],
          ),
        ),
        InfoCard(
          title: 'Peso máximo recomendado',
          child: Text('[X] kg', style: t.headlineMedium?.copyWith(fontSize: 32)),
        ),
        InfoCard(
          title: 'Volumen máximo aconsejado',
          child: Text('[X] series x [X] repeticiones', style: t.titleMedium),
        ),
        const Text('Progresión: semana [n] de [N]'),
        const SizedBox(height: AppSpacing.s),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LinearProgressIndicator(
            value: 0.4,
            minHeight: 14,
            color: AppColors.primary,
            backgroundColor: AppColors.tintStrong,
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        Text('Si intentas superar el límite, aparece confirmación antes de guardar.', style: t.bodySmall),
      ],
    );
  }
}
