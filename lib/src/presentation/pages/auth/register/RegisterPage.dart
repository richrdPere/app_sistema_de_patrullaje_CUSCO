import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterContent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc's
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterBlocCubit.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBlocCubit? _registerBlocCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _registerBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _registerBlocCubit = BlocProvider.of<RegisterBlocCubit>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RegisterResponse(_registerBlocCubit),
            RegisterContent(_registerBlocCubit),
          ],
        ),
      ),
    );
  }
}
