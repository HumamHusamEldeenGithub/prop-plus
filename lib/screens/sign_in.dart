import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/provider.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email,_password ,_warning;
  final formKey = GlobalKey<FormState>(); // used by validator && Form Widget
  final Color secondaryColor = Color(0xff232c51);
  final Color primaryColor = Color(0xff18203d);
  @override
  Widget build(BuildContext context) {
    //get the screen size
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
            showAlert(),
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
// to build all the textFields
  List<Widget> buildInputsFields(){

    List<Widget> textFields = [] ;

    textFields.add(SizedBox(height: 20.0,));

    textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildInputDecoration("Email"),
          onSaved: (value) => _email = value,
        )
    );

    textFields.add(SizedBox(height: 20.0,));

    textFields.add(
        TextFormField(
          validator: PasswordValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildInputDecoration("Password"),
          obscureText: true,
          onSaved: (value) => _password = value,
        )
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
            "SignIn",
            style: TextStyle(fontSize: 20.0 ,color: Colors.blue),
          ),
          color: Colors.white,

          onPressed: (){
            submit();
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
          Navigator.of(context).pushReplacementNamed('/signUp');
        },
      ),
      Divider(),
      buildSocialIcons(),

    ];
  }
// build social buttons like Google Sign In button
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

  void submit() async{
    if(validate()){
      //call the auth methods
      //SignIn
      try{
        /*final auth = Provider.of(context).auth;
        auth.signInWithEmailAndPassword(_email, _password);*/
        locater.get<UserController>().signInWithEmailAndPassword(_email, _password);
        Navigator.of(context).pushReplacementNamed('/home');

      }
      catch(e){
        setState(() {
          _warning = e.message;
        });
      }

    }
  }

  Widget showAlert(){
    if(_warning !=null){
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
              onPressed: (){
                setState(() {
                  _warning =null;
                });
              },
            )

          ],
        ),
      );
    }
    else
      return SizedBox(height: 0,);
  }
// design the textFields
  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0)

    );
  }

}