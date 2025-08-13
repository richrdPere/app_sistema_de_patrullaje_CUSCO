import 'package:app_sistema_de_patrullaje/injection.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc's
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (BuildContext context) => LoginBloc(locator<AuthUsesCases>())..add(InitEvent()),
  ),
  BlocProvider<RegisterBloc>(
    create: (BuildContext context) => RegisterBloc(locator<AuthUsesCases>())..add(RegisterInitEvent()),
  ),
];
