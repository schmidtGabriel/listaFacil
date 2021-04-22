
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:listafacil/model/Model.dart';
import 'package:listafacil/util/Activity.dart';


import '../main.dart';

class novaLista extends StatefulWidget {
  @override
  _novaLista createState() => _novaLista();
}
class _novaLista extends ActivityState {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController list;
  bool isVisible = true;
  bool favorite = false;
  bool isLoading = false;
  bool progress = true;
  String filter = "";
  int page = 0;
  int limit = 10;

  Lista lista = Lista.isEmpty();

  var controllerNome = TextEditingController();

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


  }

  @override
  void didChangeBuildContext() {

  }



  //Listblock
  Widget buildRow(BuildContext context, int idx) {

    Produto produto = lista.produtos[idx];

    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed("editProduto", arguments: produto.toMap()).then((value) => {
          if(value != null){
            setState(() {
              lista.produtos.insert(idx+1,Produto.fromJson(value));
              lista.produtos.removeAt(idx);
            })
          }
          });

        },
        child: Dismissible(
            key: Key(produto.nome),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                lista.produtos.removeAt(idx);
              });

              // Show a snackbar. This snackbar could also contain "Undo" actions.
              ScaffoldMessenger
                  .of(context)
                  .showSnackBar(SnackBar(content: Text("${produto.nome} Removido")));
            },
            child: Container(
          height: 50.0,
          margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: app.PrimaryColor, width: 1, style: BorderStyle.solid)
          ),
          child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerLeft,
                  child:Text(produto.quantidade,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: app.PrimaryColor,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  child:Text(produto.nome,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: app.PrimaryColor,
                    ),
                  ),
                ),



              ]),

        ))
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
        child: Stack(
          children: [

            Container(
              alignment: Alignment.centerLeft,
              child:  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }),
            ),


            Container(
              alignment: Alignment.center,
              child:  Text(
                "Nova Lista".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center,

              ),
            )

          ],
        )
    ),
        preferredSize: MediaQuery.of(context).size
    );
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (lista.nome == "" && ModalRoute
        .of(context)
        .settings
        .arguments != null) {
      lista = Lista.fromJson(ModalRoute
          .of(context)
          .settings
          .arguments);
      controllerNome.text = lista.nome;
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);

          /// It's important that returned value (boolean) is false,
          /// otherwise, it will pop the navigator stack twice;
          /// since Navigator.pop is already called above ^
          return false;
        },
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
                appBar: topbar(context, drawerKey),
                body: Container(
                  color: Colors.grey,
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [


                      SingleChildScrollView(
                        controller: list,
                        padding: EdgeInsets.only(bottom: 100.0),
                        child: Container(
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 20.0,
                                    right: 20.0,
                                    top: 30.0,
                                    bottom: 10.0),
                                padding: EdgeInsets.only(left: 10.0,
                                    right: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text('Nova lista'.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Aleo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: app.PrimaryColor,
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 20.0,
                                    right: 20.0,
                                    top: 30.0,
                                    bottom: 10.0),
                                padding: EdgeInsets.only(left: 10.0,
                                    right: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text('Mercado'.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Aleo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: app.PrimaryColor,
                                  ),
                                ),
                              ),

                              Container(
                                  margin: EdgeInsets.only(right: 20.0,
                                      left: 20.0,
                                      bottom: 20.0),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))
                                  ),
                                  child: TextField(
                                    controller: controllerNome,
                                    textCapitalization: TextCapitalization
                                        .sentences,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15
                                    ),
                                    onChanged: (item) {
                                      setState(() {});
                                    },
                                  )
                              ),

                              ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: double
                                      .infinity, minHeight: 1.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 0.0),
                                    itemCount: lista.produtos.length,
                                    itemBuilder: (BuildContext context,
                                        int index) => buildRow(context, index),
                                  )),


                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        "addProduto", arguments: lista.toMap() ).then((
                                        value) =>
                                    {
                                      if(value != null){
                                        setState(() {
                                          lista = Lista.fromJson(value);
                                        })
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))
                                    ),
                                    child: Text("+ NOVO PRODUTO",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),),
                                  )
                              ),

                              GestureDetector(
                                  onTap: () async {
                                    if (lista.id != null) {
                                      lista.nome = controllerNome.text;

                                      app.compra.listas.insert(
                                          lista.id + 1, lista);
                                      app.compra.listas.removeAt(lista.id);

                                      app.pref.set(this, "listas",
                                          jsonEncode(app.compra.toMap()));
                                      Navigator.of(context).pop();
                                    } else {
                                      lista.nome = controllerNome.text;
                                      lista.id = app.compra.listas.length;

                                      DateTime data = DateTime.now();
                                      String formattedDate = DateFormat(
                                          'dd/MM/yyyy – HH:mm').format(data);
                                      lista.data = formattedDate;


                                      app.compra.listas.add(lista);

                                      app.pref.set(this, "listas",
                                          jsonEncode(app.compra.toMap()));
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))
                                    ),
                                    child: Text(
                                      "SALVAR", textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ))));

  }}