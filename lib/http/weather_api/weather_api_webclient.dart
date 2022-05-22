import 'dart:convert';

import 'package:http/http.dart';
import 'package:the_weather/auth/secrets.dart';
import 'package:the_weather/http/webclient.dart';
import 'package:the_weather/http/weather_api/weather_api_webclient_enum.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';

const String weatherApiBaseUrl = 'https://api.openweathermap.org/data/2.5';

class WeatherApiWebClientOneCallOption {
  final double latitude;
  final double longitude;
  final WeatherApiOneCallLangEnum lang;
  final WeatherApiOneCallUnitsEnum units;
  List<WeatherApiOneCallExcludeEnum>? exclude;

  WeatherApiWebClientOneCallOption({
    required this.latitude,
    required this.longitude,
    this.lang = WeatherApiOneCallLangEnum.pt_br,
    this.units = WeatherApiOneCallUnitsEnum.metric,
    this.exclude,
  }) {
    exclude = exclude ??
        [
          WeatherApiOneCallExcludeEnum.minutely,
          WeatherApiOneCallExcludeEnum.alerts,
        ];
  }
}

class WeatherApiWebClient {
  Future<WeatherApi> getWeatherApiOneCall(WeatherApiWebClientOneCallOption options) async {
    final Response response = await client.get(
      Uri.parse(weatherApiBaseUrl + '/onecall?appid=$weatherApiKey${_getWeatherApiOneCallQueryString(options)}'),
    );
    final Map<String, dynamic> responseBodyToJson = jsonDecode(response.body);
    return WeatherApi.fromJson(responseBodyToJson);
  }

  String _getWeatherApiOneCallQueryString(WeatherApiWebClientOneCallOption options) {
    final String normalizeLongitude = '&lon=${options.longitude}';
    final String normalizeLatitude = '&lat=${options.latitude}';
    final String normalizeLang = '&lang=${options.lang.value}';
    final String normalizeUnits = '&units=${options.units.value}';
    final String normalizeExcludeItems =
        options.exclude!.isEmpty ? '' : '&exclude=${options.exclude!.map((excludeEnum) => excludeEnum.value).join(',')}';

    return '$normalizeLongitude$normalizeLatitude$normalizeLang$normalizeUnits$normalizeExcludeItems';
  }
}
