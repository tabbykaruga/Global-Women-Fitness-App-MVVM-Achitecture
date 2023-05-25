import 'dart:async';

import 'package:learning_mvvm_architecture/domain/model.dart';
import 'package:learning_mvvm_architecture/presentation/base/baseViewModel.dart';

import '../resources/assetsManager.dart';
import '../resources/stringManager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //inputs
  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();

    //send slider data to our view
    _postDataToView();
  }

  @override
  int gePrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1; //infinite loop to go to the length of the slider list
    }
    return _currentIndex;
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //infinite loop to go to first item in the slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex =index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  List<SliderObject> _getSliderData() => [
    SliderObject(AppString.onBoardingSubTitle1, AppString.onBoardingSubTitle1,
        ImageAssets.slideImage1),
    SliderObject(AppString.onBoardingSubTitle1, AppString.onBoardingSubTitle1,
        ImageAssets.slideImage2),
    SliderObject(AppString.onBoardingSubTitle1, AppString.onBoardingSubTitle1,
        ImageAssets.slideImage3),
    SliderObject(AppString.onBoardingSubTitle1, AppString.onBoardingSubTitle1,
        ImageAssets.slideImage4),
  ];


  _postDataToView() {
    inputSliderViewObject.add(SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

}



//inputs means the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); //when user clicks on right arrow/swipe left
  void gePrevious(); //when user clicks on left arrow/swipe right
  void onPageChanged(int index);

  Sink get inputSliderViewObject; //adding data to stream ...stream input

}

//outputs means data/results that will be sent from v iew model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
