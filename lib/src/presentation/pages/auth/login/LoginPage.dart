import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Bloc cubit
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginBlocCubit.dart';

// Router
import 'package:go_router/go_router.dart';

// Widgets
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/default_textfield.dart';

class LoginPage extends StatefulWidget {
  static const name = 'login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Instancias
  LoginBlocCubit? _loginBlocCubit;

  @override
  void initState() {
    // SE EJECUTA UNA SOLA VEZ CUANDO SE CARGA LA PANTALLA
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _loginBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginBlocCubit = BlocProvider.of<LoginBlocCubit>(context, listen: false);

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            LoginResponse(_loginBlocCubit),
            LoginContent(_loginBlocCubit),
          ],
        ),
      ),
    );
  }
}
