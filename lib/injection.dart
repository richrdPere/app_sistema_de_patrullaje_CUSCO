
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Injection init
import 'package:app_sistema_de_patrullaje/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await locator.init();

