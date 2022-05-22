class WeatherApiIcon {
  String getById(int iconId, bool isDay) {
    final defaultIcon = isDay == true ? 'Party Cloudy.svg' : 'Mostly Cloudy Night.svg';

    if (isDay && _getDayIconByIdMap.containsKey(iconId) ||
        !isDay && _getNightIconByIdMap.containsKey(iconId)) {
      final iconName = isDay == true ? _getDayIconByIdMap[iconId] : _getNightIconByIdMap[iconId];
      return iconName ?? defaultIcon;
    }

    return defaultIcon;
  }

  static final Map<int, String?> _getDayIconByIdMap = {
    // Thunderstorm group
    200: 'Mix Rainfall.svg', // Thunderstorm with light rain
    201: 'Mix Rainfall.svg', // Thunderstorm with rain
    202: 'Mix Rainfall.svg', // Thunderstorm with heavy rain
    210: 'Scattered Thunderstorm.svg', // Light thunderstorm
    211: 'Severe Thunderstorm.svg', // Thunderstorm
    212: 'Mix Rainfall.svg', // Heavy thunderstorm
    221: 'Mix Rainfall.svg', // Ragged thunderstorm
    230: 'Mix Rainfall.svg', // Thunderstorm with light drizzle
    231: 'Mix Rainfall.svg', // Thunderstorm with drizzle
    232: 'Mix Rainfall.svg', // Thunderstorm with heavy drizzle

    // Drizzle group
    300: 'Drizzle.svg', // Light intensity drizzle
    301: 'Drizzle.svg', // Drizzle
    302: 'Drizzle.svg', // Heavy intensity drizzle
    310: 'Drizzle.svg', // Light intensity drizzle rain
    311: 'Drizzle.svg', // Drizzle rain
    312: 'Heavy Rain.svg', // Heavy intensity drizzle rain
    313: 'Heavy Rain.svg', // Shower rain and drizzle
    314: 'Heavy Rain.svg', // Heavy shower rain and drizzle
    321: 'Drizzle.svg', // Shower drizzle

    // Rain
    500: 'Scattered Showers.svg', // Light rain
    501: 'Rain.svg', // Moderate rain
    502: 'Heavy Rain.svg', // Heavy intensity rain
    503: 'Heavy Rain.svg', // Very heavy rain
    504: 'Heavy Rain.svg', // Extreme rain
    511: 'Scattered Showers.svg', // Freezing rain
    520: 'Scattered Showers.svg', // Light intensity shower rain
    521: 'Heavy Rain.svg', // Shower rain
    522: 'Heavy Rain.svg', // Heavy intensity shower rain
    531: 'Rain.svg', // Ragged shower rain

    // Snow Group
    600: 'Snow.svg', // Light snow
    601: 'Snow.svg', // Snow
    602: 'Snow.svg', // Heavy snow
    611: 'Hail.svg', // Sleet
    612: 'Blizzard.svg', // Light shower sleet
    613: 'Hail.svg', // Shower sleet
    615: 'Sleet.svg', // Light rain and snow
    616: 'Sleet.svg', // Rain and snow
    620: 'Sleet.svg', // Light shower snow
    621: 'Sleet.svg', // Shower snow
    622: 'Sleet.svg', // Heavy shower snow

    // Atmosphere group
    701: 'Mostly Cloudy.svg', // Mist
    711: 'Smoke.svg', // Smoke
    721: 'Fog.svg', // Haze
    731: 'Breezy Snow 1.svg', // Sand/ dust whirls
    741: 'Smoke.svg', // Fog
    751: 'Dust.svg', // Sand
    761: 'Dust.svg', // Dust
    762: 'Haze.svg', // Volcanic ash
    771: 'Breezy.svg', // Squalls
    781: 'Breezy Snow 1.svg', // Tornado

    // Clear group
    800: 'Mostly Sunny.svg', // Clear sky

    // Clouds group
    801: 'Party Cloudy.svg', // Few clouds: 11-25%
    802: 'Party Cloudy.svg', // Scattered clouds: 25-50%
    803: 'Mostly Cloudy.svg', // Broken clouds: 51-84%
    804: 'Mostly Cloudy.svg', // Overcast clouds: 85-100
  };

  static final Map<int, String?> _getNightIconByIdMap = {
    // Thunderstorm group
    200: 'Mix Rainfall Night.svg', // Thunderstorm with light rain
    201: 'Mix Rainfall Night.svg', // Thunderstorm with rain
    202: 'Mix Rainfall Night.svg', // Thunderstorm with heavy rain
    210: 'Scattered Thunderstorm Night.svg', // Light thunderstorm
    211: 'Severe Thunderstorm Night.svg', // Thunderstorm
    212: 'Mix Rainfall Night.svg', // Heavy thunderstorm
    221: 'Mix Rainfall Night.svg', // Ragged thunderstorm
    230: 'Mix Rainfall Night.svg', // Thunderstorm with light drizzle
    231: 'Mix Rainfall Night.svg', // Thunderstorm with drizzle
    232: 'Mix Rainfall Night.svg', // Thunderstorm with heavy drizzle

    // Drizzle group
    300: 'Drizzle Night.svg', // Light intensity drizzle
    301: 'Drizzle Night.svg', // Drizzle
    302: 'Drizzle Night.svg', // Heavy intensity drizzle
    310: 'Drizzle Night.svg', // Light intensity drizzle rain
    311: 'Drizzle Night.svg', // Drizzle rain
    312: 'Heavy Rain Night.svg', // Heavy intensity drizzle rain
    313: 'Heavy Rain Night.svg', // Shower rain and drizzle
    314: 'Heavy Rain Night.svg', // Heavy shower rain and drizzle
    321: 'Drizzle Night.svg', // Shower drizzle

    // Rain
    500: 'Scattered Showers Night.svg', // Light rain
    501: 'Rain Night.svg', // Moderate rain
    502: 'Heavy Rain Night.svg', // Heavy intensity rain
    503: 'Heavy Rain Night.svg', // Very heavy rain
    504: 'Heavy Rain Night.svg', // Extreme rain
    511: 'Scattered Showers Night.svg', // Freezing rain
    520: 'Scattered Showers Night.svg', // Light intensity shower rain
    521: 'Heavy Rain Night.svg', // Shower rain
    522: 'Heavy Rain Night.svg', // Heavy intensity shower rain
    531: 'Rain Night.svg', // Ragged shower rain

    // Snow Group
    600: 'Snow Night.svg', // Light snow
    601: 'Snow Night.svg', // Snow
    602: 'Snow Night.svg', // Heavy snow
    611: 'Hail Night.svg', // Sleet
    612: 'Blizzard Night.svg', // Light shower sleet
    613: 'Hail Night.svg', // Shower sleet
    615: 'Sleet Night.svg', // Light rain and snow
    616: 'Sleet Night.svg', // Rain and snow
    620: 'Sleet Night.svg', // Light shower snow
    621: 'Sleet Night.svg', // Shower snow
    622: 'Sleet Night.svg', // Heavy shower snow

    // Atmosphere group
    701: 'Mostly Cloudy Night.svg', // Mist
    711: 'Smoke.svg', // Smoke
    721: 'Fog Night.svg', // Haze
    731: 'Breezy Snow 1.svg', // Sand/ dust whirls
    741: 'Smoke.svg', // Fog
    751: 'Dust.svg', // Sand
    761: 'Dust.svg', // Dust
    762: 'Haze.svg', // Volcanic ash
    771: 'Breezy.svg', // Squalls
    781: 'Breezy Snow 1.svg', // Tornado

    // Clear group
    800: 'Clear Night.svg', // Clear sky

    // Clouds group
    801: 'Party Cloudy Night.svg', // Few clouds: 11-25%
    802: 'Mostly Cloudy Night.svg', // Scattered clouds: 25-50%
    803: 'Mostly Cloudy.svg', // Broken clouds: 51-84%
    804: 'Mostly Cloudy.svg', // Overcast clouds: 85-100
  };
}
