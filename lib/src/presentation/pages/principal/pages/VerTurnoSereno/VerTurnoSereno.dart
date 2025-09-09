import 'package:flutter/material.dart';

class VerTurnoSereno extends StatefulWidget {
  const VerTurnoSereno({super.key});

  @override
  State<VerTurnoSereno> createState() => _VerTurnoSerenoState();
}

class _VerTurnoSerenoState extends State<VerTurnoSereno> {
  final String turno = 'Turno Mañana';
  final String horaInicio = '06:00 AM';
  final String horaFin = '02:00 PM';
  final String estado = 'Activo'; // activo o inactivo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turno del Sereno'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalles del Turno',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            _buildTurnoInfo('Turno:', turno),
            _buildTurnoInfo('Hora de Inicio:', horaInicio),
            _buildTurnoInfo('Hora de Fin:', horaFin),
            _buildTurnoInfo('Estado:', estado),
            const SizedBox(height: 20),
            _buildEstadoIndicator(estado),

            const Text(
              'Detalles del Vehiculo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const Text(
              'Detalles del Policia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTurnoInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildEstadoIndicator(String estado) {
    Color color;
    String texto;

    if (estado == 'Activo') {
      color = Colors.green;
      texto = 'Turno Activo';
    } else {
      color = Colors.red;
      texto = 'Turno Inactivo';
    }

    return Row(
      children: [
        Icon(
          estado == 'Activo' ? Icons.check_circle : Icons.cancel,
          color: color,
        ),
        const SizedBox(width: 10),
        Text(
          texto,
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
