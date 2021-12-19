import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/app.router.dart';
import 'package:myapp/db/tables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../main.dart';

class SignupViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  DateTime dob = DateTime(1980, 1, 1);

  String errorText = "";

  String getDobAsString() {
    return DateFormat('yyyy-MM-dd').format(dob);
  }

  void updateDate(DateTime date) {
    dob = date;
    notifyListeners();
  }

  void signup(BuildContext context) async {
    /*String y=await getDatabasesPath();
    if (formKey.currentState!.validate()) {
      List<User> x;
      x = await getUsers();
      int id = 0;
      for (User user in x) {
        if(email == user.email){
          errorText="This email is already taken";
          notifyListeners();
          return;
        }
        if (user.id > id) {
          id = user.id;
        }
      }
      id = id + 1;
      User user = User(name: name,
          email: email,
          password: password,
          dob: dob,
          id: id);
      insertUser(user);
      _navigationService.navigateTo(
          Routes.homeView, arguments: HomeViewArguments(user:user));
    }*/
    User user =
        User(name: name, email: email, password: password, dob: dob, id: 0);
    final SharedPreferences prefs = await preferences;
    prefs.setString("myappUser", jsonEncode(user));
    //navigationService.navigateTo(Routes.homeView,arguments: HomeViewArguments(user: user));
    navigationService.navigateTo(Routes.loginView);
    notifyListeners();
  }
}
