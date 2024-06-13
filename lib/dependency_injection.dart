import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meeteri/core/internet/internet_checker.dart';
import 'package:meeteri/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:meeteri/features/auth/repositories/auth_repository.dart';
import 'package:meeteri/features/chat/blocs/message_cubit/message_cubit.dart';
import 'package:meeteri/features/chat/blocs/messaged_users_cubit/messaged_users_cubit.dart';
import 'package:meeteri/features/post/blocs/post_bloc/post_bloc.dart';
import 'package:meeteri/features/profile/repositories/user_repository.dart';

GetIt sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(() => AuthBloc(repository: sl()));
  sl.registerLazySingleton(() => PostBloc());
  sl.registerLazySingleton(() => MessagedUsersCubit());
  sl.registerLazySingleton(() => MessageCubit());
  //repositories
  sl.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(internetInfo: sl(), userRepository: sl()));
  // sl.registerLazySingleton(() => PostRepository());

  sl.registerLazySingleton<BaseUserRepository>(() => UserRepository());
//core
  sl.registerLazySingleton<BaseInternetChecker>(
      () => InternetChecker(internetChecker: sl()));

//external
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
