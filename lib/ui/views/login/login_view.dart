import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScreenTypeLayout.builder(
          mobile: (BuildContext context) => getMobileView(context, model),
          desktop: (BuildContext context) => getDesktopView(context, model),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }

  Widget getMobileView(BuildContext context, LoginViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 180, horizontal: 50),
      child: Form(
        child: Column(
          children: [
            getFields(model),
          ],
        ),
      ),
    );
  }

  Widget getDesktopView(BuildContext context, LoginViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 180, horizontal: 600),
      child: Form(
        child: Column(
          children: [
            getFields(model),
          ],
        ),
      ),
    );
  }

  Widget getFields(LoginViewModel model) {
    return Column(
      children: [
        const Text(
          "Sign In",
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Email",
          ),
          onChanged: (value) => model.email = value,
          validator: EmailValidator(errorText: "Enter a valid email id"),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: "Password"),
          onChanged: (value) => model.password = value,
          obscureText: true,
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: model.signup,
          child: const Text(
            "Sign up",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: model.submit,
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.errorText,
        )
      ],
    );
  }
}
