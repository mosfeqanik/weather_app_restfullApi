class MyWeather {
  Coord? _coord;
  List<Weather>? _weather;
  String? _base;
  Main? _main;
  int? _visibility;
  Wind? _wind;
  Clouds? _clouds;
  int? _dt;
  int? _timezone;
  int? _id;
  String? _name;
  int? _cod;

  MyWeather(
      {Coord? coord,
        List<Weather>? weather,
        String? base,
        Main? main,
        int? visibility,
        Wind? wind,
        Clouds? clouds,
        int? dt,
        int? timezone,
        int? id,
        String? name,
        int? cod}) {
    this._coord = coord;
    this._weather = weather;
    this._base = base;
    this._main = main;
    this._visibility = visibility;
    this._wind = wind;
    this._clouds = clouds;
    this._dt = dt;
    this._timezone = timezone;
    this._id = id;
    this._name = name;
    this._cod = cod;
  }

  Coord get coord => _coord!;

  set coord(Coord coord) => _coord = coord;

  List<Weather> get weather => _weather!;

  set weather(List<Weather> weather) => _weather = weather;

  String get base => _base!;

  set base(String base) => _base = base;

  Main get main => _main!;

  set main(Main main) => _main = main;

  int get visibility => _visibility!;

  set visibility(int visibility) => _visibility = visibility;

  Wind get wind => _wind!;

  set wind(Wind wind) => _wind = wind;

  Clouds get clouds => _clouds!;

  set clouds(Clouds clouds) => _clouds = clouds;

  int get dt => _dt!;

  set dt(int dt) => _dt = dt;


  int get timezone => _timezone!;

  set timezone(int timezone) => _timezone = timezone;

  int get id => _id!;

  set id(int id) => _id = id;

  String get name => _name!;

  set name(String name) => _name = name;

  int get cod => _cod!;

  set cod(int cod) => _cod = cod;

  MyWeather.fromJson(Map<String, dynamic> json) {
    _coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather!.add(new Weather.fromJson(v));
      });
    }
    _base = json['base'];
    _main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    _visibility = json['visibility'];
    _wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    _clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    _dt = json['dt'];
    _timezone = json['timezone'];
    _id = json['id'];
    _name = json['name'];
    _cod = json['cod'];
  }


}

class Coord {
  double? _lon;
  double? _lat;

  Coord({double? lon, double? lat}) {
    this._lon = lon;
    this._lat = lat;
  }

  double get lon => _lon!;

  set lon(double lon) => _lon = lon;

  double get lat => _lat!;

  set lat(double lat) => _lat = lat;

  Coord.fromJson(Map<String, dynamic> json) {
    _lon = json['lon'];
    _lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this._lon;
    data['lat'] = this._lat;
    return data;
  }
}

class Weather {
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  Weather({int? id, String? main, String? description, String? icon}) {
    this._id = id;
    this._main = main;
    this._description = description;
    this._icon = icon;
  }

  int get id => _id!;

  set id(int id) => _id = id;

  String get main => _main!;

  set main(String main) => _main = main;

  String get description => _description!;

  set description(String description) => _description = description;

  String get icon => _icon!;

  set icon(String icon) => _icon = icon;

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

}

class Main {
  double? _temp;
  double? _feelsLike;
  double? _tempMin;
  double? _tempMax;
  int? _pressure;
  int? _humidity;

  Main(
      {double? temp,
        double? feelsLike,
        double? tempMin,
        double? tempMax,
        int? pressure,
        int? humidity}) {
    this._temp = temp;
    this._feelsLike = feelsLike;
    this._tempMin = tempMin;
    this._tempMax = tempMax;
    this._pressure = pressure;
    this._humidity = humidity;
  }

  double get temp => _temp!;

  set temp(double temp) => _temp = temp;

  double get feelsLike => _feelsLike!;

  set feelsLike(double feelsLike) => _feelsLike = feelsLike;

  double get tempMin => _tempMin!;

  set tempMin(double tempMin) => _tempMin = tempMin;

  double get tempMax => _tempMax!;

  set tempMax(double tempMax) => _tempMax = tempMax;

  int get pressure => _pressure!;

  set pressure(int pressure) => _pressure = pressure;

  int get humidity => _humidity!;

  set humidity(int humidity) => _humidity = humidity;

  Main.fromJson(Map<String, dynamic> json) {
    _temp = json['temp'];
    _feelsLike = json['feels_like'];
    _tempMin = json['temp_min'];
    _tempMax = json['temp_max'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
  }

}

class Wind {
  dynamic? _speed;
  dynamic? _deg;

  Wind({dynamic? speed, dynamic? deg}) {
    this._speed = speed;
    this._deg = deg;
  }

  dynamic get speed => _speed!;

  set speed(dynamic speed) => _speed = speed;

  dynamic get deg => _deg!;

  set deg(dynamic deg) => _deg = deg;

  Wind.fromJson(Map<String, dynamic> json) {
    _speed = json['speed'];
    _deg = json['deg'];
  }

}

class Clouds {
  int? _all;

  Clouds({int? all}) {
    this._all = all;
  }

  int get all => _all!;

  set all(int all) => _all = all;

  Clouds.fromJson(Map<String, dynamic> json) {
    _all = json['all'];
  }


}
