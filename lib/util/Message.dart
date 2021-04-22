import 'package:flutter/material.dart';
import '../main.dart';
import 'Activity.dart';
import 'Functions.dart';

class Message {
  ActivityState aContext;
  BuildContext context;
  Map<String, dynamic> result;
  String msg = "";
  String info = "";
  String action = "";

  Message(this.aContext, this.context, this.msg, this.info, this.action);

  Message.fromMsg(this.aContext, this.context, this.msg);

  Message.fromResult(this.aContext, this.context, this.result);

  Message.withInfo(this.aContext, this.context, this.msg, this.info);

  Message.withAction(this.aContext, this.context, this.msg, this.action);

  // ignore: non_constant_identifier_names
  void show(bool ShowInfo){
    if (this.result != null) {
      if (this.result.keys.contains("\$error")) {
        alert(
          this.aContext,
          this.context,
          this.result["\$error"]["msg"],
          (ShowInfo ? "\nDetalhe: " + this.result["\$error"]["info"] : ""),
          this.result["\$error"]["action"]
        );
      } else if (this.result.keys.contains("\$success")) {
        alert(
          this.aContext,
          this.context,
          this.result["\$success"]["msg"],
          (ShowInfo ? "\nDetalhe: " + this.result["\$success"]["info"] : ""),
          this.result["\$success"]["action"]
        );
      }
    } else if (this.msg.isNotEmpty) {
      alert(
          this.aContext,
          this.context,
          this.msg,
          (ShowInfo ? "\nDetalhe: " + this.info : ""),
          this.action
      );
    }
  }

  void alert(ActivityState aContext, BuildContext context, String msg, String info, String action){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(app.title),
          content: new Text(msg + (info.isNotEmpty ? info : "")),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);

                switch (action) {
                  case "#BACK" : {
                    Navigator.of(context).pop();
                    break;
                  }
                }
              },
            ),
            (action == "#LOGOUT") ?
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
            : null,
          ],
        );
      },
    );
  }

}