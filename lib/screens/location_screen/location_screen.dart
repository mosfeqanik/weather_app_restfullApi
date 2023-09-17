import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/weather_provider.dart';
import '../../utilies/constants.dart';
import '../city_screen/city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  @override
  void initState() {
    super.initState();
    WeatherProvider weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      weatherProvider.getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.black26),
      child: Consumer<WeatherProvider>(builder: (_, myProvider, ___) {
        if (myProvider != null) {

          // For example:
          if (myProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Access other properties or methods safely.
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appBarIconWidget(myProvider, context, screenHeight),
                  temperatureWidget(myProvider, screenHeight),
                  messagePart(myProvider, screenHeight),
                  SizedBox(
                    height: 0.1 * screenHeight, // Adjust the height
                  )
                ],
              ),
            );
          }
        } else {
          // Handle the case where weatherProvider is null.
          return const Text('Weather data unavailable');
        }

      }),
    ));
  }

  Widget messagePart(WeatherProvider myProvider, double screenHeight) => Text(
        myProvider.weatherModel
            .getMessage(myProvider.myWeather.main.temp.toInt()),
        textAlign: TextAlign.center,
        style: kMessageTextStyle,
      );

  Widget temperatureWidget(WeatherProvider myProvider, double screenWidth) =>
      Padding(
        padding: EdgeInsets.only(left: 0.05 * screenWidth), // Adjust padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${myProvider.myWeather.main.temp.toInt()} °',
              style: kTempTextStyle,
            ),
            Text(
              myProvider.weatherModel
                  .getWeatherIcon(myProvider.myWeather.weather[0].id),
              style: kConditionTextStyle,
              maxLines: 2,
            ),
          ],
        ),
      );

  Widget appBarIconWidget(WeatherProvider myProvider, BuildContext context,
          double screenHeight) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              myProvider.isLoading = true;
              myProvider.getLocation();
            },
            child: Icon(
              Icons.near_me,
              size: 0.07 * screenHeight, // Adjust the icon size
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                String cityName = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CityScreen();
                  }),
                );
                myProvider.isLoading = true;
                myProvider.loadWeatherByCityName(cityName);
              } catch (error) {
                if (kDebugMode) {
                  print(error);
                }
                // Show a snackbar with the error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('An error occurred: $error'),
                  ),
                );
              }
            },
            child: Icon(
              Icons.location_city,
              size: 0.07 * screenHeight, // Adjust the icon size
              color: Colors.white,
            ),
          ),
        ],
      );
}
