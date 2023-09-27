import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "MAMA MIA!!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppSize.s180
      ),
    );
  }
}
