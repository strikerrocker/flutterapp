import 'dart:developer';

import 'package:myapp/app/app.locator.dart';
import 'package:myapp/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final navigationService = locator<NavigationService>();

  Future<void> ready() async {
    final SharedPreferences prefs = await _prefs;
    bool? value = prefs.getBool("AppLoggedIn");
    if (value != null && value == true) {
      navigationService.navigateTo(Routes.homeView);
    } else {
      navigationService.navigateTo(Routes.loginView);
    }
  }
}
