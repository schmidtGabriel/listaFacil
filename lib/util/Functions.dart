import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../main.dart';
import 'dart:async';
import 'Activity.dart';


//  sendAttachments(ActivityState aContext, BuildContext context, String rota) {
//
//   if (WebF.fileSelected != null) {
//     WebF.fileSelected.then((file) =>
//     {
//       if (app.isWeb) {
//         Api.withoutMessageSuccess(aContext, context, true, rota)
//             .uploadFromBytes(rota, app.fileName, app.fileBytes)
//             .then((value) =>
//         {
//           WebF.fileSelected = null,
//           sendAttachments(aContext, context, rota),
//         })
//       } else {
//         Api.withoutMessageSuccess(aContext, context, true, rota)
//             .uploadFromFile(rota, file)
//             .then((value) =>
//         {
//           WebF.fileSelected = null,
//           sendAttachments(aContext, context, rota),
//
//         })
//       }
//     });
//
//   } else {
//     Message.withAction(aContext, context, "Arquivo enviado com sucesso.", "").show(false);
//   }
//
// }


//
// sendAttachments(ActivityState aContext, BuildContext context, String rota) {
//
//
//   if (WebF.fileSelected != null) {
//     WebF.fileSelected.then((file) =>
//     {
//
//       if (app.isWeb) {
//         // Api.withoutMessageSuccess(context, true, rota)
//         Api.withoutMessageSuccess(aContext, context, true, rota)
//             .uploadFromBytes(rota, app.fileName, app.fileBytes)
//             .then((value) =>
//         {
//           WebF.fileSelected = null,
//           app.measureDefect = BlockMeasureDefects.fromJson(value),
//           Message.withAction(aContext, context, "Arquivo enviado com sucesso.", "").show(false)
//
//
//         })
//       } else
//         {
//           // Api.withoutMessageSuccess(context, true, rota)
//           Api.withoutMessageSuccess(aContext, context, true, rota)
//               .uploadFromFile(rota, file)
//               .then((value) =>
//           {
//             if(value != null){
//               app.measureDefect = BlockMeasureDefects.fromJson(value),
//               app.defectCount.value += 1,
//             },
//             WebF.fileSelected = null,
//             Message.withAction(aContext, context, "Arquivo enviado com sucesso.", "").show(false)
//
//           })
//         }
//     });
//   }
// }
//
//
//
// Future<Map<String, dynamic>> pickFileFromDisk(ActivityState aContext, String type, String orign) async {
//   ImageSource source = ImageSource.camera;
//   if (orign == "camera") {
//     source = ImageSource.camera;
//   } else if (orign == "gallery") {
//     source = ImageSource.gallery;
//   }
//
//   switch (type) {
//     case "image" : {
//       if (app.isWeb) {
//         WebF.getUploadFile(".jpg,.jpeg,.png", (e) {
//           final files = app.uploadInput.files;
//           if (files.length == 1) {
//             aContext.setState(() {
//               WebF.fileSelected = WebF.getFile(files[0]);
//             });
//           } else {
//             aContext.setState(() {
//               WebF.fileSelected = null;
//             });
//           }
//         });
//       } else {
//           WebF.fileSelected = ImagePicker.pickImage(source: source, maxWidth: 1980, maxHeight: 1024);
//           aContext.setState(() {
//             WebF.fileSelected.then((value) => {
//               if (value == null) {
//                 pickFileFromDisk(aContext, null, orign)
//               }
//             });
//           });
//       }
//       break;
//     }
//
//     case "video" : {
//       if (app.isWeb) {
//         WebF.getUploadFile(".mpeg,.mpg,.mp4", (e) {
//           final files = app.uploadInput.files;
//           if (files.length == 1) {
//             aContext.setState(() {
//               WebF.fileSelected = WebF.getFile(files[0]);
//             });
//           } else {
//             aContext.setState(() {
//               WebF.fileSelected = null;
//             });
//           }
//         });
//       } else {
//         WebF.fileSelected = ImagePicker.pickVideo(source: source);
//         aContext.setState(() {
//           WebF.fileSelected.then((value) => {
//             if (value == null) {
//               app.videoCamera = value,
//               pickFileFromDisk(aContext, null, orign)
//             }
//           });
//         });
//       }
//       break;
//     }
//
//     default: {
//       aContext.setState(() {
//         WebF.fileSelected = null;
//       });
//
//       break;
//     }
//
//   }
// }
//
//
// Future<Map<String, dynamic>> pickAnyFileFromDisk(ActivityState aContext, BuildContext context, String type, String orign, String rota) async {
//   ImageSource source = ImageSource.camera;
//   if (orign == "camera") {
//     source = ImageSource.camera;
//   } else if (orign == "gallery") {
//     source = ImageSource.gallery;
//   }
//
//   switch (type) {
//     case "image" : {
//       if (app.isWeb) {
//         WebF.getUploadFile(".jpg,.jpeg,.png", (e) {
//           final files = app.uploadInput.files;
//           if (files.length == 1) {
//             aContext.setState(() {
//               WebF.fileSelected = WebF.getFile(files[0]);
//             });
//           } else {
//             aContext.setState(() {
//               WebF.fileSelected = null;
//             });
//           }
//         });
//       } else {
//
//           WebF.fileSelected = ImagePicker.pickImage(source: source, maxWidth: 1980, maxHeight: 1024);
//
//           aContext.setState(() {
//             WebF.fileSelected.then((value) => {
//               if (value == null) {
//                 pickAnyFileFromDisk(aContext, context, null, orign, rota)
//               }else{
//                 // WebF.ListfileSelected.add(value)
//
//                sendAttachments(aContext, context, rota),
//               }
//             });
//
//
//           });
//       }
//       break;
//     }
//
//
//     case "video" : {
//       if (app.isWeb) {
//         WebF.getUploadFile(".mpeg,.mpg,.mp4", (e) {
//           final files = app.uploadInput.files;
//           if (files.length == 1) {
//             aContext.setState(() {
//               WebF.fileSelected = WebF.getFile(files[0]);
//             });
//           } else {
//             aContext.setState(() {
//               WebF.fileSelected = null;
//             });
//           }
//         });
//       } else {
//         WebF.fileSelected = ImagePicker.pickVideo(source: source);
//         aContext.setState(() {
//           WebF.fileSelected.then((value) => {
//             if (value == null) {
//               app.videoCamera = value,
//             }
//           });
//         });
//       }
//       break;
//     }
//
//     default: {
//       aContext.setState(() {
//         WebF.fileSelected = null;
//       });
//
//       break;
//     }
//
//   }
// }




