import 'package:equatable/equatable.dart';

// Utils
import 'package:app_sistema_de_patrullaje/src/presentation/utils/BlocFormItem.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends LoginEvent {
  const InitEvent();
}

// Reset campos
class LoginFormReset extends LoginEvent {
  const LoginFormReset();
}

// Username Changed
class UsernameChanged extends LoginEvent {
  final BlocFormItem username;
  const UsernameChanged({required this.username});
  @override
  List<Object?> get props => [username];
}

// Password Changed
class PasswordChanged extends LoginEvent {
  final BlocFormItem password;
  const PasswordChanged({required this.password});
  @override
  List<Object?> get props => [password];
}

// Login Submit
class LoginSubmit extends LoginEvent {
  const LoginSubmit();
}
