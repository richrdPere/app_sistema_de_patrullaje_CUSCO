import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/GeneralidadesModel.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/widgets/CustomInput.dart';
import 'package:flutter/material.dart';

// Database
import 'package:app_sistema_de_patrullaje/src/data/dataSource/local/db_sqlite/db_patrullaje.dart';

// Models
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/GeneralidadesModel.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/CustomSelect.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/CustomTimePicker.dart';

class SelectedOption {
  final int id;
  final String label;
  const SelectedOption(this.id, this.label);
}

class Policia {
  String nombres;
  String apellidos;
  int edad;
  String placa;

  Policia({
    required this.nombres,
    required this.apellidos,
    required this.edad,
    required this.placa,
  });
}

class GeneralidadesStep extends StatefulWidget {
  const GeneralidadesStep({super.key});

  @override
  State<GeneralidadesStep> createState() => _GeneralidadesStepState();
}

class _GeneralidadesStepState extends State<GeneralidadesStep> {
  // 1.- Instancia a la DB Patrullaje
  final db = DatabaseFormatoOcurrencia.instance;
  bool _isLoading = true;
  GeneralidadesModel?
  _generalidadGuardada; // Para almacenar la última generalidad creada
  int? _generalidadId; // Guardar el ID para saber si debemos actualizar o crear

  // ====================================================
  // 2.- Step - GENERALIDADES
  // ====================================================
  final TextEditingController _dniSerenoGeneralidad = TextEditingController();
  final TextEditingController _nombreSerenoGeneralidad =
      TextEditingController();
  final TextEditingController _apellidosSerenoGeneralidad =
      TextEditingController();
  // final TextEditingController _origenAlertaGeneralidad =
  //     TextEditingController();
  // final TextEditingController _modalidadGeneralidad = TextEditingController();

  // Datos del policia
  final TextEditingController _nombresPoliciaGeneralidad =
      TextEditingController();
  final TextEditingController _apellidosPoliciaGeneralidad =
      TextEditingController();
  final TextEditingController _gradoPoliciaGeneralidad =
      TextEditingController();
  final TextEditingController _comisariaPoliciaGeneralidad =
      TextEditingController();

  // Datos del vehiculo
  final String _placaVehiculoGeneralidad = "";

  // Fecha y Hora
  final TextEditingController _horaAlertaGeneralidad = TextEditingController();
  final TextEditingController _horaLlegadaGeneralidad = TextEditingController();
  final TextEditingController _horaRepliegueGeneralidad =
      TextEditingController();
  final TextEditingController _fechaGeneralidad = TextEditingController();
  final TextEditingController _diaSemanaGeneralidad = TextEditingController();
  final TextEditingController _mesGeneralidad = TextEditingController();

  // Cod. Ocu
  final String _codigoOcurrenciaGeneralidad = "";

  // Enums seleccionados
  List<Origen> _selectedOrigenes = [];
  ModalidadPatrullaje? _selectedModalidad;
  TipoPatrullaje? _selectedTipoPatrullaje;
  TipoVehiculo? _selectedTipoVehiculo;
  Turno? _selectedTurno;

  DateTime _selectedFecha = DateTime.now();

  // LIST: para los selected
  // 1
  List<SelectedOption> tiposIntervencion = const [
    SelectedOption(1, 'Robo'),
    SelectedOption(2, 'Asalto'),
    SelectedOption(3, 'Emergencia médica'),
    SelectedOption(4, 'Incidente de tránsito'),
    SelectedOption(5, 'Patrullaje preventivo'),
    SelectedOption(6, 'Otro'),
  ];
  SelectedOption? _selectedTipoIntervencion;
  int? _selectedTipoIntervencionId;

  // 2
  List<SelectedOption> origenesGeneralidad = const [
    SelectedOption(1, 'Cámaras de video'),
    SelectedOption(2, 'Telefóno'),
    SelectedOption(3, 'Patrullaje'),
    SelectedOption(4, 'Operativos'),
    SelectedOption(5, 'Redes sociales'),
    SelectedOption(6, 'Botón de pánico'),
    SelectedOption(7, 'Otros'),
  ];
  SelectedOption? _selectedOrigenGeneralidad;
  int? _selectedOrigenGeneralidadId;

  // 3
  List<String> modalidad = ["Integrado", "Municipal"];

  // 4
  List<String> tipoPatrullaje = ["Motorizado", "A pie", "Bicicleta", "Otros"];

