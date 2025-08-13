import 'package:app_sistema_de_patrullaje/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Bloc Providers
import 'package:app_sistema_de_patrullaje/blocProviders.dart';

// Data y Domain

// Router y Theme
import 'package:app_sistema_de_patrullaje/src/config/router/app_router.dart';
import 'package:app_sistema_de_patrullaje/src/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Sistema de Patrullaje - Serenazgo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}

