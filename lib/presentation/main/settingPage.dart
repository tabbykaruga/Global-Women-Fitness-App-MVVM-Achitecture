import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/app/app_prefs.dart';
import 'package:learning_mvvm_architecture/app/di.dart';
import 'package:learning_mvvm_architecture/data/dataSource/localDataSources.dart';
import 'package:learning_mvvm_architecture/presentation/resources/routesManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppString.darkMode, style: Theme
              .of(context)
              .textTheme
              .labelMedium),
          leading: const Icon(Icons.toggle_on_outlined),
          onTap: () {},
        ), ListTile(
          title: Text(AppString.contactUs, style: Theme
              .of(context)
              .textTheme
              .labelMedium),
          leading: const Icon(Icons.language),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _contactUs();
          },
        ), ListTile(
          title: Text(AppString.inviteFriends, style: Theme
              .of(context)
              .textTheme
              .labelMedium),
          leading: const Icon(Icons.share),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _inviteFriends();
          },
        ), ListTile(
          title: Text(AppString.logout, style: Theme
              .of(context)
              .textTheme
              .labelMedium),
          leading: const Icon(Icons.logout),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }


  void _contactUs() {

  }

  void _inviteFriends() {

  }

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}