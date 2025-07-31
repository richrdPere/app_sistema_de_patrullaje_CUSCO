import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Services y Caso de uso
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterBlocState.dart';

// Bloc

import 'package:rxdart/rxdart.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  AuthUsesCases authUsesCases;

  RegisterBlocCubit(this.authUsesCases) : super(RegisterInitial());

  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _dniController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _responseController = BehaviorSubject<Resource>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get dniStream => _dniController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

  // VALIDADORS
  Stream<bool> get validateForm => Rx.combineLatest7(
    nameStream,
    lastnameStream,
    emailStream,
    phoneStream,
    dniStream,
    passwordStream,
    confirmPasswordStream,
    (a, b, c, d, e, f, g) => true,
  );

  // FUNCION GENERICA
  void changeField({
    required String value,
    required BehaviorSubject<String> controller,
    required String fieldName,
    int minLength = 2,
  }) {
    if (value.isNotEmpty && value.length < minLength) {
      controller.sink.addError('El $fieldName es muy corto');
    } else {
      controller.sink.add(value);
    }
  }

  // FUNCIONES CHANGED
  void changeName(String value) {
    changeField(value: value, controller: _nameController, fieldName: 'nombre');
  }

  void changeLastname(String value) {
    changeField(
      value: value,
      controller: _lastnameController,
      fieldName: 'apellido',
    );
  }

  void changeEmail(String email) {
    bool emailFormatValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (email.isNotEmpty && email.length < 5) {
      _emailController.sink.addError('Al menos 5 caracteres');
    } else if (email.isNotEmpty && !emailFormatValid) {
      _emailController.sink.addError('El email no es valido');
    } else {
      _emailController.sink.add(email);
    }
  }

  void changePhone(String phone) {
    if (phone.isNotEmpty && phone.length < 9) {
      _phoneController.sink.addError('No es un numero de telefono valido');
    } else {
      _phoneController.sink.add(phone);
    }
  }

  void changeDni(String dni) {
    if (dni.isNotEmpty && dni.length < 8) {
      _dniController.sink.addError('No es un DNI valido');
    } else {
      _dniController.sink.add(dni);
    }
  }

  void changePassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink.addError('Al menos 6 caracteres');
    } else {
      _passwordController.sink.add(password);
    }
  }

  void changeConfirmPassword(String confirmPassword) {
    final password = _passwordController.valueOrNull ?? '';

    // print('password: $password');
    // print('confirmPassword: $confirmPassword');

    if (confirmPassword.isNotEmpty && confirmPassword.length < 6) {
      _confirmPasswordController.sink.addError('Al menos 6 caracteres');
    } else if (confirmPassword.isNotEmpty && confirmPassword != password) {
      _confirmPasswordController.sink.addError('Las contraseñas no coinciden');
    } else {
      _confirmPasswordController.sink.add(confirmPassword);
    }
  }

  toSereno() => SerenoModel(
    firstName: _nameController.value,
    lastName: _lastnameController.value,
    phone: _phoneController.value,
    email: _emailController.value,
    dni: _dniController.value,
    username: _dniController.value,
    password: _passwordController.value,
    role: "sereno",
  );

  void register() async {
    _responseController.add(Loading());

    Resource<AuthResponse> response = await authUsesCases.register.run(
      toSereno(),
    );

    _responseController.add(response);

    Future.delayed(Duration(seconds: 1), () {
      _responseController.add(Initial());
    });
  }

  void dispose() {
    changeName('');
    changeLastname('');
    changeEmail('');
    changePhone('');
    changeDni('');
    changePassword('');
    changeConfirmPassword('');
  }
}
