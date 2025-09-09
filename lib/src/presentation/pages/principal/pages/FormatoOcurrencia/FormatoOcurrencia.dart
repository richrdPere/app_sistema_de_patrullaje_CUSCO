import 'package:app_sistema_de_patrullaje/src/presentation/pages/dashboard/widgets/CustomAppBar.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/pages/FormatoOcurrencia/steps/AutorStep.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/pages/FormatoOcurrencia/steps/GeneralidadesStep.dart'
    hide CustomSelect;
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/CustomSelect.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/CustomTimePicker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Modelo
import 'package:app_sistema_de_patrullaje/src/domain/models/FormatoOcurrenciaModel.dart';

// Widgets
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/widgets/CustomInput.dart';

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

class FormatoOcurrencias extends StatefulWidget {
  const FormatoOcurrencias({super.key});

  @override
  State<FormatoOcurrencias> createState() => _FormatoOcurrenciasState();
}

class _FormatoOcurrenciasState extends State<FormatoOcurrencias> {
  // ================================================
  // 1.- Instancia a la DB Sqlite
  // ================================================

  // ================================================
  // 2.- Otras instancias
  // ================================================

  // ================================================
  // 3.- Controllers
  // ================================================

  // ====================================================
  // (Step 1) - GENERALIDADES
  // ====================================================
  final String _dniSerenoGeneralidad = "";
  final String _nombreSerenoGeneralidad = "";
  final String _apellidosSerenoGeneralidad = "";
  final _origenAlertaGeneralidad = TextEditingController();
  final _modalidadGeneralidad = TextEditingController();

  // Datos del policia
  final _nombresPoliciaGeneralidad = TextEditingController();
  final _apellidosPoliciaGeneralidad = TextEditingController();
  final _gradoPoliciaGeneralidad = TextEditingController();
  final _comisariaPoliciaGeneralidad = TextEditingController();

  // Datos del vehiculo
  final _tipoPatrullajeGeneralidad = TextEditingController();
  final String _placaVehiculoGeneralidad = "";
  final String _tipoVehiculoGeneralidad = "";

  // Datos de la hora
  final String _turnoGeneralidad = "";
  final String _horaAlertaGeneralidad = "";
  final _horaLlegadaGeneralidad = TextEditingController();
  final _horaRepliegueGeneralidad = TextEditingController();
  final String _fechaGeneralidad = "";
  final String _diaSemanaGeneralidad = "";
  final String _mesGeneralidad = "";

  // Cod. Ocu
  final String _codigoOcurrenciaGeneralidad = "";

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
  // (Step 2) - DATOS: AUTOR/AGRESOR/CONDUCTOR (ES)
  // ====================================================
  final _identidadAgresor = TextEditingController();
  final _nombresAgresor = TextEditingController();
  final _apellidosAgresor = TextEditingController();
  final _edadAgresor = TextEditingController();
  final _placaAgresor = TextEditingController();
  final _generoAgresor = TextEditingController();

  // Contadores de Agresores
  final num _countTotalAgresor = 0;
  final num _countTotalMasculinosAgresor = 0;
  final num _countTotalFemeninoAgresor = 0;
  final num _countTotalMayoresAgresor = 0;
  final num _countTotalMenoresAgresor = 0;

  // ====================================================
  // (Step 3) - DATOS: VICTIMA DE UN DELITO, FALTA,
  //            INFRACCIÓN / O BENEFICIARIO DE UN SERVICIO
  //            RELACIÓN VICTIMA - VICTIMARIO
  // ====================================================
  final _comunidadVictima = TextEditingController(); // Si: "COMUNIDAD"
  final _nombresVictima = TextEditingController();
  final _apellidosVictima = TextEditingController();
  final _edadVictima = TextEditingController();
  final _generoVictima = TextEditingController();

  // Contadores de Victimas
  final num _countTotalVictima = 0;
  final num _countTotalMasculinoVictima = 0;
  final num _countTotalFemeninVictima = 0;
  final num _countTotalMayoresVictima = 0;
  final num _countTotalMenoresVictima = 0;

  // Relacion con el Victimario
  final _victimarioVictima = TextEditingController();

  List<String> relacionVictimaVictimario = [
    "Esposa o ex esposa",
    "Pareja o ex pareja",
    "Padre",
    "Madre",
    "Familiar",
    "Conocido",
    "Desconocido",
  ];

  // ====================================================
  // (Step 4) - DATOS DE LA OCURRENCIA Y DE LOS MEDIOS
  //            EMPLEADOS
  // ====================================================
  final _resultadoOcurrencia = TextEditingController(); // Si: "COMUNIDAD"
  final _consecuenciaOcurrencia = TextEditingController();
  final _lugarOcupacionOcurrencia = TextEditingController();
  final _medioUtilizadoOcurrencia = TextEditingController();

  List<String> resultadosOcurrencia = ["Hecho consumado", "Hecho frustrado"];

