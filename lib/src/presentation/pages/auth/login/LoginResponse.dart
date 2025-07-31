import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Bloc cubit
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginBlocCubit.dart';

// Model's
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';

class LoginResponse extends StatelessWidget {
  // Instancias
  LoginBlocCubit? bloc;

  LoginResponse(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc?.responseStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if(state is Loading){
          print('LOADING...');
          return Center(child: CircularProgressIndicator( color: Colors.black));
        }
        else if (state is Error) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
          );
        } else if (state is Success) {
          Fluttertoast.showToast(
            msg: "Login Exitoso",
            toastLength: Toast.LENGTH_LONG,
          );
        }

        return Container();
      },
    );
  }
}
