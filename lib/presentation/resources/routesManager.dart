import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/app/di.dart';
import 'package:learning_mvvm_architecture/presentation/splash/splash.dart';
import 'package:learning_mvvm_architecture/presentation/forgotPassword/forgotPassword.dart';
import 'package:learning_mvvm_architecture/presentation/login/login.dart';
import 'package:learning_mvvm_architecture/presentation/onBoarding/onBoarding.dart';
import 'package:learning_mvvm_architecture/presentation/register/register.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/exerciseDetails/exerciseDetails.dart';

import '../main/Home/homePage.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "home";
  static const String exerciseRoute = "/exercise";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (_)=> const SplashView());
      case Routes.onBoardingRoute :
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.loginRoute :
        initLoginModule();
        return MaterialPageRoute(builder: (_)=> const LoginView());
      case Routes.registerRoute :
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=> const RegisterView());
      case Routes.forgotPasswordRoute :
        initForgottenPasswordModule();
        return MaterialPageRoute(builder: (_)=> const ForgotPasswordView());
      case Routes.mainRoute :
        initHomeModule();
        return MaterialPageRoute(builder: (_)=> const HomePageView());
      case Routes.exerciseRoute :
        return MaterialPageRoute(builder: (_)=> const ExerciseDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>
        Scaffold(
          appBar: AppBar(
            title: const Text(AppString.noRouteFound),
          ),
          body: const Center(
            child: Text(AppString.noRouteFound),
          )
        )
    );
  }
}

