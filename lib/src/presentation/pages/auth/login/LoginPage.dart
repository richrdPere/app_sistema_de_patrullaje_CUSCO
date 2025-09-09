import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Bloc cubit
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginBloc.dart';

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
  LoginBloc? _bloc;

  @override
  void initState() {
    // SE EJECUTA UNA SOLA VEZ CUANDO SE CARGA LA PANTALLA
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   _loginBloc?.dispose();
    // });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                msg: responseState.error,
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseState is Success) {
              _bloc?.add(LoginFormReset());
              Fluttertoast.showToast(
                msg: "Login Exitoso",
                toastLength: Toast.LENGTH_LONG,
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    LoginContent(_bloc, state),
                    Center(child: CircularProgressIndicator())],
                );
              }
              return LoginContent(_bloc, state);
            },
          ),
        ),
      ),
    );
  }
}