  List<String> consecuentasOcurrencia = [
    "Materiales",
    "Personales",
    'Psicológico',
    'Muerte',
    'Desorden',
    'Ocupación indebida espacio públicos',
    'Paz y orden',
    'Acciones disuasivas-preventivas',
  ];

  List<String> lugaresOcurrencia = [
    "Vía pública",
    "Inmueble particular",
    "Centro comercial",
    "Depósito",
    "Dependencia estatal",
    "Fábrica",
    "Entidad financiera",
    "Otros",
  ];

  List<String> mediosUtilizadosOcurrencia = [
    "Arma de fuego",
    "Arma blanca",
    "Agresión",
    "Amenaza",
    "Fuerza",
    "Engaño",
    "Habilidad",
    "Otros",
  ];

  // ====================================================
  // (Step 5) - DATOS DE LA DIRRECCIÓN Y GEORREFERENCIACION
  // ====================================================
  final _tipoViaLugar = TextEditingController();
  final _nombreDireccionLugar = TextEditingController();
  final _referenciaLugar = TextEditingController();
  final _manzanaLugar = TextEditingController();
  final _loteLugar = TextEditingController();

  // Datos de la zona
  final _tipoZonaLugar = TextEditingController();
  final _nombreZonaLugar = TextEditingController();
  final String _SectorPatrullajeLugar = "";
  final String _latitudLugar = "";
  final String _longitudLugar = "";

  List<String> tipoZonasLugar = [
    "Asoc. Vivienda",
    "Barrio",
    "Conj. Hab.",
    "Coop. Viv.",
    "P. Joven",
    "UPIS",
    "Urbanización",
    "Sin dato",
  ];

  // ====================================================
  // (Step 6) - SECCION DATOS IMPORTANTES
  // ====================================================
  final _datosImportantes = TextEditingController();

  // ====================================================
  // (Step 7) - RESUMEN
  // ====================================================

  final _formKey = GlobalKey<FormState>();
  // final PageController _pageController = PageController();
  late PageController _pageController;
  final FormatoOcurrencia _formData = FormatoOcurrencia();
  int _currentStep = 0;

