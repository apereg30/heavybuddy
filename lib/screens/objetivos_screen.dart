import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/demo_data.dart';
import '../state/format.dart';
import '../state/models.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P04 - Objetivos y fechas.
class ObjetivosScreen extends StatefulWidget {
  const ObjetivosScreen({super.key});

  @override
  State<ObjetivosScreen> createState() => _ObjetivosScreenState();
}

class _ObjetivosScreenState extends State<ObjetivosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _marca = TextEditingController();
  DateTime? _fecha;
  Baremo? _baremo;
  bool _errorFecha = false;

  @override
  void initState() {
    super.initState();
    final o = AppScope.read(context).objetivo;
    if (o != null) {
      _fecha = o.fechaExamen;
      _baremo = o.baremo;
      _marca.text = numero(o.marca);
    }
  }

  @override
  void dispose() {
    _marca.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final f = await showDatePicker(
      context: context,
      initialDate: _fecha ?? hoy,
      firstDate: hoy,
      lastDate: DateTime(hoy.year + 3, hoy.month, hoy.day),
      helpText: 'Fecha del examen',
    );
    if (f != null) {
      setState(() {
        _fecha = f;
        _errorFecha = false;
      });
    }
  }

  void _guardar() {
    final state = AppScope.read(context);
    final okForm = _formKey.currentState!.validate();
    setState(() => _errorFecha = _fecha == null);
    if (!okForm || _fecha == null) return;
    state.guardarObjetivo(Objetivo(
      fechaExamen: _fecha!,
      baremo: _baremo!,
      marca: double.parse(_marca.text.replaceAll(',', '.')),
    ));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Objetivo guardado.')));
    Routes.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final o = state.objetivo;
    final dias = state.diasRestantes;
    final unidad = _baremo == null ? '' : (_baremo!.metrica == Metrica.tiempo ? 'segundos' : 'repeticiones');

    return HbScaffold(
      title: 'Objetivos y fechas',
      bottomAction: FilledButton(onPressed: _guardar, child: const Text('Guardar objetivo')),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fecha del examen', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: _elegirFecha,
                  child: Text(_fecha == null ? 'Seleccionar fecha' : fechaCorta(_fecha!)),
                ),
              ),
              if (_errorFecha)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.s),
                  child: Semantics(
                    liveRegion: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.error),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('Selecciona la fecha del examen.',
                              style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.m),
              DropdownButtonFormField<Baremo>(
                initialValue: _baremo,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Prueba objetivo', border: OutlineInputBorder()),
                items: [
                  for (final b in catalogoBaremos)
                    DropdownMenuItem(value: b, child: Text('${b.oposicion} — ${b.prueba}')),
                ],
                validator: (v) => v == null ? 'Selecciona la prueba objetivo.' : null,
                onChanged: (v) => setState(() => _baremo = v),
              ),
              const SizedBox(height: AppSpacing.m),
              TextFormField(
                controller: _marca,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Marca objetivo',
                  suffixText: unidad,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                  return (n == null || n <= 0) ? 'Introduce un número mayor que 0 (por ejemplo, 225).' : null;
                },
              ),
              const SizedBox(height: AppSpacing.s),
              Text(
                _baremo == null
                    ? 'Marca mínima oficial: elige una prueba'
                    : 'Marca mínima oficial: ${marcaTexto(_baremo!.minimo, _baremo!.metrica)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.m),
              InfoCard(
                title: 'Progreso calculado',
                child: o == null
                    ? const Text('Guarda un objetivo para ver tu progreso.')
                    : Text('${dias! < 0 ? 'La fecha del examen ya ha pasado' : '$dias días restantes'}'
                        ' · ${(state.progresoObjetivo * 100).round()} % hacia la marca'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
