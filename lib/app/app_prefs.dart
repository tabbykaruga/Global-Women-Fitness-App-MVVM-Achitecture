import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG ="PREFS_KEY_LANG";

class AppPreferences{
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);


}