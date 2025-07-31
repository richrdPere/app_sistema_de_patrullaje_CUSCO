import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Bloc cubit
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginBlocCubit.dart';

// Model's
// import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';

// Router
import 'package:go_router/go_router.dart';

// Widgets
import 'package:app_sistema_de_patrullaje/src/presentation/widgets/default_textfield.dart';

class LoginContent extends StatelessWidget {
  // Instancias
  LoginBlocCubit? bloc;

  LoginContent(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/img/background2.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person, color: Colors.white, size: 125),
              Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 25),
                child: StreamBuilder(
                  stream: bloc?.usernameStream,
                  builder: (context, snapshot) {
                    return DefaultTextField(
                      label: 'Username',
                      icon: Icons.person,
                      errorText: snapshot.error?.toString(),
                      onChanged: (text) {
                        bloc?.changeUsername(text);
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 25),
                child: StreamBuilder(
                  stream: bloc?.passwordStream,
                  builder: (context, snapshot) {
                    return DefaultTextField(
                      label: 'Contraseña',
                      icon: Icons.lock,
                      errorText: snapshot.error?.toString(),
                      onChanged: (text) {
                        bloc?.changePassword(text);
                      },
                      obscureText: true,
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 55,
                  bottom: 15,
                ),
                child: StreamBuilder(
                  stream: bloc?.validateForm,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: () {
                        if (snapshot.hasData) {
                          bloc?.login();
                          // context.go('/dashboard/principal');
                        } else {
                          Fluttertoast.showToast(
                            msg: 'El formulario no es valido',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            snapshot.hasData ? Colors.green : Colors.grey,
                      ),
                      child: Text(
                        'INICIAR SESIÓN',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 65,
                    height: 1,
                    color: Colors.white,
                    margin: EdgeInsets.only(right: 5),
                  ),
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Container(
                    width: 65,
                    height: 1,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 5),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, 'register');
                    context.go('/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'REGISTRATE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:app_sistema_de_patrullaje/src/presentation/controllers/AuthController.dart';
// import 'package:app_sistema_de_patrullaje/src/presentation/widgets/custom_input.dart';

// // Services
// import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';

// class LoginContent extends StatefulWidget {
//   const LoginContent({super.key});

//   @override
//   State<LoginContent> createState() => _LoginContentState();
// }

// class _LoginContentState extends State<LoginContent> {
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Provider.of<AuthController>(context);
//     final controller = context.watch<AuthController>();

//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo
//               Text(
//                 'SerenApp',
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),

//               SizedBox(height: 40),

//               CustomInput(
//                 controller: emailCtrl,
//                 hintText: 'Correo electrónico',
//               ),
//               SizedBox(height: 16),
//               CustomInput(
//                 controller: passCtrl,
//                 hintText: 'Contraseña',
//                 isPassword: true,
//               ),
//               SizedBox(height: 24),

//               controller.isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                     onPressed: () async {
//                       final username = emailCtrl.text.trim();
//                       final password = passCtrl.text.trim();

//                       if (username.isEmpty || password.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Completa todos los campos')),
//                         );
//                         return;
//                       }

//                       final success = await controller.login(
//                         username,
//                         password,
//                       );

//                       if (success) {
//                         context.go(
//                           '/dashboard/principal',
//                         ); // reemplaza Navigator.pushReplacementNamed
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               controller.error ?? 'Error desconocido',
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       minimumSize: Size(double.infinity, 48),
//                     ),
//                     child: Text(
//                       'Iniciar Sesión',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),

//               SizedBox(height: 24),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('¿No tienes cuenta?'),
//                   TextButton(
//                     onPressed: () => context.push('/register'),
//                     child: Text('Regístrate'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
