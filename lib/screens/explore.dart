import 'package:flutter/material.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/recommended_card.dart';

class Explore extends StatefulWidget {
  static String path = "/explore";

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {


  Future<List<MainModule>> getSearchResult(String searchText)async{
    var modules = await HTTP_Requests.getSearchResult(searchText);
    return modules ;
  }



  @override
  Widget build(BuildContext context) {
    String searchText = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text("Results for " + searchText),
        ),
        body: Center(
          child: FutureBuilder(
            future: getSearchResult(searchText),
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  MainModule module = snapshot.data[index];
                  return RecommendedCard(
                    module: module,
                  );
                },
              );
            },
          ),
        ),
    );
  }
}
