import 'package:flutter/material.dart';

import 'screens/baremos_screen.dart';
import 'screens/dolor_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/limites_carga_screen.dart';
import 'screens/objetivos_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/registro_serie_screen.dart';

class Routes {
  static const inicio = '/'; // P01
  static const registro = '/registro'; // P02
  static const baremos = '/baremos'; // P03
  static const objetivos = '/objetivos'; // P04
  static const limites = '/limites'; // P05
  static const dolor = '/dolor'; // P06
  static const perfil = '/perfil'; // P07

  static final Map<String, WidgetBuilder> table = {
    inicio: (_) => const InicioScreen(),
    registro: (_) => const RegistroSerieScreen(),
    baremos: (_) => const BaremosScreen(),
    objetivos: (_) => const ObjetivosScreen(),
    limites: (_) => const LimitesCargaScreen(),
    dolor: (_) => const DolorScreen(),
    perfil: (_) => const PerfilScreen(),
  };

  /// Vuelve al Inicio (P01) limpiando la pila.
  static void goHome(BuildContext context) =>
      Navigator.of(context).popUntil((r) => r.isFirst);
}
