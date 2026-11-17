import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P02 - Registro rápido de serie (solo interfaz).
class RegistroSerieScreen extends StatelessWidget {
  const RegistroSerieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HbScaffold(
      title: 'Registro de serie',
      bottomAction: FilledButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.dolor),
        child: const Text('Guardar serie'),
      ),
      children: [
        const FieldBox(label: 'Ejercicio', value: '[Seleccionar ejercicio]'),
        Text('Tiempo', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: const Text('00:00.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const SizedBox(height: AppSpacing.s),
        OutlinedButton(onPressed: () {}, child: const Text('Iniciar / parar temporizador')),
        const SizedBox(height: AppSpacing.m),
        const _Stepper(label: 'Repeticiones', unit: 'repeticiones'),
        const _Stepper(label: 'Peso (kg)', unit: 'kilogramos'),
        const InfoCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, color: AppColors.error),
              SizedBox(width: 8),
              Expanded(child: Text('Aviso: [Límite recomendado de carga, solo en rehabilitación]')),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        OutlinedButton(onPressed: () {}, child: const Text('Deshacer última entrada')),
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.label, required this.unit});
  final String label;
  final String unit;

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
                width: 56, height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text('−', semanticsLabel: 'Restar $unit', style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.tintStrong, borderRadius: BorderRadius.circular(8)),
                  child: const Text('0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              SizedBox(
                width: 56, height: 56,
                child: OutlinedButton(
                  onPressed: () {},
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
