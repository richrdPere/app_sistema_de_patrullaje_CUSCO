import 'package:app_sistema_de_patrullaje/src/presentation/pages/chats/ChatsScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/mapa/MapaScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/notificaciones/NotificacionesScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/perfil/PerfilScreen.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/pages/FormatoOcurrencia/FormatoOcurrencia.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/pages/VerTurnoSereno/VerTurnoSereno.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/reporte_incidente/ReporteIncidenteScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_sistema_de_patrullaje/src/presentation/pages/dashboard/DashboardPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/principal/PrincipalScreen.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: '/login',
  initialLocation: '/dashboard/principal',
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
      builder:
          (_, __) => const Text(
            'SplashLoadingScreen()',
          ), // pantalla intermedia opcional
    ),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/profile', builder: (context, state) => PerfilScreen()),

    /// Aquí usamos **ShellRoute** para envolver el Dashboard
    ShellRoute(
      builder: (_, __, child) => DashboardPage(child: child),
      routes: [
        /// Página principal con subruta para el formulario
        GoRoute(
          path: '/dashboard/principal',
          builder: (_, __) => const PrincipalScreen(),
          routes: [
            GoRoute(
              path: 'formato_ocurrencia',
              builder: (_, _) => const FormatoOcurrencias(),
            ),
          ],
        ),
        GoRoute(
          path: '/dashboard/ver_turno',
          builder: (_, __) => const VerTurnoSereno(),
        ),
        GoRoute(
          path: '/dashboard/reporte',
          builder: (_, __) => const ReporteIncidenteScreen(),
        ),
        GoRoute(
          path: '/dashboard/chats',
          builder: (_, __) => const ChatsScreen(),
        ),
        GoRoute(
          path: '/dashboard/alertas',
          builder: (_, __) => const NotificacionesScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/formato_ocurrencia',
      builder: (_, _) => const FormatoOcurrencias(),
    ),
  ],
);
