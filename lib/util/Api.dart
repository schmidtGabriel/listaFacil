// import 'package:dio/dio.dart';
// import 'Activity.dart';
// import 'dart:io';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
// import '../activity/fail.dart';
// import 'Message.dart';
// import 'fcm.dart';
//
// class Api{
//
//   Dio dio;
//   ProgressDialog progressDialog;
//
//   ActivityState aContext;
//   BuildContext context;
//   bool progress;
//   String title;
//   bool messageSuccess;
//   VoidCallback callBack;
//
//   Api(ActivityState aContext, BuildContext context, bool progress, String title) {
//     this.aContext = aContext;
//     this.context = context;
//     this.progress = progress;
//     this.title = title;
//     this.messageSuccess = true;
//     this.callBack = null;
//
//     create();
//   }
//
//   Api.withoutMessageSuccess(ActivityState aContext, BuildContext context, bool progress, String title) {
//     this.aContext = aContext;
//     this.context = context;
//     this.progress = progress;
//     this.title = title;
//     this.callBack = null;
//     this.messageSuccess = false;
//     create();
//   }
//
//   Api.fromCallBack(ActivityState aContext, BuildContext context, bool progress, String title, VoidCallback callBack){
//     this.aContext = aContext;
//     this.context = context;
//     this.progress = progress;
//     this.title = title;
//     this.messageSuccess = false;
//     this.callBack = callBack;
//
//     create();
//   }
//
//   create() {
//     getToken();
//     if (progress) {
//
//       if (title.isEmpty) {
//
//         progressDialog = ProgressDialog(
//             this.context,
//             type: ProgressDialogType.Normal,
//             isDismissible: false,
//             showLogs: false,
//             customBody: Center(
//                 child: Container(
//                     width: 54,
//                     height: 54,
//                     child: CircularProgressIndicator(
//                         strokeWidth: 4,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                         backgroundColor: Colors.grey
//                     )
//                 )
//             )
//         );
//
//         progressDialog.style(
//           backgroundColor: Colors.transparent,
//         );
//       } else {
//         progressDialog = ProgressDialog(
//             this.context,
//             type: ProgressDialogType.Normal,
//             isDismissible: true,
//             showLogs: false
//         );
//
//         progressDialog.style(
//             message: title,
//             borderRadius: 10.0,
//             backgroundColor: Colors.white,
//             progressWidget: Center(
//                 child: Container(
//                     width: 44,
//                     height: 44,
//                     child: CircularProgressIndicator(
//                         strokeWidth: 4,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                         backgroundColor: Colors.grey
//                     )
//                 )
//             ), //CircularProgressIndicator(),
//             elevation: 10.0,
//             insetAnimCurve: Curves.easeInOut,
//             progress: 0.0,
//             maxProgress: 100.0,
//             progressTextStyle: TextStyle(
//                 color: Colors.black,
//                 fontSize: 13.0,
//                 fontWeight: FontWeight.w400),
//             messageTextStyle: TextStyle(
//                 color: Colors.black,
//                 fontSize: 19.0,
//                 fontWeight: FontWeight.w600),
//             progressWidgetAlignment: Alignment.center
//         );
//       }
//     }
//
//     BaseOptions options = new BaseOptions(
//       baseUrl: app.host + "/",
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//       sendTimeout: 5000,
//     );
//
//     dio = Dio(options);
//
// //    this.setInterceptos(
// //        InterceptorsWrapper(
// //            onRequest:(RequestOptions options) async {
// //              initProgress();
// //              return options;
// //            },
// //            onResponse:(Response response) async {
// //              destroyProgress();
// //              return response;
// //            },
// //            onError: (DioError e) async {
// //              noInternet();
// //              return e;
// //            }
// //        )
// //    );
//   }
//
//   setInterceptos(InterceptorsWrapper interceptors){
//     dio.interceptors.add(interceptors);
//   }
//
//   initProgress() async {
//     if (progressDialog != null) {
//       if (!progressDialog.isShowing()) await progressDialog.show();
//     }
//   }
//
//   destroyProgress() {
//     if (progressDialog != null) {
//       if (progressDialog.isShowing()) progressDialog.hide();
//     }
//   }
//
//   noInternet() {
//     showDialog(context: context, builder: (context) => fail(callBack));
//   }
//
//   getHeader() {
//     return {
//       "Content-type" :"application/json",
//       "Security-token" : app.token,
//       "fcm-token": app.fcm,
// //      "imei": "naotemainda",
//       "system": app.system
//     };
//   }
//
//   getResult(Map<String, dynamic> value) {
//
//     if (value == null) {
//       noInternet();
//       throw Exception();
//     } else if (value.keys.contains("\$error")) {
//       Message.fromResult(aContext, context, value).show(true);
//         throw Exception();
//     } else if (value.keys.contains("\$success")) {
//       if (messageSuccess) {
//         Message message = Message.fromResult(aContext, context, value);
//         message.show(false);
//       }
//       if ((value["\$success"]["info"] != null) && (value["\$success"]["info"] != "")) {
//         try {
//           value = value["\$success"]["info"];
//         } catch (e) {
//           value = null;
//         }
//       } else {
//         value = null;
//       }
//       return value;
//     } else {
//       return value;
//     }
//   }
//
//   Map<String, dynamic> getError(dynamic onError) {
//     Map<String, dynamic> result;
//
//     if (onError.response != null) {
//       try {
//         result = onError.response.data;
//       } catch (e) {
//         result = null;
//       }
//     } else {
//       result = null;
//     }
//
//     return result;
//   }
//
//   Future<Map<String, dynamic>> get(String route, Map<String, dynamic> query) async {
//
//     await initProgress();
//
//     Map<String, dynamic> result;
//
//     await dio.get(
//         route,
//         queryParameters: query,
//         options: Options(
//             headers: getHeader()
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//      destroyProgress();
//
//     return getResult(result);
//
//   }
//
//   Future<Map<String, dynamic>> post(String route, Map<String, dynamic> body) async {
//
//     await initProgress();
//
//     Map<String, dynamic> result;
//
//     await dio.post(
//         route,
//         data: body,
//         options: Options(
//             headers: getHeader()
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//     destroyProgress();
//
//     return getResult(result);
//
//   }
//
//   Future<Map<String, dynamic>> put(String route, Map<String, dynamic> body) async {
//
//     await initProgress();
//
//     Map<String, dynamic> result;
//
//     await dio.put(
//         route,
//         data: body,
//         options: Options(
//             headers: getHeader()
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//     destroyProgress();
//
//     return getResult(result);
//
//   }
//
//   Future<Map<String, dynamic>> delete(String route, Map<String, dynamic> body) async {
//
//     await initProgress();
//
//     Map<String, dynamic> result;
//
//     await dio.delete(
//         route,
//         data: body,
//         options: Options(
//             headers: getHeader()
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//     destroyProgress();
//
//     return getResult(result);
//
//   }
//
//   Future<Map<String, dynamic>> uploadFromBytes(String route, String fileName, List<int> fileBytes) async {
//     await initProgress();
//
//     FormData formData = FormData.fromMap({
//       "file":
//       await MultipartFile.fromBytes(app.fileBytes, filename: fileName),
//     });
//
//     Map<String, dynamic> result;
//
//     await dio.post(
//         route,
//         data: formData,
//         options: Options(
//             headers: getHeader()
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//     destroyProgress();
//
//     return getResult(result);
//   }
//
//   Future<Map<String, dynamic>> uploadFromFile(String route, File file) async {
//     await initProgress();
//
//     String fileName = file.path
//         .split('/')
//         .last;
//     FormData formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(file.path, filename: fileName),
//     });
//
//     Map<String, dynamic> result;
//
//     Map<String, dynamic> header = getHeader();
//     header.remove("Content-type");
//     // header["Content-type"] = "multipart/form-data";
//
//     await dio.post(
//         route,
//         data: formData,
//         options: Options(
//             headers: header
//         )
//     ).then((value) => {
//       dio.resolve(value),
//       result = value.data
//     }).catchError((onError) => {
//       dio.reject(onError),
//       result = getError(onError)
//     });
//
//     destroyProgress();
//
//     return getResult(result);
//   }
//
// }