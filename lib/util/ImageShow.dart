// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'Activity.dart';


class ImageShow extends StatefulWidget {

  String url;
  File file;

  ImageShow(this.url, this.file);

  @override
  _ImageShowState createState() => _ImageShowState(this.url, this.file);
}

class _ImageShowState extends ActivityState {

  String url;
  File file;

  _ImageShowState(this.url, this.file);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeBuildContext() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          (this.file == null)?
          PhotoView(
              imageProvider: NetworkImage(url)
          ):
          PhotoView(imageProvider: FileImage(file)),

          Positioned(
            top: 70.0,
            right: 10.0,
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Image.asset(
                    "img/closepopup.png",
                    width: 30.0,
                    height: 30.0,
                    color: Color(0xFFFFFFFF)
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ]
      ),
    );
  }

}