import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Location _location = Location();
  @override
  void initState() {
    super.initState();
    _printPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _printPosition();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }

  _printPosition() async {
    await _location.updatePosition();
    print("Latitude: ${_location.latitude}, longitude: ${_location.longitude}");
  }
}
