import 'package:get_it/get_it.dart';
import 'package:jumpit_boilerplate/data/datasource/remote/remote_datasource.dart';
import 'package:jumpit_boilerplate/data/datasource/local/mock_http_request.dart';
import 'package:jumpit_boilerplate/data/datasource/remote/http_request.dart';
import 'package:jumpit_boilerplate/data/repositoryimpl/login_repository_impl.dart';
import 'package:jumpit_boilerplate/domain/usecase/login_usecase_impl.dart';
import 'package:jumpit_boilerplate/presentation/screen/bottom_tab_viewmodel.dart';
import 'package:jumpit_boilerplate/presentation/screen/login/login_viewmodel.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/home/home_viewmodel.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/my/my_viewmodel.dart';

final it = GetIt.instance;

/// {@category Architecture}
/// {@category ArchitectureKR}
Future<void> init() async {
  // section: viewmodel
  it.registerFactory(() => BottomTabViewModel());
  it.registerFactory(() => HomeViewModel());
  it.registerFactory(() => MyViewModel());
  it.registerFactory(() => LoginViewModel());

  // section: usecase
  it.registerLazySingleton<LoginUseCaseImpl>(
      () => LoginUseCaseImpl(it<LoginRepositoryImpl>()));

  // section: repositoryimpl
  it.registerLazySingleton<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(it<RemoteDataSource>()));

  // section: datasource -> you can choice to inject real/mock request for test
  // it.registerLazySingleton<RemoteDataSource>(() => HttpRequest()); // <- real api
  it.registerLazySingleton<RemoteDataSource>(
      () => MockHttpRequest()); // <- mock api
}
