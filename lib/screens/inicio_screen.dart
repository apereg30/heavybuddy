import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/demo_data.dart';
import '../state/format.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P01 - Inicio / Panel principal.
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  String _ultimoProgreso(AppState state) {
    final sesiones = state.sesiones;
    if (sesiones.isEmpty) return 'Todavía no hay sesiones registradas.';
    final s = sesiones.last;
    final ejercicios = s.series.map((e) => e.ejercicio).toSet().join(', ');
    final dolor = s.dolor == null ? '' : ' · Dolor ${s.dolor!.nivel} de 10';
    return '${fechaCorta(s.inicio)}: ${s.series.length} series ($ejercicios)$dolor';
  }

  String _proximoExamen(AppState state) {
    final o = state.objetivo;
    if (o == null) return 'Sin objetivo. Configúralo en «Mis objetivos».';
    final dias = state.diasRestantes!;
    final cuando = dias < 0
        ? 'La fecha del examen (${fechaCorta(o.fechaExamen)}) ya ha pasado'
        : dias == 0
            ? 'El examen es hoy'
            : 'Faltan $dias días (${fechaCorta(o.fechaExamen)})';
    return '$cuando · Objetivo: ${o.baremo.prueba}, ${marcaTexto(o.marca, o.baremo.metrica)}';
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final nav = Navigator.of(context);
    return HbScaffold(
      title: 'Heavy Buddy',
      showBack: false,
      navIndex: 0,
      children: [
        Text('Hola, ${state.perfilNombre}', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.m),
        FilledButton(
          onPressed: () {
            state.iniciarSesion();
            nav.pushNamed(Routes.limites);
          },
          child: const Text('Iniciar sesión de entrenamiento'),
        ),
        const SizedBox(height: AppSpacing.m),
        InfoCard(title: 'Último progreso', child: Text(_ultimoProgreso(state))),
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
        InfoCard(title: 'Próxima fecha de examen', child: Text(_proximoExamen(state))),
        const SectionLabel('DEMO: CARGAR PERFIL DE EJEMPLO'),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final perfil in PerfilDemo.values)
              TextButton(
                onPressed: () {
                  state.cargarPerfil(perfil);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Perfil cargado: ${perfil.nombre}')));
                },
                child: Text(perfil.nombre),
              ),
          ],
        ),
      ],
    );
  }
}
