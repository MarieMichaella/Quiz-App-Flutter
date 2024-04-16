import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizapp/model/user.dart';
import 'dart:convert';

// class SessionManager {
//   static const String _keyUserSession = 'user_session';

//   static Future<void> setUserSession(Map<String, dynamic> userData) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserSession, userData.toString());
//   }

//   static Future<Users?> getUserSession() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userDataString = prefs.getString(_keyUserSession);
//     if (userDataString != null && userDataString.isNotEmpty) {
//       Map<String, dynamic> userData = Map<String, dynamic>.from(json.decode(userDataString));
//       return Users.fromMap(map);
//     }
//     return null;
//   }

//   static Future<void> clearUserSession() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserSession);
//   }
// }
