import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';

class AppStorage {
  static final AppStorage _appStorage = AppStorage._internal();
  AppStorage._internal() {
    if (_prefs == null) getStorage();
  }
  SharedPreferences? _prefs;
  Map<String, dynamic> _fallbackData = {};

  factory AppStorage() => _appStorage;
  static String? appStorageKey;
  getStorage() async {
    await SharedPreferences.getInstance().then((value) => {_prefs = value});
  }

  getSyncStorage() async {
    _prefs = await SharedPreferences.getInstance();
  }

  putString(String key, String value) async {
    _fallbackData[key] = value;
    return _prefs!.setString(key, value);
  }

  putJSON(String key, dynamic value) {
    _fallbackData[key] = value;
    return putString(key, json.encode(value));
  }

  putInt(String key, int value) {
    _fallbackData[key] = value;
    return _prefs!.setInt(key, value);
  }

  putBool(String key, bool value) {
    _fallbackData[key] = value;
    return _prefs!.setBool(key, value);
  }

  getString(String key, {String? defaultValue}) {
    String value = _fallbackData[key] ?? _prefs!.getString(key) ?? defaultValue;
    return value;
  }

  getJSON(String key, {dynamic defaultValue}) {
    try {
      dynamic data = _fallbackData[key] ?? getString(key);
      return (data != null ? jsonDecode(data) : defaultValue);
    } catch (error) {
      return null;
    }
  }

  getInt(String key, {int? defaultValue}) {
    return _fallbackData[key] ?? _prefs!.getInt(key) ?? defaultValue;
  }

  getBool(String key, {dynamic defaultValue}) {
    return _fallbackData[key] ?? _prefs!.getBool(key) ?? defaultValue;
  }

  dynamic delete(String key) {
    dynamic data = _fallbackData[key];
    _fallbackData.remove(key);
    _prefs!.remove(key);
    return data;
  }

  getUserToken() {
    return getString(USER_TOKEN);
  }
}
