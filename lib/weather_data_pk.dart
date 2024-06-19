library weather_data_pk;

import 'dart:convert';
import 'package:weather_data_pk/model/weathers.dart';
import 'package:http/http.dart' as http;

class WeatherDataService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather?";

  static Future<Weathers> getWeather(
      String apiKey, double lat, double lon) async {
    Uri url = Uri.parse("${baseUrl}lat=$lat&lon=$lon&appid=$apiKey");
    http.Response res = await http.get(url);
    String resultStr = res.body;
    Map<String, dynamic> result = jsonDecode(resultStr);
    Weathers weather = Weathers.fromJson(result);
    return weather;
  }
}
