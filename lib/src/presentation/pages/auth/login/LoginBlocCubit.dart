import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// Services y Caso de uso
// import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/LoginUseCase.dart';

// Models
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';

// Bloc
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginBlocState.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {
  AuthUsesCases authUsesCases;

  LoginBlocCubit(this.authUsesCases) : super(LoginInitial());

  // Instancia - Caso de uso
  // AuthService authService = AuthService();
  // LoginUseCase loginUseCase = LoginUseCase();
  


  final _responseController = BehaviorSubject<Resource>();
  final _usernameController = BehaviorSubject<String>(); // Capturar datos
  final _passwordController = BehaviorSubject<String>(); // Capturar datos

  // Metodos Get
  Stream<String> get usernameStream => _usernameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

  // Metodos
  void changeUsername(String username) {
    if (username.isNotEmpty && username.length <= 1) {
      _usernameController.sink.addError('No debe estar vacio');
    } else {
      _usernameController.sink.add(username);
    }
  }

  void changePassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink.addError(
        'La contraseña debe tener más de 6 caracteres...',
      );
    } else {
      _passwordController.sink.add(password);
    }
  }

  Stream<bool> get validateForm =>
      Rx.combineLatest2(usernameStream, passwordStream, (a, b) => true);

  void dispose() {
    // Cuando pasemos a otra pantalla
    changeUsername('');
    changePassword('');
  }

  void login() async {
    _responseController.add(Loading());

    await Future.delayed(Duration(seconds: 4), () {});

    Resource response = await authUsesCases.login.run(
      _usernameController.value,
      _passwordController.value,
    );
    _responseController.add(response);

    Future.delayed(Duration(seconds: 1), () {
      _responseController.add(Initial());
    });

    // print('RESPUESTA: ${response}');
  }
}
