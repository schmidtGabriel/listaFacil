import 'package:listafacil/util/Functions.dart';
import 'package:flutter/material.dart';
import 'package:listafacil/main.dart';
import 'package:listafacil/util/Activity.dart';

class splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends ActivityState {

  @override
  void didChangeBuildContext() {
    // TODO: implement didChangeBuildContext
    super.didChangeBuildContext();
    Future.delayed(Duration(seconds: 3)).then((_){
      app.pref.create().then((value) => {
        Navigator.of(context).pushReplacementNamed("minhasListas")

      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: app.PrimaryColor,
      child: Stack(
        children: [

          Positioned(
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text("Lista Facil"),
                )
            ),
          ),

          // Positioned(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Container(
          //       margin: EdgeInsets.only(bottom: 40.0),
          //       child: Text('© Artmark - Todos os direitos reservados',
          //         textScaleFactor: 1.0,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           decoration: TextDecoration.none,
          //           fontFamily: 'Aleo',
          //           fontStyle: FontStyle.normal,
          //           fontSize: 12.0,
          //           color: Colors.white
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }

}