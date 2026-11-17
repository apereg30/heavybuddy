import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P07 - Perfil y ajustes.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return HbScaffold(
      title: 'Perfil y ajustes',
      navIndex: 2,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary,
              child: Text('Foto', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('[NOMBRE]', style: t.titleMedium),
                  Text('[Tipo de perfil: opositor / rehabilitación]', style: t.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        const SectionLabel('ACCESIBILIDAD'),
        for (final label in ['Texto grande', 'Alto contraste', 'Vibración al confirmar', 'Sonido al confirmar'])
          CheckboxListTile(
            value: false,
            onChanged: (_) {},
            title: Text(label),
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsets.zero,
          ),
        const SectionLabel('MODO DE INTERFAZ'),
        for (final label in ['Modo sencillo', 'Modo completo'])
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(label),
            trailing: const Icon(Icons.radio_button_unchecked, color: AppColors.primary),
          ),
        const SectionLabel('DATOS'),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.objetivos),
          child: const Text('Objetivos y fechas'),
        ),
        const SizedBox(height: AppSpacing.m),
        OutlinedButton(onPressed: () {}, child: const Text('Exportar mis datos')),
      ],
    );
  }
}
