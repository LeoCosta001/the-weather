import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

enum DayCycle {
  day('day'),
  night('night');

  final String cycle;

  const DayCycle(this.cycle);
}

class WeatherApiUtils {
  // Return 'day' or 'night' cycle
  DayCycle getDayCycle(int dateToCheck, WeatherApiDaily weatherApiDaily) {
    return dateToCheck < weatherApiDaily.sunrise || dateToCheck >= weatherApiDaily.sunset
        ? DayCycle.night
        : DayCycle.day;
  }

  WeatherApiDaily getDayOfCycle(int time, List<WeatherApiDaily> weatherApiDaily) {
    initializeDateFormatting();

    final timeToDate = DateTime.fromMillisecondsSinceEpoch(time);
    final timeDay = DateFormat.d().format(timeToDate);

    for (var currentWeatherApiDaily in weatherApiDaily) {
      final currentWeatherApiDailyDate = DateTime.fromMillisecondsSinceEpoch(currentWeatherApiDaily.dt);
      final dayToCompare = DateFormat.d().format(currentWeatherApiDailyDate);

      if (timeDay == dayToCompare) {
        if (time > currentWeatherApiDaily.sunrise && time < currentWeatherApiDaily.sunset) {
          return currentWeatherApiDaily;
        }
      }
    }

    return weatherApiDaily[0];
  }
}
