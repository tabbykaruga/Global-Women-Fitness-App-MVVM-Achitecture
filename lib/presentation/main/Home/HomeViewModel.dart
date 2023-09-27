import 'dart:async';
import 'dart:ffi';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/presentation/base/baseViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';
import '../../../domain/usecase/HomeUseCase.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;

  final _dataStreamController =BehaviorSubject<HomeViewObject>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullscreenLoadingState));
    
    (await _homeUseCase.execute(Void)).fold((failure){
      inputState.add(ErrorState(stateRenderType: StateRenderType.fullscreenErrorState,message: failure.message));
    }, (homeObject){
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.exercises,
          homeObject.data.services, homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;

}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Exercise> exercise;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.exercise, this.services, this.banners);
}