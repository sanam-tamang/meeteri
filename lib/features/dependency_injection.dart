import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core/internet/internet_checker.dart';
import 'auth/blocs/auth_bloc/auth_bloc.dart';
import 'auth/repositories/auth_repository.dart';
import 'profile/repositories/user_repository.dart';

GetIt sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(() => AuthBloc(repository: sl()));


  //repositories
  sl.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(internetInfo: sl(), userRepository: sl()));

  sl.registerLazySingleton<BaseUserRepository>(
      () => UserRepository());
//core
  sl.registerLazySingleton<BaseInternetChecker>(
      () => InternetChecker(internetChecker: sl()));


//external 
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
