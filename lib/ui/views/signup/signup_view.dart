import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'signup_view_model.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScreenTypeLayout.builder(
          mobile:  (BuildContext context) => getMobileView(context,model),
          desktop: (BuildContext context) => getDesktopView(context,model),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }

  Widget getNameField(SignupViewModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(
        width: 100,
        child: Text(
          "Name:",
          style: TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: TextFormField(
          validator: RequiredValidator(errorText: "This field is required"),
          onChanged: (value) => model.name = value,
        ),
        width: 250,
      ),
    ]);
  }

  Widget getEmailField(SignupViewModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(
        width: 100,
        child: Text(
          "Email:",
          style: TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: TextFormField(
          validator: EmailValidator(errorText: "Not a proper email"),
          onChanged: (value) => model.email = value,
        ),
        width: 250,
      ),
    ]);
  }

  Widget getDOBField(BuildContext context, SignupViewModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(
        width: 100,
        child: Text(
          "Date of Birth:",
          style: TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: TextButton(
          child: Text(
            model.getDobAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          onPressed: () => {
            DatePicker.showDatePicker(
              context,
              currentTime: model.dob,
              onConfirm: (date) => model.updateDate(date),
            )
          },
        ),
        width: 250,
      )
    ]);
  }

  Widget getMobileView(BuildContext context,SignupViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Form(
        key: model.formKey,
        child: Column(
          children: [
            const Text(
              "Signup",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            getNameField(model),
            const SizedBox(
              height: 20,
            ),
            getEmailField(model),
            const SizedBox(
              height: 20,
            ),
            getDOBField(context, model),
            const SizedBox(
              height: 20,
            ),
            getPasswordField(model),
            const SizedBox(
              height: 20,
            ),
            getPasswordConfirmField(model),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => model.signup(context),
              child: const Text(
                "Signup",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text(
              model.errorText,
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDesktopView(BuildContext context,SignupViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Form(
        key: model.formKey,
        child: Column(
          children: [
            Text(
              "Desktop View"
            ),
            const Text(
              "Signup",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            getNameField(model),
            const SizedBox(
              height: 20,
            ),
            getEmailField(model),
            const SizedBox(
              height: 20,
            ),
            getDOBField(context, model),
            const SizedBox(
              height: 20,
            ),
            getPasswordField(model),
            const SizedBox(
              height: 20,
            ),
            getPasswordConfirmField(model),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => model.signup(context),
              child: const Text(
                "Signup",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text(
              model.errorText,
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPasswordField(SignupViewModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(
        width: 100,
        child: Text(
          "Password:",
          style: TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: TextFormField(
          validator: MultiValidator([
            MinLengthValidator(8,
                errorText: "Password must be more than 8 characters"),
            RequiredValidator(errorText: "This field is required")
          ]),
          onChanged: (value) => model.password = value,
          obscureText: true,
        ),
        width: 250,
      ),
    ]);
  }

  Widget getPasswordConfirmField(SignupViewModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(
        width: 100,
        child: Text(
          "Confirm Password:",
          style: TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Password can't be empty";
            } else if (value.length < 8) {
              return "Password size can't be less than 8";
            } else if (value != model.password) {
              return "Passwords don't match";
            }
          },
          onChanged: (value) => model.confirmPassword = value,
          obscureText: true,
        ),
        width: 250,
      ),
    ]);
  }
}
