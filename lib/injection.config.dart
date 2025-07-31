// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart'
    as _i652;
import 'package:app_sistema_de_patrullaje/src/di/AppModule.dart' as _i582;
import 'package:app_sistema_de_patrullaje/src/domain/repositories/AuthRepository.dart'
    as _i862;
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart'
    as _i550;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i652.AuthService>(() => appModule.authService);
    gh.factory<_i862.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i550.AuthUsesCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i582.AppModule {}
