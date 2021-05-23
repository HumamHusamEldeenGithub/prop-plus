
import 'package:auto_size_text/auto_size_text.dart';
import'package:flutter/material.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/shared/custom_text_field.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email,_password,_name;
  final formKey = GlobalKey<FormState>();
  String imageUrl = 'images/background.jpg';
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
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
            AutoSizeText(
              "Create An Account",
              maxLines: 1,
              minFontSize: 30,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: _height*0.05,),
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
    );
  }

// using to make sure that all inputs  of the textfields are validate
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
      //catch the warning a use show alert
    }
  }

// to build all the textFields
  List<Widget> buildInputsFields(){

    List<Widget> textFields = [] ;
    textFields.add(
        CustomTextField(secondaryColor: secondaryColor, validate: NameValidator.validate, icon: Icons.account_circle, hintText: "Name", saved: _name)
    );
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


//to build all the buttons
  List<Widget> buildButtons(){
    return [
      Container(
        width: MediaQuery.of(context).size.width*0.7,
        child: RaisedButton(
          child: Text(
            "SignUp",
            style: TextStyle(fontSize: 20.0 ,color: Colors.blue),
          ),
          color: Colors.white,

          onPressed: (){

          },
        ),
      ),
      FlatButton(
        child: Text("Already have an account ? SignIn", style:TextStyle(fontSize: 20.0 , color: Colors.white),),
        onPressed: (){

        },
      ),


    ];
  }



}


