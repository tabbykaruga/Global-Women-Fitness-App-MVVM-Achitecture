import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/resources/routesManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/themeManager.dart';


class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); default constructor

  MyApp._internal(); //private named constructor
  int appState = 0;
  // SINGLETON class is a class that can have just a single item (an occurrence of the class) at a time.
  // After the initial occasion when we attempt to start up the Singleton class, the new variable likewise
  // focuses on the primary instance made.
  static final MyApp instance =  MyApp._internal(); //single instance singleton

  factory MyApp() => instance; //factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
