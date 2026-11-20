import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/demo_data.dart';
import '../state/models.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';

/// P06 - Autoevaluación de dolor post-entrenamiento.
Color _painColor(int level) {
  if (level <= 2) return AppColors.successSurface;
  if (level <= 5) return AppColors.warnSurface;
  return AppColors.dangerSurface;
}

class DolorScreen extends StatefulWidget {
  const DolorScreen({super.key});

  @override
  State<DolorScreen> createState() => _DolorScreenState();
}

class _DolorScreenState extends State<DolorScreen> {
  int? _nivel;
  String _zona = 'Ninguna';
  final _observaciones = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _observaciones.dispose();
    super.dispose();
  }

  void _finalizar() {
    final nivel = _nivel;
    if (nivel == null) {
      setState(() => _error = 'Selecciona un nivel de dolor del 0 al 10 antes de finalizar la sesión.');
      return;
    }
    AppScope.read(context).finalizarSesion(
      RegistroDolor(nivel: nivel, zona: _zona, observaciones: _observaciones.text.trim()),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Sesión guardada.')));
    Routes.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return HbScaffold(
      title: '¿Cómo te encuentras?',
      bottomAction: FilledButton(
        onPressed: _finalizar,
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
                child: Semantics(
                  selected: _nivel == i,
                  child: OutlinedButton(
                    onPressed: () {
                      _nivel = i;
                      _error = null;
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: _nivel == i ? Colors.white : AppColors.text,
                      backgroundColor: _nivel == i ? AppColors.primary : _painColor(i),
                      side: BorderSide(color: AppColors.primary, width: _nivel == i ? 3 : 1.5),
                    ),
                    child: Text('$i', semanticsLabel: 'Nivel de dolor $i', style: const TextStyle(fontSize: 18)),
                  ),
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
        Semantics(
          liveRegion: true,
          child: Row(
            children: [
              Icon(_nivel == null ? Icons.radio_button_unchecked : Icons.check_circle, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(_nivel == null ? 'Ningún nivel seleccionado' : 'Nivel seleccionado: $_nivel de 10'),
            ],
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.s),
            child: Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(child: Text(_error!, style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.m),
        DropdownButtonFormField<String>(
          initialValue: _zona,
          decoration: const InputDecoration(labelText: 'Zona afectada', border: OutlineInputBorder()),
          items: [for (final z in catalogoZonas) DropdownMenuItem(value: z, child: Text(z))],
          onChanged: (v) => setState(() => _zona = v ?? _zona),
        ),
        const SizedBox(height: AppSpacing.m),
        TextField(
          controller: _observaciones,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Observaciones (opcional)', border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
