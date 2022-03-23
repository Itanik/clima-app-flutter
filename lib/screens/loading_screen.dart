import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    getLocation().then(
        (value) => getWeatherData().then((value) => goToLocationScreen(value)));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  Future getLocation() async {
    await _location.updatePosition();
    print("Latitude: ${_location.latitude}, longitude: ${_location.longitude}");
  }

  Future getWeatherData() async {
    await _location.updatePosition();
    var response =
        await Networking.getWeather(_location.latitude, _location.longitude);
    return response;
  }

  void goToLocationScreen(weatherData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  weatherData: weatherData,
                )));
  }
}
