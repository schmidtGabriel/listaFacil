import 'package:flutter/material.dart';
import 'package:listafacil/activity/minhasListas.dart';
import 'package:listafacil/activity/novaLista.dart';
import 'package:listafacil/activity/splash.dart';
import 'package:listafacil/activity/verLista.dart';
import 'activity/addProduto.dart';
import 'activity/editProduto.dart';
import 'model/Model.dart';
import 'util/SharedPreference.dart' as sp;

void main() {

  sp.init(); //Map<String, dynamic> values


  runApp(app());


}

class app extends StatelessWidget {

  static String title = "Lista Facil";
  static sp.SharedPreference pref;
  static Compra compra = Compra.isEmpty();

  static Color PrimaryColor = Color(0xff03497C);
  static Color bgColor = Color(0xffF8F8F8);

  @override
  Widget build(BuildContext context) {

    app.pref = sp.SharedPreference();

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: splash(),
      routes: {
        'splash': (BuildContext context) => splash(),
        'minhasListas': (BuildContext context) => minhasListas(),
        'novaLista': (BuildContext context) => novaLista(),
        'verLista': (BuildContext context) => verLista(),
        'addProduto': (BuildContext context) => addProduto(),
        'editProduto': (BuildContext context) => editProduto(),
      },
    );
  }
}

