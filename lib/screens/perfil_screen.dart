import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P07 - Perfil y ajustes.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final state = AppScope.of(context);
    return HbScaffold(
      title: 'Perfil y ajustes',
      navIndex: 2,
      children: [
        Row(
          children: [
            const ExcludeSemantics(
              child: CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: Colors.white, size: 36),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: MergeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.perfilNombre, style: t.titleMedium),
                    Text('Datos de demostración, sólo en memoria', style: t.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        const SectionLabel('ACCESIBILIDAD'),
        CheckboxListTile(
          value: state.textoGrande,
          onChanged: (v) => state.textoGrande = v ?? false,
          title: const Text('Texto grande'),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          value: state.altoContraste,
          onChanged: (v) => state.altoContraste = v ?? false,
          title: const Text('Alto contraste'),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
        ),
        const SectionLabel('DATOS'),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.objetivos),
          child: const Text('Objetivos y fechas'),
        ),
      ],
    );
  }
}
