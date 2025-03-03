// TODO Implement this library.data_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider extends ChangeNotifier {
  String _result = '';

  String get result => _result;

  Future<void> analyzeData(double feature1, double feature2) async {
    const url = 'http://localhost:3000/analyze'; // تأكد من تطابق URL مع خادمك

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'feature1': feature1,
          'feature2': feature2,
        }),
      );

      if (response.statusCode == 200) {
        _result = response.body;
      } else {
        _result = 'Error: ${response.statusCode}';
      }
    } catch (error) {
      _result = 'Error: $error';
    }
    notifyListeners();
  }
}
