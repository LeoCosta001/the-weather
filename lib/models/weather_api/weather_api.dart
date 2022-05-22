class WeatherApi {
  late final double lat;
  late final double lon;
  late final String timezone;
  late final int timezoneOffset;
  late final WeatherApiCurrent current;
  late final List<WeatherApiHourly> hourly;
  late final List<WeatherApiDaily> daily;

  @override
  // Convert JSON to Object
  WeatherApi.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lon = json['lon'],
        timezone = json['timezone'],
        timezoneOffset = json['timezone_offset'],
        current = WeatherApiCurrent.fromJson(json['current']),
        hourly = List<WeatherApiHourly>.from(json['hourly'].map((value) => WeatherApiHourly.fromJson(value)).toList()),
        daily = List<WeatherApiDaily>.from(json['daily'].map((value) => WeatherApiDaily.fromJson(value)).toList());
}

class WeatherApiCurrent {
  late final int dt;
  late final int sunrise;
  late final int sunset;
  late final double temp;
  late final double feelsLike;
  late final int pressure;
  late final int humidity;
  late final double dewPoint;
  late final double uvi;
  late final int clouds;
  late final int visibility;
  late final double windSpeed;
  late final int windDeg;
  late final List<Weather> weather;

  @override
  // Convert JSON to Object
  WeatherApiCurrent.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] * 1000,
        sunrise = json['sunrise'] * 1000,
        sunset = json['sunset'] * 1000,
        temp = json['temp'],
        feelsLike = json['feels_like'],
        pressure = json['pressure'],
        humidity = json['humidity'],
        dewPoint = json['dew_point'],
        uvi = json['uvi'].toDouble(),
        clouds = json['clouds'],
        visibility = json['visibility'],
        windSpeed = json['wind_speed'],
        windDeg = json['wind_deg'],
        weather = List<Weather>.from(json['weather'].map((value) => Weather.fromJson(value)).toList());
}

class WeatherApiHourly {
  late final int dt;
  late final double temp;
  late final double feelsLike; // field: feels_like
  late final int pressure;
  late final int humidity;
  late final double dewPoint; // field: dew_point
  late final double uvi;
  late final int clouds;
  late final int visibility;
  late final double windSpeed; // field: wind_speed
  late final int windDeg; // field: wind_deg
  late final double windGust; // field: wind_gust
  late final double pop;
  late final List<Weather> weather;

  @override
  // Convert JSON to Object
  WeatherApiHourly.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] * 1000,
        temp = json['temp'].toDouble(),
        feelsLike = json['feels_like'].toDouble(),
        pressure = json['pressure'],
        humidity = json['humidity'],
        dewPoint = json['dew_point'].toDouble(),
        uvi = json['uvi'].toDouble(),
        clouds = json['clouds'],
        visibility = json['visibility'],
        windSpeed = json['wind_speed'].toDouble(),
        windDeg = json['wind_deg'],
        windGust = json['wind_gust'].toDouble(),
        pop = json['pop'].toDouble(),
        weather = List<Weather>.from(json['weather'].map((value) => Weather.fromJson(value)).toList());
}

class WeatherApiDaily {
  late final int dt;
  late final int sunrise;
  late final int sunset;
  late final int moonrise;
  late final int moonset;
  late final double moonPhase;
  late final int pressure;
  late final int humidity;
  late final double dewPoint;
  late final double windSpeed;
  late final int windDeg;
  late final double windGust;
  late final int clouds;
  late final double pop;
  late final double uvi;
  late final Temp temp;
  late final FeelsLike feelsLike;
  late final List<Weather> weather;

  @override
  // Convert JSON to Object
  WeatherApiDaily.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] * 1000,
        sunrise = json['sunrise'] * 1000,
        sunset = json['sunset'] * 1000,
        moonrise = json['moonrise'] * 1000,
        moonset = json['moonset'] * 1000,
        moonPhase = json['moon_phase'].toDouble(),
        pressure = json['pressure'],
        humidity = json['humidity'],
        dewPoint = json['dew_point'].toDouble(),
        windSpeed = json['wind_speed'].toDouble(),
        windDeg = json['wind_deg'],
        windGust = json['wind_gust'].toDouble(),
        clouds = json['clouds'],
        pop = json['pop'].toDouble(),
        uvi = json['uvi'].toDouble(),
        temp = Temp.fromJson(json['temp']),
        feelsLike = FeelsLike.fromJson(json['feels_like']),
        weather = List<Weather>.from(json['weather'].map((value) => Weather.fromJson(value)).toList());
}

class Weather {
  late final int id;
  late final String main;
  late final String description;
  late final String icon;

  @override
  // Convert JSON to Object
  Weather.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        main = json['main'],
        description = json['description'],
        icon = json['icon'];
}

class FeelsLike {
  late final double day;
  late final double night;
  late final double eve;
  late final double morn;

  @override
  // Convert JSON to Object
  FeelsLike.fromJson(Map<String, dynamic> json)
      : day = json['day'].toDouble(),
        night = json['night'].toDouble(),
        eve = json['eve'].toDouble(),
        morn = json['morn'].toDouble();
}

class Temp {
  late final double min;
  late final double day;
  late final double max;
  late final double night;
  late final double eve;
  late final double morn;

  @override
  // Convert JSON to Object
  Temp.fromJson(Map<String, dynamic> json)
      : min = json['min'].toDouble(),
        day = json['day'].toDouble(),
        max = json['max'].toDouble(),
        night = json['night'].toDouble(),
        eve = json['eve'].toDouble(),
        morn = json['morn'].toDouble();
}
