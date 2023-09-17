import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/mylocation.dart';
import '../models/myweather.dart';
import '../repository/repository.dart';
import '../weather_controller/weather_controller.dart';

class WeatherProvider with ChangeNotifier {
  bool _isLoading = true;
  MyWeather? _myWeather;
  WeatherModel _weatherModel = WeatherModel();

  void getLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      MyLocation location = MyLocation();
      await location.getLocation();
      double? lat = location.latitude;
      double? lon = location.longitude;
      if (lat != null && lon != null) {
        await loadWeather(lat, lon);
      } else {
        // Handle the case where latitude or longitude is null
        print("Error: Latitude or longitude is null");
      }
    } else if (status.isDenied) {
      // Handle the case where the user denied location permissions
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
        // Handle error or set _myWeather to null in case of an error
      }
    } catch (e) {
      // Handle the exception or set _myWeather to null in case of an error
      if (kDebugMode) {
        print(e);
      }
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

  MyWeather get myWeather => _myWeather!;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  WeatherModel get weatherModel => _weatherModel;
  set weatherModel(WeatherModel value) {
    _weatherModel = value;
    notifyListeners();
  }
}