  // ====================================================
  // 3.- FUNCIONES
  // ====================================================
  // INSERTAR
  Future<void> _insertGeneralidad() async {
    final generalidad = GeneralidadesModel(
      // Datos del sereno y modalidad
      serenoDni: '73081247',
      serenoApellidos: 'Pereira Chinchero',
      serenoNombres: 'Richard',
      departamento: 'Cusco',
      provincia: 'Cusco',
      distrito: 'Cusco',
      origenes: _selectedOrigenes,
      modalidadPatrullaje: _selectedModalidad,

      // Datos del Policia
      infoPnpNombres: 'Javier',
      infoPnpApellidos: 'Ventura',
      infoPnpGrado: 'Policia',
      comisaria: 'Comizaria de Zarzuela',

      // Datos del Vehiculo
      tipoPatrullaje: _selectedTipoPatrullaje,
      placaVehiculo: _placaVehiculoGeneralidad,
      tipoVehiculo: _selectedTipoVehiculo,

      // Fecha y hora
      turno: _selectedTurno,
      horaAlerta: _horaAlertaGeneralidad.text,
      horaLlegada: _horaLlegadaGeneralidad.text,
      horaRepliegue: _horaRepliegueGeneralidad.text,
      fecha: _selectedFecha,
      diaSemana: _getDiaSemana(_selectedFecha),
      mes: _getMes(_selectedFecha),
      codigoOcu: _codigoOcurrenciaGeneralidad,
      // codigoOcu: "OCU-${DateTime.now().millisecondsSinceEpoch}"
    );

    if (_generalidadId == null) {
      // INSERTAR
      final id = await db.insertGeneralidades(generalidad);
      setState(() {
        _generalidadId = id;
        _generalidadGuardada = generalidad;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Generalidad registrada correctamente")),
      );
    } else {
      // ACTUALIZAR
      await db.updateGeneralidad(generalidad);
      setState(() {
        _generalidadGuardada = generalidad;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Generalidad actualizada correctamente")),
      );
    }

    // _cargarGeneralidad();
  }

  // ACTUALIZAR
  Future<void> _updateGeneralidad(int id) async {
    await db.updateGeneralidad(
      GeneralidadesModel(
        id: id,

        // Datos del sereno y modalidad
        serenoDni: '73081247',
        serenoApellidos: 'Pereira Chinchero',
        serenoNombres: 'Richard',
        departamento: 'Cusco',
        provincia: 'Cusco',
        distrito: 'Cusco',
        origenes: _selectedOrigenes,
        modalidadPatrullaje: _selectedModalidad,

        // Datos del Policia
        infoPnpNombres: 'Javier',
        infoPnpApellidos: 'Ventura',
        infoPnpGrado: 'Policia',
        comisaria: 'Comizaria de Zarzuela',

        // Datos del Vehiculo
        tipoPatrullaje: _selectedTipoPatrullaje,
        placaVehiculo: _placaVehiculoGeneralidad,
        tipoVehiculo: _selectedTipoVehiculo,

        // Fecha y hora
        turno: _selectedTurno,
        horaAlerta: _horaAlertaGeneralidad.text,
        horaLlegada: _horaLlegadaGeneralidad.text,
        horaRepliegue: _horaRepliegueGeneralidad.text,
        fecha: _selectedFecha,
        diaSemana: _getDiaSemana(_selectedFecha),
        mes: _getMes(_selectedFecha),
        codigoOcu: _codigoOcurrenciaGeneralidad,
      ),
    );

    // Mostramos confirmación visual
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Generalidad actualizado correctamente")),
    );
    _cargarGeneralidad();
  }

  // ====================================================
  // 4.- INICIALIZAR
  // ====================================================
  void _cargarGeneralidad() async {
    final data = await db.getGeneralidades(); // Obtén la última guardada
    if (data.isNotEmpty) {
      final generalidad = data.last; // Asumimos que usamos la última creada
      setState(() {
        _generalidadGuardada = generalidad;
        _generalidadId = generalidad.id;

        // Cargar valores en los controladores
        _dniSerenoGeneralidad.text = generalidad.serenoDni ?? '';
        _apellidosSerenoGeneralidad.text = generalidad.serenoApellidos ?? '';
        _nombreSerenoGeneralidad.text = generalidad.serenoNombres ?? '';
        _horaAlertaGeneralidad.text = generalidad.horaAlerta ?? '';
        _horaLlegadaGeneralidad.text = generalidad.horaLlegada ?? '';
        _horaRepliegueGeneralidad.text = generalidad.horaRepliegue ?? '';
        _selectedModalidad = generalidad.modalidadPatrullaje;
        _selectedTipoPatrullaje = generalidad.tipoPatrullaje;
        _selectedTipoVehiculo = generalidad.tipoVehiculo;
        _selectedTurno = generalidad.turno;
        _selectedOrigenes = generalidad.origenes ?? [];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  String _getDiaSemana(DateTime fecha) {
    const dias = [
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado",
      "Domingo",
    ];
    return dias[fecha.weekday - 1];
  }

  String _getMes(DateTime fecha) {
    const meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ];
    return meses[fecha.month - 1];
  }

  @override
  void initState() {
    super.initState();
    _cargarGeneralidad();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Generalidades de la Intervención",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              "1.- Datos del Sereno",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // ==============================
            //  Datos del Sereno
            // ==============================
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomInput(
                    label: "Nombres Sereno",
                    controller: _nombreSerenoGeneralidad,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  flex: 2,
                  child: CustomInput(
                    label: "Apellidos Sereno",
                    controller: _apellidosSerenoGeneralidad,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomInput(
                    label: "DNI Sereno",
                    controller: _dniSerenoGeneralidad,
                  ),
                ),

                const SizedBox(width: 25),
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<Turno>(
                    decoration: const InputDecoration(labelText: "Turno"),
                    value: _selectedTurno,
                    items:
                        Turno.values.map((t) {
                          return DropdownMenuItem(
                            value: t,
                            child: Text(t.toString().split('.').last),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedTurno = value);
                    },
                  ),
                ),
              ],
            ),

            // ==============================
            //  Selects de tipo y origen de intervención
            // ==============================
            const SizedBox(height: 30),
            const Text(
              "2.- Datos de la Invervención",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Código de ocurrencia
                Expanded(
                  flex: 3,
                  child: CustomInput(
                    label: "Cod. de Ocurrencia",
                    controller: _fechaGeneralidad,
                  ),
                ),
                const SizedBox(width: 25),

                // Select Intervencion
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<TipoPatrullaje>(
                    decoration: const InputDecoration(
                      labelText: "Tipo de Patrullaje",
                    ),
                    value: _selectedTipoPatrullaje,
                    items:
                        TipoPatrullaje.values.map((t) {
                          return DropdownMenuItem(
                            value: t,
                            child: Text(t.toString().split('.').last),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedTipoPatrullaje = value);
                    },
                  ),
                ),

                // const SizedBox(width: 25),

                // Select Origen
              ],
            ),

            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTimePicker(
                    label: "Hora de Intervención",
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (time) {
                      setState(() {
                        _horaLlegadaGeneralidad.text = time.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: CustomTimePicker(
                    label: "Hora de Repliegue",
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (time) {
                      setState(() {
                        _horaRepliegueGeneralidad.text = time.toString();
                      });
                    },
                  ),
                ),
              ],
            ),

            // Selección de origenes (múltiple)
            const Text("Origen de la alerta:"),
            Column(
              children:
                  Origen.values.map((origen) {
                    return CheckboxListTile(
                      title: Text(origen.toString().split('.').last),
                      value: _selectedOrigenes.contains(origen),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedOrigenes.add(origen);
                          } else {
                            _selectedOrigenes.remove(origen);
                          }
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),

            // Modalidad patrullaje
            DropdownButtonFormField<ModalidadPatrullaje>(
              decoration: const InputDecoration(
                labelText: "Modalidad Patrullaje",
              ),
              value: _selectedModalidad,
              items:
                  ModalidadPatrullaje.values.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(m.toString().split('.').last),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() => _selectedModalidad = value);
              },
            ),
            const SizedBox(height: 16),

            // Tipo de patrullaje
            DropdownButtonFormField<TipoPatrullaje>(
              decoration: const InputDecoration(
                labelText: "Tipo de Patrullaje",
              ),
              value: _selectedTipoPatrullaje,
              items:
                  TipoPatrullaje.values.map((t) {
                    return DropdownMenuItem(
                      value: t,
                      child: Text(t.toString().split('.').last),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() => _selectedTipoPatrullaje = value);
              },
            ),
            const SizedBox(height: 16),

            // Tipo de vehículo
            DropdownButtonFormField<TipoVehiculo>(
              decoration: const InputDecoration(labelText: "Tipo de Vehículo"),
              value: _selectedTipoVehiculo,
              items:
                  TipoVehiculo.values.map((v) {
                    return DropdownMenuItem(
                      value: v,
                      child: Text(v.toString().split('.').last),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() => _selectedTipoVehiculo = value);
              },
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _insertGeneralidad,
              child: const Text("Guardar Generalidad"),
            ),
          ],
        );
  }
}
