import 'dart:async';
import 'dart:io';
import 'package:WeatherApp/utils/storage.dart';
import 'package:http/http.dart' as http;


class AuthRepository{

  final FlutterStorage flutterStorage = FlutterStorage();
  late  String apiKey;
  late String? storedKey;

  Future checkKeyCache()async{
    try{
      storedKey = await flutterStorage.readStorage("apiToken");
      if (storedKey != null && storedKey!.isNotEmpty){
          final CacheStatus = await checkKey(storedKey!);
          return CacheStatus;
      }
      else{
        return false;
      }
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> checkKey(String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse("https://api.weatherapi.com/v1/current.json?q=health&key=$apiKey",),
        headers: {"Accept": "application/json"},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        await flutterStorage.writeStorage("apiToken", apiKey);
        return true;
      } else {
        throw "Invalid API Key. Please enter the correct key.";
      }
    } on SocketException {
      throw "No Internet Connection. Please check your connection.";
    } on TimeoutException {
      throw "Request timed out. Try again.";
    } catch (e) {
      throw "$e";
    }
  }

}





