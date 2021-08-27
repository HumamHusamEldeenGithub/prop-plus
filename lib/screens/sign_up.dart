import 'dart:convert';
import 'dart:developer' as developer;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'package:prop_plus/shared/loading_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email, _password, _name, _phone = "0 ", _warning;
  final formKey = GlobalKey<FormState>();
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          color: primaryColor,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.025,
                ),
                showAlert(),
                AutoSizeText(
                  "Create An Account",
                  maxLines: 1,
                  minFontSize: 30,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputsFields() + buildButtons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// using to make sure that all inputs  of the textfields are validate
  bool validate() {
    final form = formKey.currentState;
    //form.save(); ////////////////////check
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  Future initializeUser() async {
    await locater
        .get<UserController>()
        .createUserWithEmailAndPassword(_email, _password, _name);
  }

  void submit() async {
    if (validate()) {
      LoadingDialog.showLoadingDialog(
        context,
        initializeUser(),
        Text("You've successfully signed up!"),
        Text("A problem has occured"), () {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed('/home');
        },
        true);
    }
  }

// to build all the textFields
  List<Widget> buildInputsFields() {
    List<Widget> textFields = [];

    textFields.add(TextFormField(
      validator: NameValidator.validate,
      style: TextStyle(fontSize: 22.0),
      decoration: buildSignUpInputDecoration("Name"),
      onSaved: (value) => _name = value,
    ));
    textFields.add(SizedBox(
      height: 20.0,
    ));

    textFields.add(TextFormField(
      validator: EmailValidator.validate,
      style: TextStyle(fontSize: 22.0),
      decoration: buildSignUpInputDecoration("Email"),
      onSaved: (value) => _email = value,
    ));
    textFields.add(SizedBox(
      height: 20.0,
    ));
    textFields.add(TextFormField(
      validator: PasswordValidator.validate,
      style: TextStyle(fontSize: 22.0),
      decoration: buildSignUpInputDecoration("Password"),
      obscureText: true,
      onSaved: (value) => _password = value,
    ));
    textFields.add(SizedBox(
      height: 20.0,
    ));

    return textFields;
  }

  //design the textFields
  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0)),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0));
  }

//to build all the buttons
  List<Widget> buildButtons() {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          child: Text(
            "SignUp",
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          color: Colors.white,
          onPressed: () {
            submit();
          },
        ),
      ),
      FlatButton(
        child: Text(
          "Already have an account ? SignIn",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/signIn");
        },
      ),
    ];
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _warning = null;
                });
              },
            )
          ],
        ),
      );
    } else
      return SizedBox(
        height: 0,
      );
  }
}
