import 'package:flutter/widgets.dart';

import 'demo_data.dart';
import 'models.dart';

/// Estado de toda la app, sólo en memoria (sin persistencia).
class AppState extends ChangeNotifier {
  String perfilNombre = 'invitado';

  final List<Sesion> _sesiones = [];
  Sesion? _sesionActual;
  Objetivo? _objetivo;
  Map<String, Limite> _limites = {};
  int? semanaRehab;
  int? totalSemanasRehab;

  List<Sesion> get sesiones => List.unmodifiable(_sesiones);
  Sesion? get sesionActual => _sesionActual;
  Objetivo? get objetivo => _objetivo;
  Map<String, Limite> get limites => Map.unmodifiable(_limites);

  void iniciarSesion() {
    _sesionActual ??= Sesion();
    notifyListeners();
  }

  /// Días hasta el examen (negativo si ya pasó).
  int? get diasRestantes {
    final o = _objetivo;
    if (o == null) return null;
    final hoy = DateTime.now();
    final f = o.fechaExamen;
    return DateTime(f.year, f.month, f.day).difference(DateTime(hoy.year, hoy.month, hoy.day)).inDays;
  }

  // --- Perfiles de demo ---

  void cargarPerfil(PerfilDemo perfil) {
    perfilNombre = perfil.nombre;
    _sesiones.clear();
    _sesionActual = null;
    _objetivo = null;
    _limites = {};
    semanaRehab = null;
    totalSemanasRehab = null;
    final ahora = DateTime.now();

    switch (perfil) {
      case PerfilDemo.opositor:
        _objetivo = Objetivo(
          fechaExamen: ahora.add(const Duration(days: 45)),
          baremo: catalogoBaremos[0], // Policía - Carrera 1000 m
          marca: 225,
        );
        _sesiones.addAll([
          Sesion(inicio: ahora.subtract(const Duration(days: 9)))
            ..series.addAll(const [
              Serie(ejercicio: 'Carrera 1000 m', tiempo: Duration(seconds: 252), repeticiones: 0, pesoKg: 0),
              Serie(ejercicio: 'Flexiones', tiempo: Duration.zero, repeticiones: 18, pesoKg: 0),
            ])
            ..dolor = const RegistroDolor(nivel: 1, zona: 'Ninguna'),
          Sesion(inicio: ahora.subtract(const Duration(days: 3)))
            ..series.addAll(const [
              Serie(ejercicio: 'Carrera 1000 m', tiempo: Duration(seconds: 245, milliseconds: 300), repeticiones: 0, pesoKg: 0),
              Serie(ejercicio: 'Flexiones', tiempo: Duration.zero, repeticiones: 22, pesoKg: 0),
            ])
            ..dolor = const RegistroDolor(nivel: 2, zona: 'Hombro'),
        ]);
      case PerfilDemo.rehabilitacion:
        _limites = {
          'Sentadilla': const Limite(pesoKg: 40, series: 3, repeticiones: 10),
          'Press de banca': const Limite(pesoKg: 30, series: 3, repeticiones: 8),
        };
        semanaRehab = 3;
        totalSemanasRehab = 8;
        _sesiones.add(
          Sesion(inicio: ahora.subtract(const Duration(days: 2)))
            ..series.addAll(const [
              Serie(ejercicio: 'Sentadilla', tiempo: Duration.zero, repeticiones: 10, pesoKg: 30),
              Serie(ejercicio: 'Sentadilla', tiempo: Duration.zero, repeticiones: 10, pesoKg: 32.5),
            ])
            ..dolor = const RegistroDolor(nivel: 3, zona: 'Rodilla', observaciones: 'Molestia leve al bajar'),
        );
      case PerfilDemo.vacio:
        break;
    }
    notifyListeners();
  }
}

/// Da acceso al [AppState] desde cualquier pantalla.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child}) : super(notifier: state);

  /// Para usar en `build`: la pantalla se redibuja cuando cambia el estado.
  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;

  /// Para usar en callbacks: no suscribe la pantalla a los cambios.
  static AppState read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
