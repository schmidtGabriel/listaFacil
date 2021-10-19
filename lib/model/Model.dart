
import 'package:listafacil/util/Functions.dart';

class Compra{

  List<Lista> listas = List();

  Compra.isEmpty();

  Compra.fromJson(Map<String, dynamic> json) {

    if (json["listas"] != null) {
      for (int i = 0; i < json["listas"].length; i++) {
        this.listas.add(Lista.fromJson(json["listas"][i]));
      }

      // this.listas.sort((a, b) => StrToDate(a.data).compareTo(StrToDate(b.data)));

    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      "listas": []
    };


    if (this.listas.length > 0) {
      for (int i = 0; i < this.listas.length; i++) {
        (result["listas"] as List).add(this.listas[i].toMap());
      }


    }

    return result;
  }

}

class Lista {
  int id;
  String data = "";
  String nome = "";
  bool finalizada = false;
  String formattedTotal = "";
  int total = 0;
  List<Produto> produtos = List();


  Lista.isEmpty();

  Lista(this.id, this.nome, this.data);

  Lista.fromJson(Map<String, dynamic> json) {
  this.id = json["id"];
  this.nome = json["nome"];
  this.data = json["data"];
  this.formattedTotal = json["formattedTotal"];
  this.total = json["total"];
  this.finalizada = json["finalizada"];

    if (json["produtos"] != null) {
      for (int i = 0; i < json["produtos"].length; i++) {
        this.produtos.add(Produto.fromJson(json["produtos"][i]));

      }
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      "id": this.id,
      "nome": this.nome,
      "data": this.data,
      "formattedTotal": this.formattedTotal,
      "total": this.total,
      "finalizada": this.finalizada,
      "produtos": []
    };


    if (this.produtos.length > 0) {
      for (int i = 0; i < this.produtos.length; i++) {
        (result["produtos"] as List).add(this.produtos[i].toMap());
      }
    }

    return result;
  }

}

class Produto {
  String quantidade = "0";
  String nome = "";
  String formattedPrice = "";
  int price = 0;
  bool comprado = false;
  int id = 0;


  Produto.isEmpty();

  Produto(this.id, this.quantidade, this.nome, this.comprado, this.formattedPrice, this.price);

  Produto.fromJson(Map<String, dynamic> json) {
  this.id = json["id"];
  this.quantidade = json["quantidade"];
  this.price = json["price"];
  this.formattedPrice = json["formattedPrice"];
  this.nome = json["nome"];
  this.comprado = json["comprado"];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      "id": this.id,
      "quantidade": this.quantidade,
      "price": this.price,
      "formattedPrice": this.formattedPrice,
      "nome": this.nome,
      "comprado": this.comprado,
    };

    return result;
  }

}