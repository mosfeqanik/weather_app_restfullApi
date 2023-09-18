import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../API/api_constant.dart';

const Duration timeoutDuration = Duration(seconds: 60);

class WeatherRepository {
  //get_weather
  Future<Response> loadWeather(
      double latitude, double longitude, BuildContext context) async {
    String api =
        "${ApiConstant.BASE_URL}?APPID=${ApiConstant.APP_ID}&lat=$latitude&lon=$longitude&units=${ApiConstant.TEMP_UNIT}";
    try {
      Response response = await Dio()
          .get(
            api,
          )
          .timeout(timeoutDuration);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Handle Dio-specific errors
        if (e.error is SocketException) {
          // Handle SocketException
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
                  "Something went wrong. Please check your Internet and try again",
            ),
          );
          print("SocketException: ${e.error}");
          // Display a user-friendly message or retry logic
        }
      } else {
        // Handle other exceptions
        print("Error: $e");
      }
      // Create a RequestOptions object with default values
      RequestOptions requestOptions = RequestOptions();

      // Return a Response object with status code 204 and the RequestOptions object
      return Response(
          data: null, statusCode: 204, requestOptions: requestOptions);
    }
  }

  Future<Response> loadWeatherByCityName(
      String cityName, BuildContext context) async {
    String api =
        "${ApiConstant.BASE_URL}?APPID=${ApiConstant.APP_ID}&q=$cityName&units=${ApiConstant.TEMP_UNIT}";
    try {
      Response response = await Dio()
          .get(
            api,
          )
          .timeout(timeoutDuration);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Handle Dio-specific errors
        if (e.error is SocketException) {
          // Handle SocketException
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
                  "Something went wrong. Please check your credentials and try again",
            ),
          );
          print("SocketException: ${e.error}");
          // Display a user-friendly message or retry logic
        }
      } else {
        // Handle other exceptions
        print("Error: $e");
      }
      // Create a RequestOptions object with default values
      RequestOptions requestOptions = RequestOptions();

      // Return a Response object with status code 204 and the RequestOptions object
      return Response(
          data: null, statusCode: 204, requestOptions: requestOptions);
    }
  }
}
