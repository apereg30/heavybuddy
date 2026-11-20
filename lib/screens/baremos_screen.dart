import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/app_state.dart';
import '../state/demo_data.dart';
import '../state/format.dart';
import '../state/models.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';

/// P03 - Baremos oficiales (datos de ejemplo).
class BaremosScreen extends StatefulWidget {
  const BaremosScreen({super.key});

  @override
  State<BaremosScreen> createState() => _BaremosScreenState();
}

class _BaremosScreenState extends State<BaremosScreen> {
  late String _oposicion = catalogoBaremos.first.oposicion;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final oposiciones = catalogoBaremos.map((b) => b.oposicion).toSet().toList();
    final filas = catalogoBaremos.where((b) => b.oposicion == _oposicion);

    return HbScaffold(
      title: 'Baremos oficiales',
      bottomAction: OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(48, 56)),
        onPressed: () => Navigator.of(context).pushNamed(Routes.registro),
        child: const Text('Registrar nueva marca'),
      ),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _oposicion,
          decoration: const InputDecoration(labelText: 'Oposición', border: OutlineInputBorder()),
          items: [for (final o in oposiciones) DropdownMenuItem(value: o, child: Text(o))],
          onChanged: (v) => setState(() => _oposicion = v ?? _oposicion),
        ),
        const SizedBox(height: AppSpacing.m),
        Text('Marcas mínimas exigidas', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.s),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const _Row(['Prueba', 'Mínimo', 'Tu marca'], header: true),
              for (final b in filas) _filaBaremo(b, state.mejorMarca(b)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Text('Estado escrito en texto, no solo por color.', style: Theme.of(context).textTheme.bodySmall),
        Text('Datos de ejemplo para la demo: no son baremos oficiales.', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _filaBaremo(Baremo b, double? marca) {
    final minimo = marcaTexto(b.minimo, b.metrica);
    if (marca == null) {
      return _Row([b.prueba, minimo, 'Sin registrar'],
          icon: Icons.remove_circle_outline, iconColor: AppColors.textSecondary);
    }
    final texto = marcaTexto(marca, b.metrica);
    return b.cumple(marca)
        ? _Row([b.prueba, minimo, '$texto Cumple'], icon: Icons.check_circle, iconColor: AppColors.success)
        : _Row([b.prueba, minimo, '$texto No cumple'], icon: Icons.warning_amber_rounded, iconColor: AppColors.error);
  }
}

class _Row extends StatelessWidget {
  const _Row(this.cells, {this.header = false, this.icon, this.iconColor});
  final List<String> cells;
  final bool header;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 13, fontWeight: header ? FontWeight.bold : FontWeight.normal);
    return MergeSemantics(
      child: Container(
        color: header
            ? AppColors.tintStrong
            : (iconColor == AppColors.success
                ? AppColors.successSurface
                : iconColor == AppColors.error
                    ? AppColors.dangerSurface
                    : AppColors.background),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(cells[0], style: style)),
            Expanded(flex: 2, child: Text(cells[1], style: style)),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  if (icon != null) ...[Icon(icon, size: 18, color: iconColor), const SizedBox(width: 4)],
                  Flexible(child: Text(cells[2], style: style)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
