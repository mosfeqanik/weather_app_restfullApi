import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  Future<String?> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location Permission Denied';
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
        await loadWeather(lat, lon, context);
      } else {
        print("Error: Latitude or longitude is null");
      }
    } else if (status.isDenied) {
      return "User denied location permissions";
    }
  }

  Future<String> _loadWeatherCommon(
      Future<Response> Function() loadFunction) async {
    try {
      final response = await loadFunction();
      if (response.statusCode == 200) {
        _myWeather = MyWeather.fromJson(response.data);
        return "have a good day";
      } else {
        _myWeather = null;
        return "Please check your internet and try again later";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _myWeather = null;
      return "Please check your internet and try again later";
    } finally {
      isLoading = false;
      notifyListeners();
      return "Please check your internet and try again later";
    }
  }

  Future<void> loadWeather(double lat, double lon, BuildContext context) async {
    isLoading = true;
    await _loadWeatherCommon(
        () => WeatherRepository().loadWeather(lat, lon, context));
  }

  Future<void> loadWeatherByCityName(
      String cityName, BuildContext context) async {
    isLoading = true;
    await _loadWeatherCommon(
        () => WeatherRepository().loadWeatherByCityName(cityName, context));
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> checkInternetConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection is available
    }
  }
}
