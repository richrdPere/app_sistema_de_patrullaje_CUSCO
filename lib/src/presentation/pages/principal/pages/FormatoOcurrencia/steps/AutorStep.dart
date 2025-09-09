import 'package:flutter/material.dart';

// Database
import 'package:app_sistema_de_patrullaje/src/data/dataSource/local/db_sqlite/db_patrullaje.dart';

// Modelo
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/autores_agresores_conductores/DatosAutoresAgresoresConductorModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/autores_agresores_conductores/AutorAgresorConductorModel.dart';

class AutorStep extends StatefulWidget {
  final DatosAutoresAgresoresConductor datosAutores;

  const AutorStep({Key? key, required this.datosAutores}) : super(key: key);

  @override
  State<AutorStep> createState() => _AutorStepState();
}

class _AutorStepState extends State<AutorStep> {
  // 1.- Instancia a la DB Patrullaje
  final db = DatabaseFormatoOcurrencia.instance;

  late DatosAutoresAgresoresConductor _datos;

  final _formKey = GlobalKey<FormState>();

  // Controladores de formularios
  final TextEditingController nombreAutorCtrl = TextEditingController();
  final TextEditingController edadAutorCtrl = TextEditingController();
  final TextEditingController placaAutorCtrl = TextEditingController();
  Genero _generoSeleccionado = Genero.masculino;
  bool _conductorAusente = false;

  // bool autorIdentificado = false;
  // bool conductorAusente = false;
  // String generoSeleccionado = 'Masculino';

  // List<DatosAutoresAgresoresConductor> autoresRegistrados = [];

  @override
  void initState() {
    super.initState();
    _datos = widget.datosAutores;
    // _cargarAutores();
  }

  // Obtener autores desde SQLite
  // Future<void> _cargarAutores() async {
  //   final data = await db.getAgresores();
  //   setState(() {
  //     autoresRegistrados = data;
  //   });
  // }

