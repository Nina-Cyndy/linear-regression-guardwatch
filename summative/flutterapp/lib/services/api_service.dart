import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/prediction_request.dart';

class ApiService {
  static const String baseUrl =
      "https://linear-regression-guardwatch-1.onrender.com";

  Future<double> predict(PredictionRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data["prediction"] as num).toDouble();
    }

    throw Exception("Server ${response.statusCode}\n${response.body}");
  }
}
