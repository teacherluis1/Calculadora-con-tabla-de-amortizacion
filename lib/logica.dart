import 'dart:math';

/// Calcula la cuota mensual de un préstamo
double calcularCuotaMensual(double monto, double tasaAnual, int meses) {
  if (meses <= 0 || monto <= 0) {
    return 0.0; // Retorna 0 si los valores son inválidos
  }

  double tasaMensual = tasaAnual / 100 / 12; // Convertir tasa anual a tasa mensual
  if (tasaMensual == 0) {
    return monto / meses; // Si la tasa de interés es 0, la cuota es monto dividido en meses
  }
  return monto *
      tasaMensual *
      (pow(1 + tasaMensual, meses)) /
      (pow(1 + tasaMensual, meses) - 1);
}

/// Genera una tabla de amortización para un préstamo
List<Map<String, dynamic>> generarTablaAmortizacion(
    double monto, double tasaAnual, int meses) {
  double tasaMensual = tasaAnual / 100 / 12;
  double cuota = calcularCuotaMensual(monto, tasaAnual, meses);
  double saldo = monto;
  List<Map<String, dynamic>> tabla = [];

  for (int i = 1; i <= meses; i++) {
    double interes = saldo * tasaMensual;
    double capital = cuota - interes;
    saldo -= capital;

    tabla.add({
      "mes": i,
      "cuota": cuota,
      "interes": interes,
      "capital": capital,
      "saldo": saldo > 0 ? saldo : 0,
    });
  }

  return tabla;
}
