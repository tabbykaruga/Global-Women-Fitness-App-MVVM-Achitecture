
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/splash/splash.dart';
import 'package:learning_mvvm_architecture/presentation/forgotPassword/forgotPassword.dart';
import 'package:learning_mvvm_architecture/presentation/login/login.dart';
import 'package:learning_mvvm_architecture/presentation/main/mainView.dart';
import 'package:learning_mvvm_architecture/presentation/onBoarding/onBoarding.dart';
import 'package:learning_mvvm_architecture/presentation/register/register.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/storeDetails/storeDetails.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeRoute = "/store";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (_)=> const SplashView());
      case Routes.onBoardingRoute :
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.loginRoute :
        return MaterialPageRoute(builder: (_)=> const LoginView());
      case Routes.registerRoute :
        return MaterialPageRoute(builder: (_)=> const RegisterView());
      case Routes.forgotPasswordRoute :
        return MaterialPageRoute(builder: (_)=> const ForgotPasswordView());
      case Routes.mainRoute :
        return MaterialPageRoute(builder: (_)=> const MainView());
      case Routes.storeRoute :
        return MaterialPageRoute(builder: (_)=> const StoreDetailsView());
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

