import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_mvvm_architecture/app/app_prefs.dart';
import 'package:learning_mvvm_architecture/data/dataSource/remoteDataSource.dart';
import 'package:learning_mvvm_architecture/data/network/app_api.dart';
import 'package:learning_mvvm_architecture/data/network/dio_factory.dart';
import 'package:learning_mvvm_architecture/data/network/networkInfo.dart';
import 'package:learning_mvvm_architecture/data/repository/repositoryImplementor.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import 'package:learning_mvvm_architecture/domain/usecase/ForgotPasswordUseCase.dart';
import 'package:learning_mvvm_architecture/domain/usecase/HomeUseCase.dart';
import 'package:learning_mvvm_architecture/domain/usecase/LoginUseCase.dart';
import 'package:learning_mvvm_architecture/domain/usecase/RegisterUseCase.dart';
import 'package:learning_mvvm_architecture/presentation/forgotPassword/forgotPasswordViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/login/loginViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/main/Home/HomeViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/register/registerViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/dataSource/localDataSources.dart';

final instance = GetIt.instance;

Future<void> intAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  //one instance of shared preference
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  //app service
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceUser>(() => AppServiceUser(dio));

  //remote datasource
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //local datasource
  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImplementer());

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initForgottenPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}
