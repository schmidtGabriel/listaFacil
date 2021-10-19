//SharedPreference
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Activity.dart';

// Alterar no Android
// buildTypes {
//   release {
//     signingConfig signingConfigs.release
//     //Incluir essas duas linhas para resolver os plugins
//     shrinkResources false
//     minifyEnabled false
//   }
// }


init() async {
  // const MethodChannel('plugins.flutter.io/shared_preferences')
  //     .setMockMethodCallHandler((MethodCall methodCall) async {
  //   if (methodCall.method == 'getAll') {
  //     return <String, dynamic>{}; // set initial values here if desired
  //   }
  //   return null;
  // });

  // ignore: invalid_use_of_visible_for_testing_member
  // SharedPreferences.setMockInitialValues({});
}

class SharedPreference {

  int contador = 3;
  SharedPreferences sharedPreference;

  create() async {
    print("LISTA FACIL: " + contador.toString() + "ª tentativa.");
    contador--;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    try {
      sharedPreference = await _prefs;
    } on Exception catch (err) {
      print("LISTA FACIL: " + err.toString());
      if (contador > 0) {
        await create();
      } else {
        SharedPreferences.setMockInitialValues({"status": "online"});
        sharedPreference = await _prefs;
      }
    }
  }

  SharedPreference();

  Future<bool> set(ActivityState context, String key, dynamic value) async {
    String sValue;
    try {
      sValue = value.toString();
    } catch (e) {
      sValue = null;
    }

    if (sValue.isNotEmpty) {
      context.setState(() {
        sharedPreference.setString(key, sValue);
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> remove(ActivityState context, String key) async {
    context.setState(() {
      return sharedPreference.remove(key);
    });
  }

  dynamic get(String key) {
    return sharedPreference.get(key);
  }

  String getString(String key) {
    if (key == null) {
      return null;
    }
    return sharedPreference.getString(key);
  }

  int getInt(String key) {
    return sharedPreference.getInt(key);
  }

  bool getBool(String key) {
    return sharedPreference.getBool(key);
  }

  Map<String, dynamic> getJson(String key) {
    if(sharedPreference == null){
      create();
    }
    String value = sharedPreference.getString(key);
    if (value == null) {
      return null;
    }

    try {
      var parsedJson = jsonDecode(value);
      return parsedJson;
    } catch (e) {
      return null;
    }

  }

}

// // hive
// import 'dart:io';
// import 'package:ideale/util/Activity.dart';
// import 'dart:convert';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// init() async {
// }
//
// class SharedPreference {
//   Box sharedPreference;
//
//   create() async {
//     try {
//       Directory appDocDirectory = await getApplicationDocumentsDirectory();
//       Hive.init(appDocDirectory.path);
//       sharedPreference = await Hive.openBox('sharedPreferences');
//     } on Exception catch (err) {
//       print("IDEALESEMIJOIAS: " + err.toString());
//     }
//   }
//
//   SharedPreference();
//
//   Future<bool> set(ActivityState context, String key, dynamic value) async {
//     String sValue;
//     try {
//       sValue = value.toString();
//     } catch (e) {
//       sValue = null;
//     }
//
//     if (sValue.isNotEmpty) {
//       context.setState(() {
//         sharedPreference.put(key, sValue);
//       });
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<bool> remove(ActivityState context, String key) async {
//     context.setState(() {
//       return sharedPreference.delete(key);
//     });
//   }
//
//   dynamic get(String key) {
//     return sharedPreference.get(key);
//   }
//
//   String getString(String key) {
//     return sharedPreference.get(key).toString();
//   }
//
//   int getInt(String key) {
//     return sharedPreference.get(key) as int;
//   }
//
//   bool getBool(String key) {
//     return sharedPreference.get(key) as bool;
//   }
//
//   Map<String, dynamic> getJson(String key) {
//     String value = sharedPreference.get(key).toString();
//     if (value == null) {
//       return null;
//     }
//
//     try {
//       var parsedJson = jsonDecode(value);
//       return parsedJson;
//     } catch (e) {
//       return null;
//     }
//
//   }
//
// }