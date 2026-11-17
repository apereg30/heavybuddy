import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P01 - Inicio / Panel principal.
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return HbScaffold(
      title: 'Heavy Buddy',
      showBack: false,
      navIndex: 0,
      children: [
        Text('Hola, [NOMBRE]', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.m),
        FilledButton(
          onPressed: () => nav.pushNamed(Routes.limites),
          child: const Text('Iniciar sesión de entrenamiento'),
        ),
        const SizedBox(height: AppSpacing.m),
        const InfoCard(
          title: 'Último progreso',
          child: Text('[Resumen de la última sesión: series, tiempos, marcas]'),
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => nav.pushNamed(Routes.baremos),
                child: const Text('Consultar baremos', textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: OutlinedButton(
                onPressed: () => nav.pushNamed(Routes.objetivos),
                child: const Text('Mis objetivos', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        const InfoCard(
          title: 'Próxima fecha de examen',
          child: Text('[Días restantes y marca objetivo]'),
        ),
      ],
    );
  }
}
