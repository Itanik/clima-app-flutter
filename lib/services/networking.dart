import 'package:clima/utilities/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherService {
  static const String _apiKey = Keys.openWeatherKey;
  static const String _authority = "api.openweathermap.org";
  static const String _weatherMethod = "/data/2.5/weather";

  static const String _latSuffix = "lat";
  static const String _longSuffix = "lon";
  static const String _apiKeySuffix = "appid";
  static const String _unitsSuffix = "units";

  static const String _units = "metric";

  Future<Map<String, dynamic>> getWeather(
      double latitude, double longitude) async {
    Uri url = Uri.https(_authority, _weatherMethod, {
      _latSuffix: latitude.toString(),
      _longSuffix: longitude.toString(),
      _apiKeySuffix: _apiKey,
      _unitsSuffix: _units,
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var map = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Future.value(map);
    } else {
      return Future.error(response.statusCode);
    }
  }
}
