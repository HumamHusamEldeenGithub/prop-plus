import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/shared/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email,_password;
  final formKey = GlobalKey<FormState>();
  final Color secondaryColor = Color(0xff232c51);
  final Color primaryColor = Color(0xff18203d);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        color: primaryColor,
        child: Column(
          children: [
            SizedBox(height: _height*0.1,),
            Text(
              "SignIn",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: _height*0.05,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                    children: buildInputsFields()+buildButtons()
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> buildInputsFields(){

    List<Widget> textFields = [] ;

    textFields.add(SizedBox(height: 20.0,));

    textFields.add(
        CustomTextField(secondaryColor: secondaryColor, validate: EmailValidator.validate, icon: Icons.email, hintText: "Email", saved: _email)
    );
    textFields.add(SizedBox(height: 20.0,));

    textFields.add(
        CustomTextField(secondaryColor: secondaryColor, validate: PasswordValidator.validate, icon: Icons.vpn_key, hintText: "Password", saved: _password)
    );
    textFields.add(SizedBox(height: 20.0,));


    return textFields;
  }

  List<Widget> buildButtons(){
    return [
      Container(
        width: MediaQuery.of(context).size.width*0.7,
        child: RaisedButton(
          child: Text(
            "SignIn",
            style: TextStyle(fontSize: 20.0 ,color: Colors.blue),
          ),
          color: Colors.white,

          onPressed: (){

          },
        ),
      ),
      FlatButton(
        child: Text("Forgot Your Password ?!", style:TextStyle(fontSize: 20.0 , color: Colors.white),),
        onPressed: (){

        },
      ),

      FlatButton(
        child: Text("Create a New Account ", style:TextStyle(fontSize: 20.0 , color: Colors.white),),
        onPressed: (){

        },
      ),
      Divider(),
      buildSocialIcons(),

    ];
  }

  Widget buildSocialIcons(){

    return Column(
      children: [
        Divider(color: Colors.white,),
        SizedBox(height: 10,),
        GoogleSignInButton(
          onPressed: ()  {
          },
        ),
      ],
    );
  }

  bool validate(){
    final  form =formKey.currentState;
    //form.save(); ////////////////////check
    if(form.validate()){
      form.save();
      return true;
    }
    else
      return false;


  }

  void submit(){
    if(validate()){
      //call the auth methods
      //SignIn
    }
  }


}