import 'package:flutter/material.dart';
import 'package:the_weather/models/positionstack_api/positionstack_location_normalize.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/pages/dashboard_page/widgets/current_weather.dart';
import 'package:the_weather/pages/dashboard_page/widgets/daily_weather.dart';
import 'package:the_weather/pages/dashboard_page/widgets/hourly_weather.dart';
import 'package:the_weather/shared/enums/request_state.dart';

/* ***************************
** Widget: DashboardContent **
*************************** */

class DashboardContent extends StatefulWidget {
  final RequestState requestState;
  final bool isPortrait;
  final PositionstackLocationNormalize? selectedLocation;
  final WeatherApi? selectedLocationWeather;

  const DashboardContent({
    Key? key,
    required this.requestState,
    required this.isPortrait,
    this.selectedLocation,
    this.selectedLocationWeather,
  }) : super(key: key);

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  Widget build(BuildContext context) {
    switch (widget.requestState) {
      case RequestState.initial:
      case RequestState.empty:
        return const Center(
          child: Text(
            'No location selected',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        );
      case RequestState.loading:
        return Center(
          child: Column(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      case RequestState.ok:
        if (widget.selectedLocation == null || widget.selectedLocationWeather == null) continue unknownError;

        WeatherApi selectedLocationWeather = widget.selectedLocationWeather as WeatherApi;
        // Responsive padding
        final topContainerPadding = MediaQuery.of(context).size.width / (widget.isPortrait ? 3 : 20);

        return widget.isPortrait
            ? ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: topContainerPadding, right: 8.0, bottom: 8.0, left: 8.0),
                children: [
                  // Current weather
                  CurrentWeatherContainer(weatherApi: selectedLocationWeather),
                  // Hourly weather
                  HourlyWeatherContainer(weatherApi: selectedLocationWeather),
                  // Daily weather
                  DailyWeatherContainer(weatherApi: selectedLocationWeather)
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 0, right: 8.0, bottom: 8.0, left: 8.0),
                child: Row(
                  children: [
                    // Current weather
                    CurrentWeatherContainer(weatherApi: selectedLocationWeather),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          // Hourly weather
                          HourlyWeatherContainer(weatherApi: selectedLocationWeather),
                          // Daily weather
                          DailyWeatherContainer(weatherApi: selectedLocationWeather)
                        ],
                      ),
                    ),
                  ],
                ),
              );
      case RequestState.error:
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Internal error'),
          ),
        );
      unknownError:
      default:
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Unknown error'),
          ),
        );
    }
  }
}
