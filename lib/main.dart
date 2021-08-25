import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/screens/add_new_service_screen.dart';
import 'package:prop_plus/screens/adding_prop_form.dart';
import 'package:prop_plus/screens/all_services.dart';
import 'package:prop_plus/screens/anonymous_loading_screen.dart';
import 'package:prop_plus/screens/booking_calender_screen.dart';
import 'package:prop_plus/screens/explore.dart';
import 'package:prop_plus/screens/my_properties.dart';
import 'package:prop_plus/screens/home.dart';
import 'package:prop_plus/screens/bookings.dart';
import 'package:prop_plus/screens/favourites.dart';
import 'package:prop_plus/screens/profile.dart';
import 'package:prop_plus/screens/sign_in.dart';
import 'package:prop_plus/screens/sign_up.dart';
import 'package:prop_plus/screens/user_property_description_screen.dart';
import 'package:prop_plus/screens/welcome.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:prop_plus/shared/http_requests.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: new AuthService(),
      child: MaterialApp(
        theme: MainTheme.finalTheme,
        title: "Prop+",
        //initialRoute: '/',
        //routes: {'/': (context) => MainWidget()},
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/firstView': (BuildContext context) => WelcomeView(),
          '/signUp': (BuildContext context) => SignUpScreen(),
          '/signIn': (BuildContext context) => SignInScreen(),
          '/homeScreen': (BuildContext context) => MainWidget(),
          '/anonymousScreen': (BuildContext context) => AnonymousScreen(),
          '/propInputForm': (BuildContext context) => PropertyInputForm(),
          '/myProperties': (BuildContext context) => MyProperties(),
          '/explore': (BuildContext context) => Explore(),
          '/description': (BuildContext context) => DetailsScreen(),
          '/my_property_description': (BuildContext context) =>
              MyProperties_DetailsScreen(),
          '/add_new_service': (BuildContext context) => AddNewServiceScreen(),
          '/booking_calender_screen': (BuildContext context) =>
              BookingCalenderScreen(),
          '/all_services': (BuildContext context) => AllServices(),
        },
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  static var databaseData = new Map<String, List<dynamic>>();
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  SearchBar searchBar;
  List<Widget> Screens = [];
  List<Function> screenDBDataGetter = [];
  int _selectedIndex = 0;
  GlobalKey<HomeState> _homeGlobalKey = GlobalKey<HomeState>();
  GlobalKey<FavouritesState> _favouritesGlobalKey =
      GlobalKey<FavouritesState>();
  GlobalKey<BookingsState> _bookingsGlobalKey = GlobalKey<BookingsState>();
  GlobalKey<ProfileState> _profileGlobalKey = GlobalKey<ProfileState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                MainTheme.mainColor,
                MainTheme.secondaryColor,
              ],
            ),
          ),
        ),
        title: Text("Prop+"),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String searchText) {
    Navigator.pushNamed(context, Explore.path, arguments: searchText);
  }

  _MyHomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  Future<void> getDataFromDBForHome() async {
    MainWidget.databaseData['PropertyModules'] =
        await HTTP_Requests.getRecommendedProperties();

    MainWidget.databaseData['TrendingModules'] =
        await HTTP_Requests.getTrendingProperties("Hotels");

    MainWidget.databaseData['CategoriesModules'] =
        await HTTP_Requests.createCategoriesModules();

    _homeGlobalKey.currentState?.refreshPage();
    _profileGlobalKey.currentState?.refreshPage();
  }

  Future<void> getDataFromDBForFavorite() async {
    MainWidget.databaseData['FavouriteModules'] =
        await HTTP_Requests.getFavouriteProperties(
            locater<UserController>().currentUser.dbId);

    _favouritesGlobalKey.currentState?.refreshPage();
  }

  Future<void> getDataFromDBForBookings() async {
    // MainWidget.databaseData['PropertyModules'] =
    // await HTTP_Requests.getRecommendedProperties();

    _bookingsGlobalKey.currentState?.refreshPage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _MyHomePageState();
    getDataFromDBForHome();
    getDataFromDBForFavorite();
    Screens = [
      Home(
        parentFunction: getDataFromDBForHome,
        key: _homeGlobalKey,
      ),
      Favourites(
          parentFunction: getDataFromDBForFavorite, key: _favouritesGlobalKey),
      Bookings(
          parentFunction: getDataFromDBForFavorite, key: _bookingsGlobalKey),
      Profile(parentFunction: getDataFromDBForBookings, key: _profileGlobalKey)
    ];
    screenDBDataGetter = [
      getDataFromDBForHome,
      getDataFromDBForFavorite,
      getDataFromDBForBookings,
      getDataFromDBForBookings
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Screens[_selectedIndex];

    return Scaffold(
      appBar: searchBar.build(context),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                  icon: Icons.calendar_today,
                  text: 'Bookings',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  screenDBDataGetter[index]() ;
                  _selectedIndex = index;
                  print(index);
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
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool SignedIn = snapshot.hasData;
          return SignedIn ? MainWidget() : WelcomeView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
