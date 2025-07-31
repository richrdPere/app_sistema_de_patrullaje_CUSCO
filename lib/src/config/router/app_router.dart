import 'package:app_sistema_de_patrullaje/src/presentation/pages/chats/ChatsScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/mapa/MapaScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/notificaciones/NotificacionesScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/reporte_incidente/ReporteIncidenteScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:app_sistema_de_patrullaje/src/presentation/pages/dashboard/DashboardPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/PrincipalScreen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,

  // Redirección si no estás logueado
  // redirect: (BuildContext context, GoRouterState state) {
  //   final controller = Provider.of<SerenoController>(context, listen: false);
  //   final isLoggedIn = controller.sereno != null;

  //   final goingToLogin = state.namedLocation('login') == '/login' || state.location == '/register';

  //   if (!isLoggedIn && !goingToLogin) {
  //     return '/login';
  //   }

  //   if (isLoggedIn && goingToLogin) {
  //     return '/home';
  //   }

  //   return null;
  // },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(
      path: '/loading',
      builder: (_, __) => const Text('SplashLoadingScreen()'), // pantalla intermedia opcional
    ),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    //GoRoute(path: '/home', builder: (context, state) => DashboardPage()),
    ShellRoute(
      builder: (_, __, child) => DashboardPage(child: child),
      routes: [
        GoRoute(path: '/dashboard/principal', builder: (_, __) => const PrincipalScreen()),
        GoRoute(path: '/dashboard/mapa', builder: (_, __) => const MapaScreen()),
        GoRoute(path: '/dashboard/reporte', builder: (_, __) => const ReporteIncidenteScreen()),
        GoRoute(path: '/dashboard/chats', builder: (_, __) => const ChatsScreen()),
        GoRoute(path: '/dashboard/alertas', builder: (_, __) => const NotificacionesScreen()),
      ],
    ),
  ],
);
