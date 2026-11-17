import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';

/// Barra inferior: Inicio / Registrar / Perfil (siempre con texto visible).
class HbBottomNav extends StatelessWidget {
  const HbBottomNav({super.key, required this.current});

  /// 0 = Inicio, 1 = Registrar, 2 = Perfil
  final int current;

  void _go(BuildContext context, int index) {
    if (index == current) return;
    final nav = Navigator.of(context);
    if (index == 0) {
      Routes.goHome(context);
    } else {
      nav.pushNamedAndRemoveUntil(
        index == 1 ? Routes.registro : Routes.perfil,
        (r) => r.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: current,
      backgroundColor: AppColors.tint,
      indicatorColor: AppColors.tintStrong,
      onDestinationSelected: (i) => _go(context, i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
        NavigationDestination(icon: Icon(Icons.fitness_center_outlined), selectedIcon: Icon(Icons.fitness_center), label: 'Registrar'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
