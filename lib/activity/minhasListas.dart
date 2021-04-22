
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listafacil/model/Model.dart';
import 'package:listafacil/util/Activity.dart';
import 'package:listafacil/util/Message.dart';


import '../main.dart';

class minhasListas extends StatefulWidget {
  @override
  _minhasListas createState() => _minhasListas();
}
class _minhasListas extends ActivityState {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController list;
  bool isVisible = true;
  bool favorite = false;
  bool isLoading = false;
  bool progress = true;
  String filter = "";
  int page = 0;
  int limit = 10;



  void showToast() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    list = ScrollController();
    //   list.addListener(_scrollListener);
    super.initState();

    // var json = app.pref.getJson("listas");


  }

  @override
  void didChangeBuildContext() {

  }

  Future<void> share(Lista lista) async {
    bool result = await FlutterShare.share(
        title: '*Lista*',
        text: mountLista(lista),
    );

    return result;

  }

  String mountLista(Lista lista){
    String result = "*Lista SuperMarket* \n"+ lista.nome+ "\n";

    if(lista.produtos.length == 0){return result;}
    for(var i=0; i < lista.produtos.length; i++){
      result = result+"~${lista.produtos[i].nome}";
      if(lista.produtos[i].comprado == true){
        result = result+"~\n";
      }else{
        result = result+"\n";
      }
    }


    return result+"\n\n"+lista.formattedTotal;
  }


  //Listblock
  Widget buildRow(BuildContext context, int idx) {
    Lista lista = app.compra.listas[idx];

    return GestureDetector(
      onTap: (){
         Navigator.of(context).pushNamed("verLista", arguments: lista.toMap()).then((value) => {

           if(value != null){
             setState((){
               app.compra.listas.insert(idx+1, Lista.fromJson(value));
               app.compra.listas.removeAt(idx);
               app.pref.set(this, "listas", jsonEncode(app.compra.toMap()));

             })
           }
         });

      },
        onLongPress: (){
          Navigator.of(context).pushNamed("novaLista", arguments: lista.toMap()).then((value) => {

          setState((){
            Map<String, dynamic> json = app.pref.getJson("listas");
            app.compra = Compra.fromJson(json);
          })


          });
        },
      child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
        height: 80.0,
        margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: (lista.finalizada == true)?Colors.green:Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: app.PrimaryColor, width: 1, style: BorderStyle.solid)
        ),
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [



              Container(
                alignment: Alignment.centerLeft,
                child:Text((lista.finalizada == true)?lista.nome+ " - " +lista.formattedTotal.toString():lista.nome,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Aleo',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: (lista.finalizada == true)?Colors.white:app.PrimaryColor,
                  ),
                ),
              ),

                Container(
                  alignment: Alignment.centerLeft,
                  child:Text(lista.data,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: (lista.finalizada == true)?Colors.white:app.PrimaryColor,
                    ),
                  ),
                ),



            ]),

      ),
          actions: [
            IconSlideAction(
              caption: 'Compartilhar',
              color: Colors.blue,
              icon: Icons.share,
              onTap: () => {
                share(lista).then((value) => {
                Message.fromMsg(this, context, "Lista compartilhada com sucesso.").show(false)

                })
              },
            ),
          ],
        secondaryActions: <Widget>[
            IconSlideAction(
            caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => {
              setState((){
                app.compra.listas.removeAt(idx);
                app.pref.set(this, "listas", jsonEncode(app.compra.toMap()));
              })
              },
            )
        ])
    );

  }


  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  Widget topbar(BuildContext context, GlobalKey<ScaffoldState> drawerKey){

    return PreferredSize(child:
    Container(
        height: 80.0,
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: app.PrimaryColor,
        ),
        child: Text(
          "Minhas Listas".toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,

        )
    ),
        preferredSize: MediaQuery.of(context).size
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);


    if(app.pref.sharedPreference != null) {
      if (app.pref.sharedPreference.containsKey("listas")) {
        Map<String, dynamic> json = app.pref.getJson("listas");
         app.compra = Compra.fromJson(json);
        // app.pref.remove(this, "listas");
      }
    }





    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);

          /// It's important that returned value (boolean) is false,
          /// otherwise, it will pop the navigator stack twice;
          /// since Navigator.pop is already called above ^
          return false;
        },
        child: Scaffold(
          appBar: topbar(context, drawerKey),
          body:Container(
            color: Colors.grey,
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [



                SingleChildScrollView(
                  controller: list,
                  padding: EdgeInsets.only(bottom: 100.0),
                  child:Container(
                    child:Column(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Listas'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Aleo',
                              fontWeight:FontWeight.bold,
                              fontSize: 20.0,
                              color: app.PrimaryColor,
                            ),
                          ),
                        ),

                        (app.compra.listas.length > 0)?
                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: double.infinity, minHeight: 1.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 0.0),
                              itemCount: app.compra.listas.length,
                              itemBuilder: (BuildContext context, int index) => buildRow(context, index),
                            )):Container(),


                        GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pushNamed("novaLista", arguments: null).then((value) => {
                                setState((){
                                  Map<String, dynamic> json = app.pref.getJson("listas");
                                  app.compra = Compra.fromJson(json);
                                })
                              });

                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Text("Nova Lista", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
        ));
  }
}

