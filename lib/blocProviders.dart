import 'package:app_sistema_de_patrullaje/injection.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc's
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/auth/register/RegisterBlocCubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBlocCubit>(
    create: (BuildContext context) => LoginBlocCubit(locator<AuthUsesCases>()),
  ),
  BlocProvider<RegisterBlocCubit>(
    create: (BuildContext context) => RegisterBlocCubit(locator<AuthUsesCases>()),
  ),
];
