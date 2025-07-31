import 'package:app_sistema_de_patrullaje/src/presentation/widgets/default_IconBack.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Router
import 'package:go_router/go_router.dart';

// Bloc cubit
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterBlocCubit.dart';

// Widgets
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/default_textfield.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/default_button.dart';

class RegisterContent extends StatelessWidget {
  RegisterBlocCubit? bloc;

  RegisterContent(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/img/background3.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          color: Color.fromRGBO(0, 0, 0, 0.7),
          colorBlendMode: BlendMode.darken,
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.person, color: Colors.white, size: 100),
                Text(
                  'REGISTRO',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.nameStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Nombres',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.person,
                        onChanged: (text) {
                          bloc?.changeName(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.lastnameStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Apellidos',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.person,
                        onChanged: (text) {
                          bloc?.changeLastname(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.emailStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Email',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.email,
                        onChanged: (text) {
                          bloc?.changeEmail(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.phoneStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Teléfono',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.phone,
                        onChanged: (text) {
                          bloc?.changePhone(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.dniStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'DNI',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.account_balance_sharp,
                        onChanged: (text) {
                          bloc?.changeDni(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.passwordStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Contraseña',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (text) {
                          bloc?.changePassword(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                    stream: bloc?.confirmPasswordStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Confirmar Contraseña',
                        errorText: snapshot.error?.toString(),
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged: (text) {
                          bloc?.changeConfirmPassword(text);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: StreamBuilder(
                    stream: bloc?.validateForm,
                    builder: (context, snapshot) {
                      return DefaultButton(
                        text: 'REGISTRARSE',
                        color: snapshot.hasData ? Colors.black : Colors.grey,
                        onPressed: () {
                          if (snapshot.hasData) {
                            bloc?.register();
                          } else {
                            Fluttertoast.showToast(
                              msg: 'El formulario no es valido',
                              toastLength: Toast.LENGTH_LONG,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        DefaultIconBack(left: 45, top: 135),
      ],
    );
  }
}