  // Controllers para algunos campos principales
  final fechaCtrl = TextEditingController();
  final horaCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();
  final nombreAutorCtrl = TextEditingController();
  final dniAutorCtrl = TextEditingController();
  final nombreVictimaCtrl = TextEditingController();
  final dniVictimaCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final relacionVictimaCtrl = TextEditingController();
  final descripcionCtrl = TextEditingController();
  final mediosCtrl = TextEditingController();

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<void> _getLocation() async {
    await _checkLocationPermission();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _formData.latitud = position.latitude;
      _formData.longitud = position.longitude;
    });
  }

  void _nextStep() async {
    // if (_currentStep == 0) {
    //   // Si estamos en el primer step, guardamos la generalidad antes de continuar
    //   await _guardarGeneralidad();
    // }
    // if (_currentStep < _steps().length - 1) {
    //   _nextStep();
    // } else {
    //   // Si es el último paso, puedes cerrar o enviar todo
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("Formulario completado")));
    // }
    if (_currentStep < _steps().length - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Aquí podrías manejar el "Finalizar"
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Formulario completado ")));
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _guardarFormulario() {
    _formData.fecha = fechaCtrl.text;
    _formData.hora = horaCtrl.text;
    _formData.tipoIntervencion = tipoCtrl.text;
    _formData.nombreAutor = nombreAutorCtrl.text;
    _formData.dniAutor = dniAutorCtrl.text;
    _formData.nombreVictima = nombreVictimaCtrl.text;
    _formData.direccion = direccionCtrl.text;

    debugPrint("DATOS FINALES: ${_formData.toJson()}");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Formulario completado")));
  }

  final List<String> _titles = [
    "Generalidades",
    "Datos del Autor",
    "Datos de la Víctima",
    "Relación Víctima",
    "Ocurrencia",
    "Dirección y Georreferencia",
  ];

  List<Widget> _steps() => [
    //_generalidadesStep(),
    GeneralidadesStep(),
    _autorStep(),
    // AutorStep(),
    _victimaStep(),
    _relacionVictimaStep(),
    _ocurrenciaStep(),
    _direccionStep(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Formato de Ocurrencia",
        showBackButton: true, //  Aquí sí mostramos la flecha
      ),

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),

            // -----------------------------
            //  HEADER DE STEPS NUMERADOS
            // -----------------------------
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _titles.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final isActive = index == _currentStep;

                  return GestureDetector(
                    onTap: () {
                      setState(() => _currentStep = index);
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        // color: isActive ? Colors.blue : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(75),
                        boxShadow:
                            isActive
                                ? [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 1),
                                  ),
                                ]
                                : [],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    isActive ? Colors.blue : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  isActive
                                      ? Colors.white
                                      : Colors.grey.shade400,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color:
                                      isActive
                                          ? Colors.blue
                                          : Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            //  Barra de progreso animada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / _titles.length,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),

            // const SizedBox(height: 5),

            // -----------------------------
            //  CONTENIDO DE LOS STEPS
            // -----------------------------
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _steps().length,
                  itemBuilder: (context, index) => _steps()[index],
                ),
              ),
            ),

            // -----------------------------
            //  BOTONES DE NAVEGACIÓN
            // -----------------------------
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: _prevStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        "Atrás",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      style: TextStyle(color: Colors.black),
                      _currentStep == _steps().length - 1
                          ? "Finalizar"
                          : "Siguiente",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  //              CONTENIDO DE LOS STEPS
  // ==================================================

  Widget _generalidadesStep() {
    TimeOfDay? selectedTime;

    // Lista local para policías
    List<Policia> policias = [];

    // Controladores de formulario
    final TextEditingController nombresCtrl = TextEditingController();
    final TextEditingController apellidosCtrl = TextEditingController();
    final TextEditingController edadCtrl = TextEditingController();
    final TextEditingController placaCtrl = TextEditingController();

    // Función para agregar policía
    void agregarPolicia() {
      if (nombresCtrl.text.isEmpty ||
          apellidosCtrl.text.isEmpty ||
          edadCtrl.text.isEmpty ||
          placaCtrl.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor, completa todos los campos")),
        );
        return;
      }

      setState(() {
        policias.add(
          Policia(
            nombres: nombresCtrl.text,
            apellidos: apellidosCtrl.text,
            edad: int.tryParse(edadCtrl.text) ?? 0,
            placa: placaCtrl.text,
          ),
        );
        nombresCtrl.clear();
        apellidosCtrl.clear();
        edadCtrl.clear();
        placaCtrl.clear();
      });
    }

    // Función para eliminar policía
    void eliminarPolicia(int index) {
      setState(() {
        policias.removeAt(index);
      });
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Generalidades de la Intervención",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),

        // Selects de tipo y origen de intervención
        Row(
          children: [
            // Select Intervencion
            Expanded(
              flex: 3,
              child: CustomSelect<SelectedOption>(
                label: "T. Intervención",
                items: tiposIntervencion,
                initialValue: _selectedTipoIntervencion,
                onChanged: (value) {
                  setState(() {
                    _selectedTipoIntervencion = value;
                  });
                },
                itemLabel: (tipo) => "${tipo.id}.- ${tipo.label}",
              ),
            ),
            const SizedBox(width: 25),

            // Select Origen
            Expanded(
              flex: 3,
              child: CustomSelect<SelectedOption>(
                label: "Origen",
                items: origenesGeneralidad,
                initialValue: _selectedOrigenGeneralidad,
                onChanged: (value) {
                  setState(() {
                    _selectedOrigenGeneralidad = value;
                  });
                },
                itemLabel: (origen) => "${origen.id}.- ${origen.label}",
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        // Código de ocurrencia
        Row(
          children: [
            // Select Intervencion
            Expanded(
              // flex: 3,
              child: CustomInput(
                label: "Cod. de Ocurrencia",
                controller: fechaCtrl,
              ),
            ),
            // const SizedBox(width: 25),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomTimePicker(
                label: "Hora de Intervención",
                initialTime: selectedTime,
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: CustomTimePicker(
                label: "Hora de Repliegue",
                initialTime: selectedTime,
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),
        const Divider(thickness: 1),
        const SizedBox(height: 10),


        const SizedBox(height: 20),


      ],
    );
  }

  Widget _autorStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Datos del Autor",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        CustomInput(label: "Nombre del Autor", controller: nombreAutorCtrl),
        const SizedBox(height: 10),
        CustomInput(
          label: "DNI del Autor",
          controller: dniAutorCtrl,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _victimaStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Datos de la Víctima",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        CustomInput(
          label: "Nombre de la Víctima",
          controller: nombreVictimaCtrl,
        ),
        const SizedBox(height: 10),
        CustomInput(
          label: "DNI de la Víctima",
          controller: dniVictimaCtrl,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _relacionVictimaStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Relación Víctima",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        CustomInput(
          label: "Relación con la Víctima",
          controller: relacionVictimaCtrl,
        ),
      ],
    );
  }

  Widget _ocurrenciaStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Ocurrencia",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        CustomInput(
          label: "Descripción de la Ocurrencia",
          controller: descripcionCtrl,
        ),
        const SizedBox(height: 10),
        CustomInput(label: "Medios Empleados", controller: mediosCtrl),
      ],
    );
  }

  Widget _direccionStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Dirección y Georreferencia",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        CustomInput(label: "Dirección", controller: direccionCtrl),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _getLocation,
          icon: const Icon(Icons.location_on),
          label: const Text("Obtener Georreferenciación"),
        ),
        if (_formData.latitud != null && _formData.longitud != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Lat: ${_formData.latitud}, Lng: ${_formData.longitud}",
              style: const TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
      ],
    );
  }
}
