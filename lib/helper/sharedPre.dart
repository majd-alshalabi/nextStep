import 'package:shared_preferences/shared_preferences.dart';

class SharedPreHelper {
  static final String _logedInId = 'logedIn';
  static final String _uesrNameId = 'username';
  static final String _emialId = 'email';
  static final String _userKey = 'userKey';

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uesrNameId) ?? 'username';
  }

  static Future<String> getEmailName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emialId) ?? 'majd@gmail.com';
  }

  static Future<void> setUserName(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_uesrNameId, val);
  }

  static Future<void> setEmailName(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_emialId, val);
  }

  static Future<void> setHaveLogedIn(bool z) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_logedInId, z);
  }

  static Future<bool> getHaveLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_logedInId) ?? false;
  }

  static Future<String> getUserKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey) ?? 'jUcB82ITpUyAeGojb3zT';
  }

  static Future<void> setUserKey(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, value);
  }
}
