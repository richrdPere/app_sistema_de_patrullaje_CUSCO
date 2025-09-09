import 'package:flutter/material.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/chats/ChatsScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/mapa/MapaScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/notificaciones/NotificacionesScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/reporte_incidente/ReporteIncidenteScreen.dart';

// Witgets
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/widgets/BuildModuloList.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  // Module Options
  final moduloOptions = [
    ModuloOption(
      title: "Ver\nTurno",
      icon: Icons.shield_moon,
      route: '/dashboard/ver_turno',
      backgroundColor: Colors.green,
    ),
    ModuloOption(
      title: "Formato Ocurrencia",
      icon: Icons.assignment,
      // route: '/dashboard/principal/formato_ocurrencia',
      route: '/formato_ocurrencia',
      backgroundColor: Colors.blue,
    ),
    ModuloOption(
      title: "Estado\nVehiculo",
      icon: Icons.report,
      route: '/dashboard/reporte',
      backgroundColor: Colors.orange,
    ),
    // ModuloOption(
    //   title: "Chats",
    //   icon: Icons.chat,
    //   route: '/dashboard/chats',
    //   backgroundColor: Colors.purple,
    // ),
  ];

  final int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: PrincipalScreen()), // Resume
    Center(child: MapaScreen()), // Mapa Interactivo
    //Center(child: Text('Búsqueda', style: TextStyle(fontSize: 24))), // Búsqueda
    Center(child: ReporteIncidenteScreen()), // Publicaciones
    Center(child: ChatsScreen()), // Chats
    Center(child: NotificacionesScreen()), // Alerta - Notificaciones
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = isDarkMode ? Colors.blueGrey : Colors.blue;
    final Color secondaryColor = isDarkMode ? Colors.greenAccent : Colors.green;

    final List<String> novedades = [
      "⚡ Corte de luz programado en zona A.",
      "🚧 Manifestación en la Av. Cultura.",
      "🧹 Operativo de limpieza en zona B.",
      "🚨 Vehículo sospechoso reportado en zona C.",
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Operaciones del Sereno",
      //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: primaryColor,
      //   actions: [
      //     IconButton(
      //       icon: CircleAvatar(
      //         backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const PerfilScreen()),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título - Resumen
            Text(
              "Modulos Disponibles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            // Cards del resumen
            Expanded(
              child: Container(
                color: Color.fromRGBO(241, 241, 241, 1),

                // child: _buildMenuList(
                //   context: context,
                //   menuOptions: menuOptions,
                //   size: size,
                // ),
                child: BuildModuloList(moduloOptions: moduloOptions),
              ),
              // child: GridView.count(
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 16,
              //   children: const [
              //     SummaryCard(
              //       title: "Patrullas Activas",
              //       value: "12",
              //       icon: Icons.directions_walk,
              //     ),
              //     SummaryCard(
              //       title: "Informe de Ocurrencias",
              //       value: "5",
              //       icon: Icons.warning,
              //     ),
              //     // SummaryCard(
              //     //   title: "Zonas Cubiertas",
              //     //   value: "8",
              //     //   icon: Icons.map,
              //     // ),
              //     SummaryCard(
              //       title: "Alertas Recientes",
              //       value: "3",
              //       icon: Icons.notifications,
              //     ),
              //   ],
              // ),
            ),
            // Título - Novedades
            Text(
              "Novedades de la Zona",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Carrusel de novedades
            SizedBox(
              height: 120,
              child: PageView.builder(
                itemCount: novedades.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  return Card(
                    color: isDarkMode ? Colors.blueGrey[700] : Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          novedades[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDarkMode ? Colors.blueGrey[800]! : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
