import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getWeatehr({required String cityNamy}) async {
    WeatherModel? weather;
    try {
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = '3fb89b23cd1c47cfac392635230309';
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityNamy&days=5#');
      http.Response response = await http.get(url);
      // baseUrl/forecast.json?key=apiKey&q=cityNamye&days=5#
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = WeatherModel.fromJson(data);
    } catch (e) {
      print('You Entered A Wrong Name');
    }
    return weather;
  }
}
