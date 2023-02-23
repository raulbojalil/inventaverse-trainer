import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;

  static late AppConfig _instance;

  AppConfig({required this.apiUrl});

  static AppConfig getInstance() {
    return _instance;
  }

  static Future<AppConfig> forEnvironment(String? env) async {
    env = env ?? 'dev';

    final contents = env == 'dev'
        ? "{ \"apiUrl\": \"http://localhost:5000\" }"
        : "{ \"apiUrl\": \"\" }";

    final json = jsonDecode(contents);

    _instance = AppConfig(apiUrl: json['apiUrl']);
    return _instance;
  }
}
