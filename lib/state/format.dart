import 'models.dart';

String fechaCorta(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

/// 12 -> "12", 12.5 -> "12,5"
String numero(double v) => (v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1)).replaceAll('.', ',');

String marcaTexto(double v, Metrica m) => m == Metrica.tiempo ? '${numero(v)} s' : '${numero(v)} rep.';

/// Cronómetro mm:ss.cc
String cronometro(Duration d) {
  final m = d.inMinutes.toString().padLeft(2, '0');
  final s = (d.inSeconds % 60).toString().padLeft(2, '0');
  final c = ((d.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
  return '$m:$s.$c';
}

/// "Sentadilla: 10 rep. · 32,5 kg · 12,3 s"
String descripcionSerie(Serie s) {
  final partes = <String>[];
  if (s.repeticiones > 0) partes.add('${s.repeticiones} rep.');
  if (s.pesoKg > 0) partes.add('${numero(s.pesoKg)} kg');
  if (s.tiempo > Duration.zero) partes.add('${numero(s.tiempo.inMilliseconds / 1000)} s');
  return '${s.ejercicio}: ${partes.join(' · ')}';
}
