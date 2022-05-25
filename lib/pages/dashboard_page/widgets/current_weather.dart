import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';

/* **********************************
** Widget: CurrentWeatherContainer **
********************************** */
class CurrentWeatherContainer extends StatefulWidget {
  final WeatherApi weatherApi;

  const CurrentWeatherContainer({
    Key? key,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<CurrentWeatherContainer> createState() => _CurrentWeatherContainerState();
}

class _CurrentWeatherContainerState extends State<CurrentWeatherContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            // Current temperature
            Align(
              alignment: Alignment.centerLeft,
              child: Tooltip(
                message: 'Current temperature',
                child: Text(
                  '${widget.weatherApi.current.temp.toInt()}º',
                  style: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            // Max and Min temperature
            Row(
              children: [
                Tooltip(
                  message: 'Minimum temperature of today',
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.blue[400],
                        semanticLabel: 'Minimum temperature of today',
                      ),
                      Text(
                        '${widget.weatherApi.daily[0].temp.min.toInt()}ºC',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Tooltip(
                    message: 'Maximum temperature of today',
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.red[700],
                          semanticLabel: 'Maximum temperature of today',
                        ),
                        Text(
                          '${widget.weatherApi.daily[0].temp.max.toInt()}ºC',
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
