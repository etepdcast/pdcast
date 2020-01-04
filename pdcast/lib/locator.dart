import 'package:get_it/get_it.dart';
import 'package:pdcast/src/core/daos/podcast_dao.dart';
import 'package:pdcast/src/core/daos/usuario_dao.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/core/services/usuario_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => PodCastDao());
  locator.registerLazySingleton(() => UsuarioDao());

  locator.registerLazySingleton(() => PodCastService());
  locator.registerLazySingleton(() => UsuarioService());
}