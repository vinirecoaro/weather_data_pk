library weather_data_pk;

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:weather_data_pk/model/weathers.dart';
import 'package:http/http.dart' as http;

class WeatherDataService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather?";
  static String? _apiKey;
  static final Logger logger = Logger();

  static Future<void> initialize() async {
    if (_apiKey == null) {
      await dotenv.load(fileName: ".env");
      _apiKey = dotenv.env['API_KEY'];
    }
    if (_apiKey == null) {
      throw Exception("API_KEY not found in .env file");
    }

    _initializeService(_apiKey!);
  }

  static void _initializeService(String apiKey) {
    logger.i('Service initialized with API key: $_apiKey');
  }

  static Future<Weathers> getWeather(double lat, double lon) async {
    await initialize();
    Uri url = Uri.parse("${baseUrl}lat=$lat&lon=$lon&appid=$_apiKey");
    http.Response res = await http.get(url);
    String resultStr = res.body;
    Map<String, dynamic> result = jsonDecode(resultStr);
    Weathers weather = Weathers.fromJson(result);
    return weather;
  }
}
