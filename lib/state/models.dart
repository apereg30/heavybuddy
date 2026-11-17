/// Qué se mide en una prueba: tiempo (segundos) o repeticiones.
enum Metrica { tiempo, repeticiones }

/// Límite de carga recomendado para un ejercicio (modo rehabilitación).
class Limite {
  const Limite({required this.pesoKg, required this.series, required this.repeticiones});

  final double pesoKg;
  final int series;
  final int repeticiones;
}

class Serie {
  const Serie({
    required this.ejercicio,
    required this.tiempo,
    required this.repeticiones,
    required this.pesoKg,
  });

  final String ejercicio;
  final Duration tiempo;
  final int repeticiones;
  final double pesoKg;
}

class RegistroDolor {
  const RegistroDolor({required this.nivel, required this.zona, this.observaciones = ''});

  final int nivel;
  final String zona;
  final String observaciones;
}

class Sesion {
  Sesion({DateTime? inicio}) : inicio = inicio ?? DateTime.now();

  final DateTime inicio;
  final List<Serie> series = [];
  RegistroDolor? dolor;
}

/// Marca mínima exigida para una prueba de una oposición (datos de ejemplo).
class Baremo {
  const Baremo({
    required this.oposicion,
    required this.prueba,
    required this.metrica,
    required this.minimo,
    required this.mayorEsMejor,
  });

  final String oposicion;
  final String prueba;
  final Metrica metrica;
  final double minimo;
  final bool mayorEsMejor;
}

class Objetivo {
  const Objetivo({required this.fechaExamen, required this.baremo, required this.marca});

  final DateTime fechaExamen;
  final Baremo baremo;
  final double marca;
}
