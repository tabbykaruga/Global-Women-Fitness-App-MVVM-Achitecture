import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/main/Home/homePage.dart';
import 'package:learning_mvvm_architecture/presentation/main/searchPage.dart';
import 'package:learning_mvvm_architecture/presentation/main/settingPage.dart';

import '../resources/colorManager.dart';
import '../resources/stringManager.dart';
import '../resources/valueManager.dart';
import 'notificationsPage.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePageView(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];
  List<String> titles = [
    AppString.home,
    AppString.search,
    AppString.notifications,
    AppString.settings,
  ];
  var _title = AppString.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          _title,
          textAlign: TextAlign.center,
        ),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.white),
        backgroundColor: ColorManager.pink1,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.pink1,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppString.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppString.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppString.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppString.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
