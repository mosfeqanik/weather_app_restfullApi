import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/mylocation.dart';
import '../models/myweather.dart';
import '../repository/repository.dart';
import '../weather_controller/weather_controller.dart';

class WeatherProvider with ChangeNotifier {
  bool _isLoading = true;
  MyWeather? _myWeather;

  MyWeather get myWeather {
    if (_myWeather != null) {
      return _myWeather!;
    } else {
      return MyWeather();
    }
  }

  set myWeather(MyWeather value) {
    _myWeather = value;
  }

  WeatherModel weatherModel = WeatherModel();

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       print( 'Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var status = await Permission.location.request();
    if (status.isGranted) {
      MyLocation location = MyLocation();
      await location.getLocation();
      double? lat = location.latitude;
      double? lon = location.longitude;
      print("$lat & $lon");
      if (lat != null && lon != null) {
        await loadWeather(lat, lon);
      } else {
        print("Error: Latitude or longitude is null");
      }
    } else if (status.isDenied) {
      print("User denied location permissions");
    }
  }

  Future<void> _loadWeatherCommon(
      Future<Response> Function() loadFunction) async {
    try {
      final response = await loadFunction();
      if (response.statusCode == 200) {
        _myWeather = MyWeather.fromJson(response.data);
      } else {
        _myWeather = null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _myWeather = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWeather(double lat, double lon) async {
    isLoading = true;
    await _loadWeatherCommon(() => WeatherRepository().loadWeather(lat, lon));
  }

  Future<void> loadWeatherByCityName(String cityName) async {
    isLoading = true;
    await _loadWeatherCommon(
            () => WeatherRepository().loadWeatherByCityName(cityName));
  }



  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