  void _abrirFormularioAutor({AutorAgresorConductorModel? autor, int? index}) {
    if (autor != null) {
      nombreAutorCtrl.text = autor.apellidosNombres;
      edadAutorCtrl.text = autor.edad?.toString() ?? '';
      placaAutorCtrl.text = autor.placa ?? '';
      _generoSeleccionado = autor.genero;
    } else {
      nombreAutorCtrl.clear();
      edadAutorCtrl.clear();
      placaAutorCtrl.clear();
      _generoSeleccionado = Genero.masculino;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  autor == null ? "Agregar Autor" : "Editar Autor",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nombreAutorCtrl,
                  decoration: const InputDecoration(
                    labelText: "Apellidos y Nombres",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: edadAutorCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Edad"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obligatorio";
                    }
                    final edad = int.tryParse(value);
                    if (edad == null || edad < 0) {
                      return "Edad inválida";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: placaAutorCtrl,
                  decoration: const InputDecoration(
                    labelText: "Placa (Opcional)",
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Genero>(
                  value: _generoSeleccionado,
                  decoration: const InputDecoration(labelText: "Género"),
                  items:
                      Genero.values.map((genero) {
                        return DropdownMenuItem(
                          value: genero,
                          child: Text(genero.toString().split('.').last),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _generoSeleccionado = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final nuevoAutor = AutorAgresorConductorModel(
                        apellidosNombres: nombreAutorCtrl.text.trim(),
                        genero: _generoSeleccionado,
                        edad: int.tryParse(edadAutorCtrl.text),
                        placa:
                            placaAutorCtrl.text.isEmpty
                                ? null
                                : placaAutorCtrl.text,
                      );

                      setState(() {
                        if (index != null) {
                          _datos.autores[index] = nuevoAutor;
                        } else {
                          _datos.autores.add(nuevoAutor);
                        }
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: Text(autor == null ? "Agregar" : "Actualizar"),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _eliminarAutor(int index) {
    setState(() {
      _datos.autores.removeAt(index);
    });
  }

  // Guardar un nuevo autor en SQLite
  // Future<void> _guardarAutor() async {
  //   if (nombreAutorCtrl.text.isEmpty || edadAutorCtrl.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Por favor, completa todos los campos obligatorios"),
  //       ),
  //     );
  //     return;
  //   }

  //   // await db.insertAgresores("autores", {
  //   //   "nombre": nombreAutorCtrl.text,
  //   //   "edad": int.parse(edadAutorCtrl.text),
  //   //   "placa": placaAutorCtrl.text,
  //   //   "genero": generoSeleccionado,
  //   //   "conductor_ausente": conductorAusente ? 1 : 0,
  //   // });

  //   nombreAutorCtrl.clear();
  //   edadAutorCtrl.clear();
  //   placaAutorCtrl.clear();
  //   setState(() {
  //     conductorAusente = false;
  //     generoSeleccionado = 'Masculino';
  //   });

  //   _cargarAutores();
  // }

  // Eliminar autor
  // Future<void> _eliminarAutor(int id) async {
  //   await db.deleteAgresores(id);
  //   _cargarAutores();
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Datos del Autor / Agresor / Conductor",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Checkbox(
              value: _datos.identificado,
              onChanged: (value) {
                setState(() {
                  _datos.identificado = value ?? false;
                });
              },
            ),
            const Text("¿Autor identificado?"),
          ],
        ),
        const SizedBox(height: 10),

        if (_datos.identificado) ...[
          if (_datos.autores.isEmpty) const Text("No hay autores registrados"),
          ..._datos.autores.asMap().entries.map((entry) {
            final index = entry.key;
            final autor = entry.value;
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(autor.apellidosNombres),
                subtitle: Text(
                  "Edad: ${autor.edad ?? '-'} | Género: ${autor.genero.toString().split('.').last} | Placa: ${autor.placa ?? '-'}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed:
                          () =>
                              _abrirFormularioAutor(autor: autor, index: index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarAutor(index),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _abrirFormularioAutor(),
            icon: const Icon(Icons.add),
            label: const Text("Agregar Autor"),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Conductor ausente"),
              Switch(
                value: _conductorAusente,
                onChanged: (value) {
                  setState(() {
                    _conductorAusente = value;
                  });
                },
              ),
            ],
          ),
        ],
      ],
    );

    // return ListView(
    //   padding: const EdgeInsets.all(16),
    //   children: [
    //     const Text(
    //       "Datos del Autor",
    //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //     ),
    //     const SizedBox(height: 10),

    //     // Checkbox Autor Identificado
    //     Row(
    //       children: [
    //         Checkbox(
    //           value: autorIdentificado,
    //           onChanged: (value) {
    //             setState(() {
    //               autorIdentificado = value!;
    //             });
    //           },
    //         ),
    //         const Text("¿Autor identificado?"),
    //       ],
    //     ),

    //     const SizedBox(height: 10),

    //     // Mostrar lista de autores registrados si está identificado
    //     if (autorIdentificado) ...[
    //       autoresRegistrados.isEmpty
    //           ? const Text("No hay autores registrados")
    //           : Column(
    //             children:
    //                 autoresRegistrados.map((autor) {
    //                   return Card(
    //                     elevation: 3,
    //                     margin: const EdgeInsets.symmetric(vertical: 8),
    //                     child: ListTile(
    //                       title: Text(autor["nombre"]),
    //                       subtitle: Text(
    //                         "Edad: ${autor["edad"]} | Placa: ${autor["placa"]}",
    //                       ),
    //                       trailing: Row(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           IconButton(
    //                             icon: const Icon(
    //                               Icons.edit,
    //                               color: Colors.blue,
    //                             ),
    //                             onPressed: () {
    //                               setState(() {
    //                                 nombreAutorCtrl.text = autor["nombre"];
    //                                 edadAutorCtrl.text =
    //                                     autor["edad"].toString();
    //                                 placaAutorCtrl.text = autor["placa"];
    //                                 generoSeleccionado = autor["genero"];
    //                                 conductorAusente =
    //                                     autor["conductor_ausente"] == 1;
    //                               });
    //                             },
    //                           ),
    //                           IconButton(
    //                             icon: const Icon(
    //                               Icons.delete,
    //                               color: Colors.red,
    //                             ),
    //                             onPressed: () => _eliminarAutor(autor["id"]),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 }).toList(),
    //           ),
    //       const SizedBox(height: 16),

    //       ElevatedButton.icon(
    //         onPressed: _guardarAutor,
    //         icon: const Icon(Icons.add),
    //         label: const Text("Agregar Autor"),
    //       ),
    //     ] else ...[
    //       // Si no identificado, deshabilitamos campos
    //       TextFormField(
    //         controller: nombreAutorCtrl,
    //         enabled: false,
    //         decoration: const InputDecoration(
    //           labelText: "Apellidos y Nombres (No editable)",
    //         ),
    //       ),
    //     ],

    //     const SizedBox(height: 20),

    //     // Campos del formulario SOLO si está identificado
    //     if (autorIdentificado) ...[
    //       TextFormField(
    //         controller: nombreAutorCtrl,
    //         decoration: const InputDecoration(labelText: "Apellidos y Nombres"),
    //       ),
    //       const SizedBox(height: 10),
    //       TextFormField(
    //         controller: edadAutorCtrl,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(labelText: "Edad"),
    //       ),
    //       const SizedBox(height: 10),
    //       TextFormField(
    //         controller: placaAutorCtrl,
    //         decoration: const InputDecoration(labelText: "Placa (Opcional)"),
    //       ),
    //       const SizedBox(height: 10),
    //       DropdownButtonFormField<String>(
    //         value: generoSeleccionado,
    //         items:
    //             ["Masculino", "Femenino"].map((String value) {
    //               return DropdownMenuItem(value: value, child: Text(value));
    //             }).toList(),
    //         onChanged: (value) {
    //           setState(() {
    //             generoSeleccionado = value!;
    //           });
    //         },
    //         decoration: const InputDecoration(labelText: "Género"),
    //       ),
    //     ],

    //     const SizedBox(height: 15),

    //     // Switch de conductor ausente, siempre visible
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         const Text("Conductor ausente"),
    //         Switch(
    //           value: conductorAusente,
    //           onChanged: (value) {
    //             setState(() {
    //               conductorAusente = value;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
