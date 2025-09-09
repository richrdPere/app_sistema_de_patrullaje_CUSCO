import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Services y Caso de uso
// import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';

// Models
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';

// Bloc
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthUsesCases authUsesCases;

  LoginBloc(this.authUsesCases) : super(LoginState()) {
    on<InitEvent>(_onInitEvent);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginFormReset>(_onLoginFormReset);
  }

  final formKey = GlobalKey<FormState>();

  // FUNCIONES
  Future<void> _onLoginFormReset(
    LoginFormReset event,
    Emitter<LoginState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onInitEvent(InitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onUsernameChanged(
    UsernameChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        username: BlocFormItem(
          value: event.username.value,
          error: event.username.value.isNotEmpty ? null : 'Ingrese su Username',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error:
              event.password.value.isNotEmpty &&
                      event.password.value.length >= 5
                  ? null
                  : 'Ingrese su Contraseña',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));
    Resource<AuthResponse> response = await authUsesCases.login.run(
      state.username.value,
      state.password.value,
    );
    emit(state.copyWith(response: response, formKey: formKey));
  }

  // // Captures
  // final _responseController = BehaviorSubject<Resource>();
  // final _usernameController = BehaviorSubject<String>(); // Capturar datos
  // final _passwordController = BehaviorSubject<String>(); // Capturar datos

  // // Metodos Get
  // Stream<String> get usernameStream => _usernameController.stream;
  // Stream<String> get passwordStream => _passwordController.stream;
  // Stream<Resource> get responseStream => _responseController.stream;

  // // Metodos
  // void changeUsername(String username) {
  //   if (username.isNotEmpty && username.length <= 1) {
  //     _usernameController.sink.addError('No debe estar vacio');
  //   } else {
  //     _usernameController.sink.add(username);
  //   }
  // }

  // void changePassword(String password) {
  //   if (password.isNotEmpty && password.length < 6) {
  //     _passwordController.sink.addError(
  //       'La contraseña debe tener más de 6 caracteres...',
  //     );
  //   } else {
  //     _passwordController.sink.add(password);
  //   }
  // }

  // Stream<bool> get validateForm =>
  //     Rx.combineLatest2(usernameStream, passwordStream, (a, b) => true);

  // void dispose() {
  //   // Cuando pasemos a otra pantalla
  //   changeUsername('');
  //   changePassword('');
  // }

  // void login() async {
  //   _responseController.add(Loading());
  //   // await Future.delayed(Duration(seconds: 4), () {});
  //   Resource response = await authUsesCases.login.run(
  //     _usernameController.value,
  //     _passwordController.value,
  //   );
  //   _responseController.add(response);
  //   Future.delayed(Duration(seconds: 1), () {
  //     _responseController.add(Initial());
  //   });

  //   // print('RESPUESTA: ${response}');
  // }
}