DateTime StrToDate(dynamic value) {
  if (value == null) {
    return null;
  } else {
    try {
      return DateTime.parse(value);
    } catch (e) {
      switch (value.length) {
        case 16: {
          if ((value[2] == "/") && (value[5] == "/") && (value[10] == " ") && value[13] == ":") { //31/05/2020 11:47
            return DateTime.parse(value.substring(6,10) + "-" + value.substring(3,5) + "-" + value.substring(0,2) + value.substring(10, value.length) + ":00");
          }
          break;
        }
        case 19: {
          if ((value[2] == "/") && (value[5] == "/") && (value[10] == " ") && value[13] == ":") { //31/05/2020 11:47
            return DateTime.parse(value.substring(6,10) + "-" + value.substring(3,5) + "-" + value.substring(0,2) + value.substring(10, value.length));
          }
          break;
        }
        default: {
          return null;
          break;
        }
      }



    }
  }
}

String ValueIsNull(dynamic value){
  if(value == null){
    return "";
  }

  return value.toString();
}

int OnlyNumbers(String value){
  if(value.length > 0){
    var numbers = value.replaceAll(RegExp(r'[^0-9]'), '');

    return int.parse(numbers);
  }else{
    return 0;
  }


}

Future<void> share(String message, String urlSite) async {
  await FlutterShare.share(
      title: 'Blocos Brasil',
      text: message,
      linkUrl: urlSite,
      chooserTitle: 'Como deseja compartilhar?'
  );
}

int DateTimeDiff(DateTime a, b) {
  if (a == null) {
    return -1;
  } else if (b == null) {
    return 1;
  } else {
    Duration duration = a.difference(b);
    return duration.inMilliseconds;
  }
}

String DateToNotify(DateTime date) {
  timeago.LookupMessages br = brLookupMessages();
  timeago.setLocaleMessages("br", br);
  return timeago.format(date, locale: 'br');
}

class brLookupMessages extends timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'atrás';
  @override
  String suffixFromNow() => 'a partir de agora';
  @override
  String lessThanOneMinute(int seconds) => 'um momento';
  @override
  String aboutAMinute(int minutes) => 'um minuto';
  @override
  String minutes(int minutes) => '$minutes minutos';
  @override
  String aboutAnHour(int minutes) => 'cerca de uma hora';
  @override
  String hours(int hours) => '$hours horas';
  @override
  String aDay(int hours) => 'um dia';
  @override
  String days(int days) => '$days dias';
  @override
  String aboutAMonth(int days) => 'cerca de um mês';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => 'cerca de um ano';
  @override
  String years(int years) => '$years anos';
  @override
  String wordSeparator() => ' ';
}