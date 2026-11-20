import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/format.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P05 - Límites de carga y alertas de rehabilitación.
class LimitesCargaScreen extends StatelessWidget {
  const LimitesCargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final state = AppScope.of(context);
    final limites = state.limites;
    final semana = state.semanaRehab;
    final total = state.totalSemanasRehab;

    return HbScaffold(
      title: 'Límites de carga',
      bottomAction: FilledButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.registro),
        child: const Text('Entendido, comenzar serie'),
      ),
      children: [
        if (limites.isEmpty)
          const InfoCard(
            title: 'Sin límites de carga configurados',
            child: Text('Este perfil no tiene límites de rehabilitación. Puedes registrar series con normalidad.'),
          )
        else ...[
          Semantics(
            liveRegion: true,
            child: Container(
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
                        Text('ALERTA: no superar estos límites',
                            style: t.titleMedium?.copyWith(color: AppColors.error)),
                        const SizedBox(height: 4),
                        const Text('Superarlos puede provocar una recaída en tu lesión.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (final e in limites.entries)
            MergeSemantics(
              child: InfoCard(
                title: e.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Peso máximo recomendado: ${numero(e.value.pesoKg)} kg', style: t.titleMedium),
                    const SizedBox(height: 4),
                    Text('Volumen máximo aconsejado: ${e.value.series} series x ${e.value.repeticiones} repeticiones'),
                  ],
                ),
              ),
            ),
        ],
        if (semana != null && total != null) ...[
          Text('Progresión: semana $semana de $total'),
          const SizedBox(height: AppSpacing.s),
          ExcludeSemantics(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: semana / total,
                minHeight: 14,
                color: AppColors.primary,
                backgroundColor: AppColors.tintStrong,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
        ],
        if (limites.isNotEmpty)
          Text('Si intentas superar el límite, aparece confirmación antes de guardar.', style: t.bodySmall),
      ],
    );
  }
}
