import 'package:myapp/app/app.locator.dart';
import 'package:myapp/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _errorText = "";

  String get errorText => _errorText;
  String email = "";

  final _navigationService = locator<NavigationService>();

  String password = "";

  Future<void> submit() async {
    if (email != "test@test.com") {
      _errorText = "Incorrect email";
      notifyListeners();
    } else if (password != "testtest") {
      _errorText = "Incorrect password";
      notifyListeners();
    } else {
      final SharedPreferences prefs = await _prefs;
      prefs.setBool("AppLoggedIn", true);
      _navigationService.navigateTo(Routes.homeView);
    }
  }
}
