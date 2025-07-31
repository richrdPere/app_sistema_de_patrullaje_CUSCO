import 'package:flutter/material.dart';

import 'package:app_sistema_de_patrullaje/src/presentation/pages/chats/ChatsScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/mapa/MapaScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/notificaciones/NotificacionesScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/PrincipalScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/reporte_incidente/ReporteIncidenteScreen.dart';

// import 'package:lucide_icons/lucide_icons.dart'; // Asegúrate de tener lucide_icons o usa Icons por defecto

class DashboardPage extends StatefulWidget {
  final Widget child;

  const DashboardPage({super.key, required this.child});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistema de Patrullaje',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        // title: Image.asset(
        //   'assets/img/logo.png', // Cambia por la ruta de tu logo
        //   height: 150,
        // ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
      ),
      body: _screens[_currentIndex], // Muestra la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search_outlined),
          //   activeIcon: Icon(Icons.search),
          //   label: 'Buscar',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages_outlined),
            activeIcon: Icon(Icons.pages),
            label: 'Reportar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            activeIcon: Icon(Icons.notifications),
            label: 'Alertas',
          ),
        ],
      ),
    );
  }
}
