import 'dart:convert';
import 'package:flutter/services.dart';

class JsonService {
  static Future<dynamic> loadJson(String fileName) async {
    final String response = await rootBundle.loadString(
      'assets/data/$fileName.json',
    );

    return jsonDecode(response);
  }
}
