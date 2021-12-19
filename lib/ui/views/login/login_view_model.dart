import 'package:myapp/app/app.router.dart';
import 'package:myapp/db/tables.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  String errorText = "";
  String email = "";

  String password = "";

  Future<void> submit() async {
    String error = "Incorrect email or password";
    /*List<User> x;
    x = await getUsers();*/
    /*for (User user in x) {
      log(user.toString());
      if (user.email == email) {
        if (user.password == password) {
          errorText = "";
          log("Logging in");
            final SharedPreferences prefs = await preferences;
          prefs.setString("myappUser", jsonEncode(user.toMap()));
          _navigationService.navigateTo(Routes.homeView,
              arguments: HomeViewArguments(user: user));
          break;
        } else {
          errorText = error;
          break;
        }
      }
    }*/
    final SharedPreferences prefs = await preferences;
    String? value = prefs.getString("myappUser");
    if (value != null && value != "" && value != "null") {
      print(value);
      navigationService.navigateTo(Routes.homeView,
          arguments: HomeViewArguments(user: User.fromString(value)));
    } else {
      errorText = error;
    }
    notifyListeners();
  }

  void signup() {
    navigationService.navigateTo(Routes.signupView);
  }
}
