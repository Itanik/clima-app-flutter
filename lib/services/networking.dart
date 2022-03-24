import 'package:clima/utilities/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherService {
  static const String _apiKey = Keys.openWeatherKey;
  static const String _authority = "api.openweathermap.org";
  static const String _weatherMethod = "/data/2.5/weather";

  static const String _latPrefix = "lat";
  static const String _longPrefix = "lon";
  static const String _apiKeyPrefix = "appid";
  static const String _unitsPrefix = "units";
  static const String _queuePrefix = "q";

  static const String _units = "metric";

  Future<Map<String, dynamic>> getWeather(
      double latitude, double longitude) async {
    Uri url = Uri.https(_authority, _weatherMethod, {
      _latPrefix: latitude.toString(),
      _longPrefix: longitude.toString(),
      _apiKeyPrefix: _apiKey,
      _unitsPrefix: _units,
    });

    return await _simpleGetRequest(url);
  }

  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    Uri url = Uri.https(_authority, _weatherMethod, {
      _queuePrefix: city,
      _apiKeyPrefix: _apiKey,
      _unitsPrefix: _units,
    });

    return await _simpleGetRequest(url);
  }

  Future<Map<String, dynamic>> _simpleGetRequest(Uri url) async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var map = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Future.value(map);
    } else {
      return Future.error('Status code: ${response.statusCode}');
    }
  }
}
