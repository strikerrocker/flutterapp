import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';

import 'login_view_model.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 50),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    onChanged: (value) => model.email = value,
                    validator:
                        EmailValidator(errorText: "Enter a valid email id"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "Password"),
                    onChanged: (value) => model.password = value,
                    validator: MinLengthValidator(8,
                        errorText: "Password should be at least 8 characters"),
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: model.submit,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model.errorText,
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}