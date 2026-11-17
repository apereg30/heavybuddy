import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/hb_scaffold.dart';
import '../widgets/hb_widgets.dart';

/// P03 - Baremos oficiales.
class BaremosScreen extends StatelessWidget {
  const BaremosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HbScaffold(
      title: 'Baremos oficiales',
      bottomAction: OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(48, 56)),
        onPressed: () => Routes.goHome(context),
        child: const Text('Registrar nueva marca'),
      ),
      children: [
        const FieldBox(label: 'Oposición', value: '[Policía / Bomberos / ...]'),
        const FieldBox(label: 'Prueba física', value: '[Seleccionar prueba]'),
        Text('Marcas mínimas exigidas', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.s),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: const [
              _Row(['Prueba', 'Mínimo', 'Tu marca'], header: true),
              _Row(['[Prueba 1]', '[Valor]', '[Valor] Cumple'], icon: Icons.check_circle, iconColor: AppColors.success),
              _Row(['[Prueba 2]', '[Valor]', '[Valor] No cumple'], icon: Icons.warning_amber_rounded, iconColor: AppColors.error, stripe: true),
              _Row(['[Prueba 3]', '[Valor]', 'Sin registrar'], icon: Icons.remove_circle_outline, iconColor: AppColors.textSecondary),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Text('Estado escrito en texto, no solo por color.', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.cells, {this.header = false, this.icon, this.iconColor, this.stripe = false});
  final List<String> cells;
  final bool header;
  final IconData? icon;
  final Color? iconColor;
  final bool stripe;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 13, fontWeight: header ? FontWeight.bold : FontWeight.normal);
    return Container(
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
    );
  }
}
