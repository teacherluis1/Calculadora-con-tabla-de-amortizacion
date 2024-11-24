import 'package:flutter/material.dart';
import 'package:calculador/customtextfield.dart';
import 'package:calculador/calcularlimpiar.dart';
import 'package:calculador/logica.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  final TextEditingController montoController = TextEditingController();
  final TextEditingController mesesController = TextEditingController();
  final TextEditingController tasaController = TextEditingController();

  double cuotaMensual = 0.0; // Variable para mostrar el resultado
  List<Map<String, dynamic>> tablaAmortizacion = []; // Tabla de amortización

  /// Widget para construir la tabla de amortización
  Widget buildAmortizationTable() {
    if (tablaAmortizacion.isEmpty) {
      return const Center(
        child: Text(
          "No hay datos de amortización",
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Mes")),
          DataColumn(label: Text("Cuota")),
          DataColumn(label: Text("Interés")),
          DataColumn(label: Text("Capital")),
          DataColumn(label: Text("Saldo")),
        ],
        rows: tablaAmortizacion.map((fila) {
          return DataRow(
            cells: [
              DataCell(Text(fila["mes"].toString())),
              DataCell(Text("RD\$${fila["cuota"].toStringAsFixed(2)}")),
              DataCell(Text("RD\$${fila["interes"].toStringAsFixed(2)}")),
              DataCell(Text("RD\$${fila["capital"].toStringAsFixed(2)}")),
              DataCell(Text("RD\$${fila["saldo"].toStringAsFixed(2)}")),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ITLA Calculadora",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contenedor del título
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(color: Colors.blue[800]),
              child: const Text(
                "Calculadora de Préstamos Personales",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),

            // Formulario
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lado izquierdo: Formulario de entrada
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Monto Solicitado
                        const Text(
                          "Monto Solicitado RD\$*",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            hintText: "0.00",
                            controller: montoController,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Duración
                        const Text(
                          "Duración*",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            hintText: "Cantidad de meses",
                            controller: mesesController,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Tasa de Interés
                        const Text(
                          "Tasa de interés*",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            hintText: "%",
                            controller: tasaController,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalcularLimpiar(
                              texto: "Limpiar",
                              onPressed: () {
                                setState(() {
                                  montoController.clear();
                                  mesesController.clear();
                                  tasaController.clear();
                                  cuotaMensual = 0.0;
                                  tablaAmortizacion = [];
                                });
                              },
                            ),
                            CalcularLimpiar(
                              texto: "Calcular",
                              onPressed: () {
                                double monto =
                                    double.tryParse(montoController.text) ??
                                        0.0;
                                int meses =
                                    int.tryParse(mesesController.text) ?? 0;
                                double tasa =
                                    double.tryParse(tasaController.text) ?? 0.0;

                                if (monto <= 0 || meses <= 0 || tasa < 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Por favor, ingrese valores válidos.")),
                                  );
                                  return;
                                }

                                setState(() {
                                  cuotaMensual =
                                      calcularCuotaMensual(monto, tasa, meses);
                                  tablaAmortizacion =
                                      generarTablaAmortizacion(
                                          monto, tasa, meses);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Lado derecho: Resultado y tabla
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Cuota Mensual",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "RD\$${cuotaMensual.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        const Divider(),
                        const Text(
                          "Tabla de Amortización",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        buildAmortizationTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
