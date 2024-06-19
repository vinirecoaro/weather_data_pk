library weather_data_pk;

import 'dart:convert';
import 'package:weather_data_pk/model/weathers.dart';
import 'package:http/http.dart' as http;
import 'package:weather_data_pk/util/key.dart';

class WeatherDataService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather?";
  static const String _apiKey = Key.API_KEY;

  static Future<Weathers> getWeather(double lat, double lon) async {
    Uri url = Uri.parse("${baseUrl}lat=$lat&lon=$lon&appid=$_apiKey");
    http.Response res = await http.get(url);
    String resultStr = res.body;
    Map<String, dynamic> result = jsonDecode(resultStr);
    Weathers weather = Weathers.fromJson(result);
    return weather;
  }
}
