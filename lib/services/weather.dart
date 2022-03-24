import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  // singleton definition
  static WeatherModel? _instance;
  WeatherModel._();
  static WeatherModel get instance => _instance ?? WeatherModel._();

  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  Future<Map<String, dynamic>> getCityWeather(String city) async {
    return await _weatherService.getWeatherByCity(city);
  }

  Future<Map<String, dynamic>> getWeatherData() async {
    await _locationService.updatePositionData();
    return await _weatherService.getWeather(
        _locationService.latitude, _locationService.longitude);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  WeatherModel._internal();
}
