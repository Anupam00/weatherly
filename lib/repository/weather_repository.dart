import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:WeatherApp/utils/storage.dart';
import 'package:http/http.dart' as http;

import '../bloc/model/weather_forcast_model.dart';

class WeatherRepository {
  Future<ForcastModel> fetchForcast(String name) async {
    final FlutterStorage flutterStorage = FlutterStorage();
    try {
      final storedKey = await flutterStorage.readStorage("apiToken");
      final response = await http.get(
        Uri.parse("https://api.weatherapi.com/v1/forecast.json?q=$name&days=7&key=${storedKey}"),
        headers: {
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final fetchedData = jsonDecode(response.body);
        return ForcastModel.fromJson(fetchedData);
      } else {
        throw Exception("Error Retrieving Data: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No Internet Connection. Check your Internet Connection");
    } on TimeoutException {
      throw Exception("Taking too long... Please try again");
    }
  }
}




