class WeatherModel {
  String getWeatherIcon(int condition) {
    print(condition);
    if (condition < 300) {
      return '🌩 Thunderstorm';
    } else if (condition < 400) {
      return '🌧 Drizzle';
    } else if (condition < 600) {
      return '☔️ Rain';
    } else if (condition < 700) {
      return '☃️ Snow';
    } else if (condition < 800) {
      return '🌫 Mist';
    } else if (condition == 800) {
      return '☀️ Clear Sky';
    } else if (condition <= 804) {
      return '☁️ Cloudy';
    } else {
      return '🤷‍ Unknown';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s a great day for ice cream! 🍦';
    } else if (temp > 20) {
      return 'Perfect weather for shorts and a t-shirt! 👕';
    } else if (temp < 10) {
      return 'Bundle up with a scarf 🧣 and gloves🧤!';
    } else {
      return 'Bring a jacket 🧥, just in case! ';
    }
  }
}
