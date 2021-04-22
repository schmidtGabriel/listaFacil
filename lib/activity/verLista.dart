
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:listafacil/model/Model.dart';
import 'package:listafacil/util/Activity.dart';
import 'package:listafacil/util/CurrencyInputFormatter.dart';
import 'package:listafacil/util/Functions.dart';
import 'package:listafacil/util/Message.dart';


import '../main.dart';

class verLista extends StatefulWidget {
  @override
  _verLista createState() => _verLista();
}
class _verLista extends ActivityState {

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

  final controllerValor = TextEditingController();

  void showToast() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    //   list.addListener(_scrollListener);
    super.initState();


  }

  @override
  void didChangeBuildContext() {

  }

  Future<bool> openConfirm() async{

    var result = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Container(
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
//BackBUTTON AND TXT
                    Container(
                      child: Row(
                        children: [


                          Expanded(
                            flex: 1,
                            child:Container(
                              child: Text (" Insira o valor da compra:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//valor
                    Container(
                      height: 40.0,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, left: 20.0, right: 20.0),
                      padding: EdgeInsets.only(left:15.0, right:15.0, top:5.0 ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child:TextFormField(
                        controller: controllerValor,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          // Fit the validating format.
                          //fazer o formater para dinheiro
                          CurrencyInputFormatter("pt_Br")
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'R\S 00,00',
                          border: InputBorder.none,
                          hintStyle:  TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "Poppins",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
//BTN FazerOferta
                    GestureDetector(
                      onTap: () {

                        if(controllerValor.text == ""){
                          return Message.fromMsg(this, context, "Você precisa inserir um valor para a oferta.").show(false);
                        }


                        Navigator.of(context).pop(true);


                      },
                      child: Container(
                        height: 50.0,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only( left: 20, right: 20, top: 20.0),
                        // padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(color: Colors.indigo,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Text("CONCLUIR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontStyle: FontStyle.normal
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),);
          },
        );
      },
    );

    if(result == true){
      return result;
    }

  }


  //Listblock
  Widget buildRow(BuildContext context, int idx) {
   Produto produto = lista.produtos[idx];

    return GestureDetector(
      onTap: (){
        setState(() {
          produto.comprado = !produto.comprado;
        });
      },
      child:  Container(
        height: 80.0,
        margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: produto.comprado == true?Colors.green:Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: produto.comprado == true?Colors.white:app.PrimaryColor, width: 1, style: BorderStyle.solid)
        ),
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                flex: 1,
                child:  Container(
                  alignment: Alignment.centerLeft,
                  child:Text(produto.quantidade.toString()+"x",
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: produto.comprado == true?Colors.white:app.PrimaryColor,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child:  Container(
                  alignment: Alignment.centerLeft,
                  child:Text(produto.nome,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: produto.comprado == true?Colors.white:app.PrimaryColor,
                    ),
                  ),
                ),
              ),

            ]),

      ) ,
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
                  Navigator.of(context).pop(lista.toMap());
                }),
          ),


          Container(
            alignment: Alignment.center,
            child:  Text(
              "Ver Lista".toUpperCase(),
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

    if(lista == null){
      lista = Lista.fromJson(ModalRoute.of(context).settings.arguments);
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
                          child: Text('Ver lista',
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

                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: double.infinity, minHeight: 1.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 0.0),
                              itemCount: lista.produtos.length,
                              itemBuilder: (BuildContext context, int index) => buildRow(context, index),
                            )),



                      ],
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: () {

                        // Navigator.of(context).pushNamed("addProduto", arguments: null).then((value) =>{
                        //   if(value != null){
                        //     setState(()  {
                        //       lista.produtos.add(Produto.fromJson(value));
                        //     })
                        //   }
                        // });

                        openConfirm().then((value) => {

                          if(value == true){
                            lista.finalizada = true,
                            lista.formattedTotal = controllerValor.text,
                            lista.total = OnlyNumbers(lista.formattedTotal),

                          Navigator.of(context).pop(lista.toMap()),
                          }
                        });



                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                        child: Text("FINALIZAR COMPRA", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
                      )
                  ),
                )
                ,
              ],
            ),

          ),
        ));
  }
}

