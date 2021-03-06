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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  WeatherModel._internal();
}
