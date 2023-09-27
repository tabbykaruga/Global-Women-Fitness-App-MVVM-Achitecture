import 'package:shared_preferences/shared_preferences.dart';

// const String PREFS_KEY_LANG ="PREFS_KEY_LANG";
const String prefsKeyOnBoardingScreen ="PREFS_KEY_ONBOARDING_screen";
const String prefsKeyIsUserLoggedIn ="PREFS_KEY_IS_USER_LOGGED";

class AppPreferences{
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void>setOnBoardingScreenViewed()async{
    _sharedPreferences.setBool(prefsKeyOnBoardingScreen, true);
  }

  Future<bool> isOnBoardingScreenViewed()async{
   return _sharedPreferences.getBool(prefsKeyOnBoardingScreen) ?? false;
  }

  Future<void>setIsUserLoggedIn()async{
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn()async{
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }
}