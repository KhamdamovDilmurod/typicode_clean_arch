import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:typicode_clean_arch/features/typicode/presentation/bloc/user_blog/users_bloc.dart';
import '../core/utilities/network_info.dart';
import 'config/routes/app_routes.dart';
import 'features/typicode/data/datasources/local/local_data_source.dart';
import 'features/typicode/data/datasources/remote/remote_data_source.dart';
import 'features/typicode/data/repositories/post_repository_impl.dart';
import 'features/typicode/data/repositories/user_repository_impl.dart';
import 'features/typicode/domain/repositories/post_repository.dart';
import 'features/typicode/domain/repositories/user_repository.dart';
import 'features/typicode/domain/usecases/get_post_usecase.dart';
import 'features/typicode/domain/usecases/get_posts_usecase.dart';
import 'features/typicode/domain/usecases/get_saved_posts_usecases.dart';
import 'features/typicode/domain/usecases/get_user_usecase.dart';
import 'features/typicode/domain/usecases/remove_post_usecase.dart';
import 'features/typicode/domain/usecases/save_post_usecase.dart';
import 'features/typicode/presentation/bloc/post_blog/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - TYPICODE
  // Blocs
  sl.registerFactory(
    () => PostsBloc(
        getPostsUseCase: sl(),
        removePostUseCase: sl(),
        savePostUseCase: sl(),
        getPostUseCase: sl(),
        getSavedPostsUseCase: sl()),
  );

  sl.registerFactory(
    () => UsersBloc(getUsersUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => RemovePostUseCase(sl()));
  sl.registerLazySingleton(() => SavePostUseCase(sl()));
  sl.registerLazySingleton(() => GetSavedPostsUseCase(sl()));
  sl.registerLazySingleton(() => GetPostUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(), // Adjust according to your implementation
  );

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
        client: sl()), // Assuming `client` is needed for RemoteDataSource
  );

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(), // Adjust according to your implementation
  );

  // HTTP Client
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  // App Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter());
}
