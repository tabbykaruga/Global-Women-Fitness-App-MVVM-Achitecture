import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/resources/assetsManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/colorManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/routesManager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();


  _startDelay(){
    _timer =Timer(const Duration(seconds: 5),_goNext);
  }

  _goNext() async{
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) =>{
      if(isUserLoggedIn){
        //navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute)

      }else{
        _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) => {
          if(isOnBoardingScreenViewed){
            Navigator.pushReplacementNamed(context, Routes.loginRoute)

          }else{
            //first time
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)

          }
        })
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo3),
        ),
      ),
    );
  }
}
