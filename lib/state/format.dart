import 'models.dart';

String fechaCorta(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

/// 12 -> "12", 12.5 -> "12,5"
String numero(double v) => (v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1)).replaceAll('.', ',');

String marcaTexto(double v, Metrica m) => m == Metrica.tiempo ? '${numero(v)} s' : '${numero(v)} rep.';
