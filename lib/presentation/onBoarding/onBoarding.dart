import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_mvvm_architecture/presentation/resources/assetsManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/colorManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(AppString.onBoardingSubTitle1,
            AppString.onBoardingSubTitle1, ImageAssets.slideImage1),
        SliderObject(AppString.onBoardingSubTitle1,
            AppString.onBoardingSubTitle1, ImageAssets.slideImage2),
        SliderObject(AppString.onBoardingSubTitle1,
            AppString.onBoardingSubTitle1, ImageAssets.slideImage3),
        SliderObject(AppString.onBoardingSubTitle1,
            AppString.onBoardingSubTitle1, ImageAssets.slideImage4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(

        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //g

                },
                child: Text(
                  AppString.skip,
                  style:Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.arrow_left,color: ColorManager.blue),
              ),
              onTap: () {
                //go previous slide
                _pageController.animateToPage(_getPreviousIndex(),
                    duration: const Duration(milliseconds: DurationConst.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          //circle indicators
          Row(
            children: [
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i),
                )
            ],
          ),
          //right Arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.arrow_right,color: ColorManager.blue),
              ),
              onTap: () {
                //go next
                _pageController.animateToPage(_getNextIndex(),
                    duration: const Duration(milliseconds: DurationConst.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          )
        ],
      ),
    );
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length -
          1; //infinite loop to go to the length of the slider list
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //infinite loop to go to first item in the slider list
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return  Icon(Icons.circle_outlined,color: ColorManager.blue); //selected
    } else {
      return Icon(Icons.circle_rounded,color: ColorManager.blue);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        Image.asset(_sliderObject.image)
      ],
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
