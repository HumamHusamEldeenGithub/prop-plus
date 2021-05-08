import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault() ;
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prop+",
      home: Text("WELCOME"),
    );
  }
}

