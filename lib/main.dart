import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/screens/adding_prop_form.dart';
import 'package:prop_plus/screens/anonymous_loading_screen.dart';
import 'package:prop_plus/screens/explore.dart';
import 'package:prop_plus/screens/home.dart';
import 'package:prop_plus/screens/notification.dart';
import 'package:prop_plus/screens/profile.dart';
import 'package:prop_plus/screens/sign_in.dart';
import 'package:prop_plus/screens/sign_up.dart';
import 'package:prop_plus/screens/welcome.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/provider.dart';
import 'package:prop_plus/shared/description_screen.dart';
import 'dart:developer' as developer;


/*Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
}
*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provider(
    auth: new AuthService(),
      child:MaterialApp(
        theme: MainTheme.finalTheme,
        title: "Prop+",
        //initialRoute: '/',
        //routes: {'/': (context) => MainWidget()},
        home:HomeController(),


        routes: <String,WidgetBuilder>{
          //'/': (context) => MainWidget(),
          '/home':(BuildContext context) =>HomeController(),
          '/firstView':(BuildContext context) => WelcomeView(),
          '/signUp':(BuildContext context) => SignUpScreen(),
          '/signIn':(BuildContext context) => SignInScreen(),
          '/homeScreen':(BuildContext context) =>MainWidget(),
          '/anonymousScreen':(BuildContext context) =>AnonymousScreen(),
          '/propInputForm':(BuildContext context) =>PropertyInputForm(),
        },


      ) ,
    );
  }

}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {



  // ignore: non_constant_identifier_names
  final List<Widget> Screens = [
    Home() ,
    Notifications(),
    Explore() ,
    Profile()
  ] ;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget currentWidget = Screens[_selectedIndex] ;


    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [MainTheme.mainColor, MainTheme.secondaryColor,],
              ),
            ),
          ),
          title: Text("Prop+"),

        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                    print(index) ;
                  });
                },
              ),
            ),
          ),
        ),
      body: Center(
        child: currentWidget,
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = locater.get<AuthService>();
    return StreamBuilder <String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot <String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool SignedIn = snapshot.hasData;
          developer.log(SignedIn.toString());
          return SignedIn ? MainWidget() : WelcomeView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}