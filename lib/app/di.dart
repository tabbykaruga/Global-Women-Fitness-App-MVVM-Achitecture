import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:learning_mvvm_architecture/app/app_prefs.dart';
import 'package:learning_mvvm_architecture/data/dataSource/remoteDataSource.dart';
import 'package:learning_mvvm_architecture/data/network/app_api.dart';
import 'package:learning_mvvm_architecture/data/network/dio_factory.dart';
import 'package:learning_mvvm_architecture/data/network/networkInfo.dart';
import 'package:learning_mvvm_architecture/data/repository/repositoryImplementor.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import 'package:learning_mvvm_architecture/domain/usecase/LoginUseCase.dart';
import 'package:learning_mvvm_architecture/presentation/login/loginViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> intAppModule() async {
  final sharedPrefs =await SharedPreferences.getInstance();

  //one instance of shared preference
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  //dio factory
  instance
      .registerLazySingleton<DioFactory>(() => DioFactory());

  //app service
  final dio = await instance<DioFactory>().getDio();
  instance
      .registerLazySingleton<AppServiceUser>(() => AppServiceUser(dio));

  //remote datasource
  instance
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  //repository
  instance
      .registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance()
  ));

}

initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
