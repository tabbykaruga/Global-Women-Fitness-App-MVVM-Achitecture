import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateAppState(){
    MyApp.instance.appState = 10;
  }

  void getAppState(){
    print(MyApp.instance.appState); //output is 10
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
