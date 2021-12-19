import 'package:flutter/material.dart';
import 'package:myapp/app/app.router.dart';
import 'package:myapp/db/tables.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  Future<void> ready(BuildContext context) async {
    final SharedPreferences prefs = await preferences;
    String? value = prefs.getString("myappUser");
    if (value != null && value != "") {
      User user = User.fromString(value);
      navigationService.navigateTo(Routes.homeView,
          arguments: HomeViewArguments(user: user));
    } else {
      navigationService.navigateTo(Routes.loginView);
    }
  }
}
