import 'models.dart';

/// DATOS DE EJEMPLO PARA LA DEMO. Los baremos y límites NO son oficiales.

const catalogoBaremos = [
  Baremo(oposicion: 'Policía', prueba: 'Carrera 1000 m', metrica: Metrica.tiempo, minimo: 230, mayorEsMejor: false),
  Baremo(oposicion: 'Policía', prueba: 'Flexiones', metrica: Metrica.repeticiones, minimo: 20, mayorEsMejor: true),
  Baremo(oposicion: 'Policía', prueba: 'Dominadas', metrica: Metrica.repeticiones, minimo: 5, mayorEsMejor: true),
  Baremo(oposicion: 'Bomberos', prueba: 'Carrera 1000 m', metrica: Metrica.tiempo, minimo: 240, mayorEsMejor: false),
  Baremo(oposicion: 'Bomberos', prueba: 'Flexiones', metrica: Metrica.repeticiones, minimo: 25, mayorEsMejor: true),
  Baremo(oposicion: 'Bomberos', prueba: 'Sentadilla', metrica: Metrica.repeticiones, minimo: 15, mayorEsMejor: true),
];

/// Ejercicios que se pueden elegir al registrar una serie.
const catalogoEjercicios = [
  'Carrera 1000 m',
  'Flexiones',
  'Dominadas',
  'Sentadilla',
  'Press de banca',
];

/// Zonas que se pueden marcar como afectadas en la autoevaluación de dolor.
const catalogoZonas = ['Ninguna', 'Rodilla', 'Hombro', 'Espalda', 'Tobillo', 'Muñeca', 'Otra'];

enum PerfilDemo {
  opositor('Opositor demo'),
  rehabilitacion('Rehabilitación demo'),
  vacio('Vacío');

  const PerfilDemo(this.nombre);
  final String nombre;
}
