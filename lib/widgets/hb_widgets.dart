import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Etiqueta superior + caja con valor/placeholder (sin funcionalidad todavía).
class FieldBox extends StatelessWidget {
  const FieldBox({super.key, required this.label, required this.value, this.minHeight = 48, this.trailing});

  final String label;
  final String value;
  final double minHeight;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      constraints: BoxConstraints(minHeight: minHeight, minWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.tint,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(value, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          trailing == null
              ? box
              : Row(children: [Expanded(child: box), const SizedBox(width: 8), trailing!]),
        ],
      ),
    );
  }
}

/// Tarjeta de superficie con título opcional.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.tint,
        border: const Border(left: BorderSide(color: AppColors.primary, width: 6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 4),
          ],
          child,
        ],
      ),
    );
  }
}

/// Título de sección en mayúsculas pequeñas (p. ej. "ACCESIBILIDAD").
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.s, bottom: AppSpacing.s),
        child: Text(text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.5)),
      );
}
