import 'dart:async';

import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/demo_data.dart';
import '../state/format.dart';
import '../state/models.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P02 - Registro rápido de serie.
class RegistroSerieScreen extends StatefulWidget {
  const RegistroSerieScreen({super.key});

  @override
  State<RegistroSerieScreen> createState() => _RegistroSerieScreenState();
}

class _RegistroSerieScreenState extends State<RegistroSerieScreen> {
  String? _ejercicio;
  int _reps = 0;
  double _peso = 0;
  String? _error;

  final _reloj = Stopwatch();
  Timer? _timer;
  String _tiempoHablado = 'parado';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _alternarTemporizador() {
    setState(() {
      if (_reloj.isRunning) {
        _reloj.stop();
        _timer?.cancel();
        _tiempoHablado = '${numero(_reloj.elapsedMilliseconds / 1000)} segundos';
      } else {
        _reloj.start();
        _timer = Timer.periodic(const Duration(milliseconds: 50), (_) => setState(() {}));
        _tiempoHablado = 'en marcha';
      }
      _error = null;
    });
  }

  void _reiniciarTemporizador() {
    setState(() {
      _reloj
        ..stop()
        ..reset();
      _timer?.cancel();
      _tiempoHablado = 'parado';
    });
  }

  void _msg(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _guardar() async {
    final state = AppScope.read(context);
    if (_ejercicio == null) {
      setState(() => _error = 'Selecciona un ejercicio antes de guardar la serie.');
      return;
    }
    if (_reps == 0 && _reloj.elapsed == Duration.zero) {
      setState(() => _error = 'Indica las repeticiones o usa el temporizador antes de guardar la serie.');
      return;
    }
    final limite = state.limites[_ejercicio];
    if (limite != null && _peso > limite.pesoKg) {
      final seguir = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.warning_amber_rounded, color: AppColors.error),
          title: const Text('Límite de carga superado'),
          content: Text(
            'Límite de carga superado (Máx. recomendado: ${numero(limite.pesoKg)} kg). '
            'Por favor, reduce el peso o confirma si deseas continuar bajo tu responsabilidad.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Reducir peso')),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Guardar igualmente')),
          ],
        ),
      );
      if (!mounted || seguir != true) return;
    }
    final serie = Serie(ejercicio: _ejercicio!, tiempo: _reloj.elapsed, repeticiones: _reps, pesoKg: _peso);
    state.registrarSerie(serie);
    _reiniciarTemporizador();
    setState(() {
      _reps = 0;
      _error = null;
    });
    _msg('Serie guardada: ${descripcionSerie(serie)}');
  }

  void _deshacer() {
    final ok = AppScope.read(context).deshacerUltimaSerie();
    _msg(ok ? 'Última serie eliminada.' : 'No hay series que deshacer.');
  }

  void _terminar() {
    final state = AppScope.read(context);
    if (state.sesionActual == null || state.sesionActual!.series.isEmpty) {
      _msg('Guarda al menos una serie antes de terminar la sesión.');
      return;
    }
    Navigator.of(context).pushNamed(Routes.dolor);
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final t = Theme.of(context).textTheme;
    final limite = _ejercicio == null ? null : state.limites[_ejercicio];
    final supera = limite != null && _peso > limite.pesoKg;
    final series = state.sesionActual?.series ?? const <Serie>[];

    return HbScaffold(
      title: 'Registro de serie',
      bottomAction: FilledButton(onPressed: _guardar, child: const Text('Guardar serie')),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _ejercicio,
          decoration: const InputDecoration(labelText: 'Ejercicio', border: OutlineInputBorder()),
          items: [for (final e in catalogoEjercicios) DropdownMenuItem(value: e, child: Text(e))],
          onChanged: (v) => setState(() {
            _ejercicio = v;
            _error = null;
          }),
        ),
        const SizedBox(height: AppSpacing.m),
        Text('Tiempo', style: t.bodySmall),
        const SizedBox(height: 4),
        Semantics(
          label: 'Tiempo',
          value: _tiempoHablado,
          child: ExcludeSemantics(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(cronometro(_reloj.elapsed),
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        OutlinedButton(
          onPressed: _alternarTemporizador,
          child: Text(_reloj.isRunning ? 'Parar temporizador' : 'Iniciar temporizador'),
        ),
        const SizedBox(height: AppSpacing.s),
        OutlinedButton(onPressed: _reiniciarTemporizador, child: const Text('Reiniciar temporizador')),
        const SizedBox(height: AppSpacing.m),
        _Stepper(
          label: 'Repeticiones',
          unit: 'repeticiones',
          valor: '$_reps',
          onMenos: _reps > 0 ? () => setState(() => _reps--) : null,
          onMas: () => setState(() => _reps++),
        ),
        _Stepper(
          label: 'Peso (kg)',
          unit: 'kilogramos',
          valor: numero(_peso),
          onMenos: _peso > 0 ? () => setState(() => _peso = (_peso - 2.5).clamp(0, double.infinity)) : null,
          onMas: () => setState(() => _peso += 2.5),
        ),
        if (limite != null)
          InfoCard(
            child: Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(supera
                        ? 'Superas el límite recomendado de ${numero(limite.pesoKg)} kg para $_ejercicio.'
                        : 'Límite recomendado para $_ejercicio: ${numero(limite.pesoKg)} kg.'),
                  ),
                ],
              ),
            ),
          ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.m),
            child: Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(_error!, style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        OutlinedButton(onPressed: _deshacer, child: const Text('Deshacer última entrada')),
        const SizedBox(height: AppSpacing.m),
        InfoCard(
          title: 'Series de esta sesión',
          child: series.isEmpty
              ? const Text('Todavía no hay series.')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < series.length; i++) Text('${i + 1}. ${descripcionSerie(series[i])}'),
                  ],
                ),
        ),
        OutlinedButton(onPressed: _terminar, child: const Text('Terminar sesión')),
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.unit,
    required this.valor,
    required this.onMenos,
    required this.onMas,
  });
  final String label;
  final String unit;
  final String valor;
  final VoidCallback? onMenos;
  final VoidCallback onMas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: OutlinedButton(
                  onPressed: onMenos,
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text('−', semanticsLabel: 'Restar $unit', style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Semantics(
                  liveRegion: true,
                  label: label,
                  value: valor,
                  child: ExcludeSemantics(
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.tintStrong, borderRadius: BorderRadius.circular(8)),
                      child: Text(valor, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              SizedBox(
                width: 56,
                height: 56,
                child: OutlinedButton(
                  onPressed: onMas,
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text('+', semanticsLabel: 'Sumar $unit', style: const TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
