
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:listafacil/model/Model.dart';
import 'package:listafacil/util/Activity.dart';


import '../main.dart';

class addProduto extends StatefulWidget {
  @override
  _addProduto createState() => _addProduto();
}
class _addProduto extends ActivityState {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController list;
  bool isVisible = true;
  bool favorite = false;
  bool isLoading = false;
  bool progress = true;
  String filter = "";
  int page = 0;
  int limit = 10;

  Lista lista;

  var controllerNome = TextEditingController();
  var controllerQuantidade = TextEditingController();

  final focusQuantidade = FocusNode();


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
                "Novo Produto".toUpperCase(),
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

    if(ModalRoute.of(context).settings.arguments != null && this.lista == null){
      this.lista = Lista.fromJson(ModalRoute.of(context).settings.arguments);
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
                          child: Text('Novo Produto'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Aleo',
                              fontWeight:FontWeight.bold,
                              fontSize: 18.0,
                              color: app.PrimaryColor,
                            ),
                          ),
                        ),



                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.centerLeft,
                          child: Text('NOME DO PRODUTO'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Aleo',
                              fontWeight:FontWeight.bold,
                              fontSize: 14.0,
                              color: app.PrimaryColor,
                            ),
                          ),
                        ),


                        Container(
                            margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 3, right: 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (v){
                                FocusScope.of(context).requestFocus(focusQuantidade);
                              },
                              controller: controllerNome,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                              onChanged: (item) {
                                setState(() {
                                });
                              },
                            )
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Quantidade'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Aleo',
                              fontWeight:FontWeight.bold,
                              fontSize: 14.0,
                              color: app.PrimaryColor,
                            ),
                          ),
                        ),




                        Container(
                            margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 3, right: 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: TextField(
                              focusNode: focusQuantidade,
                              controller: controllerQuantidade,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                              onChanged: (item) {
                                setState(() {
                                });
                              },
                            )
                        ),

                        GestureDetector(
                            onTap: () async {
                              Produto produto = Produto(lista.produtos.length, controllerQuantidade.text, controllerNome.text, false);

                              lista.produtos.add(produto);

                              controllerNome.text = "";
                              controllerQuantidade.text = "";

                              ScaffoldMessenger
                                  .of(context)
                                  .showSnackBar(SnackBar(content: Text("${produto.nome} Adicionado")));


                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Text("ADICIONAR MAIS", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),),
                            )
                        ),



                        GestureDetector(
                            onTap: () async {
                                  Produto produto = Produto(lista.produtos.length, controllerQuantidade.text, controllerNome.text, false);

                                  lista.produtos.add(produto);


                                  Navigator.of(context).pop(lista.toMap());
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Text("SALVAR", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
        )));
  }
}

