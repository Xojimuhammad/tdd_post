import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_post/data/datasources/post_local_data_source.dart';
import 'package:tdd_post/data/repositories/post_repository_imp.dart';
import 'package:tdd_post/domain/repositories/post_base_repository.dart';
import 'package:tdd_post/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:tdd_post/presentation/blocs/post/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_post/presentation/pages/home_page.dart';
import 'core/network/network_info.dart';
import 'data/datasources/post_remote_data_sources.dart';
import 'domain/usecases/create_post_usercase.dart';
import 'domain/usecases/delete_post_usercase.dart';
import 'domain/usecases/edit_post_usercase.dart';
import 'domain/usecases/get_all_post_usecases.dart';
import 'domain/usecases/get_one_post_usercase.dart';

var locator = GetIt.instance;

Future<void> init() async {

  // bloc
  locator.registerFactory(() => PostBloc(
    getOnePostUseCase: locator(),
    getAllPostUseCase: locator(),
    createPostUseCase: locator(),
    editPostUseCase: locator(),
    deletePostUseCase: locator(),
  ));

  locator.registerFactory(() => NavigationBloc(currentPage: HomePage.id));

  // use case
  locator.registerLazySingleton(() => GetAllPostUseCase(locator()));
  locator.registerLazySingleton(() => GetOnePostUseCase(locator()));
  locator.registerLazySingleton(() => CreatePostUseCase(locator()));
  locator.registerLazySingleton(() => EditPostUseCase(locator()));
  locator.registerLazySingleton(() => DeletePostUseCase(locator()));

  // core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // repository
  locator.registerLazySingleton<PostBaseRepository>(() => PostRepositoryImp(localDataSource: locator(), remoteDataSource: locator(), info: locator()));

  // data source
  locator.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: locator()));
  locator.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: locator()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}