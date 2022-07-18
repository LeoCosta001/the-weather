import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/shared/utils/uvi_level.dart';

/* ****************************************
** Widget: SelectedHourlyDetailContainer **
**************************************** */
class SelectedHourlyDetailContainer extends StatefulWidget {
  final WeatherApi weatherApi;
  final int selectedHour;

  const SelectedHourlyDetailContainer({
    Key? key,
    required this.weatherApi,
    required this.selectedHour,
  }) : super(key: key);

  @override
  State<SelectedHourlyDetailContainer> createState() => _SelectedHourlyDetailContainerState();
}

class _SelectedHourlyDetailContainerState extends State<SelectedHourlyDetailContainer> {
  @override
  Widget build(BuildContext context) {
    final WeatherApiHourly selectedHourly = widget.weatherApi.hourly.where((value) => value.dt == widget.selectedHour).toList()[0];
    final int selectedHour = DateTime.fromMillisecondsSinceEpoch(selectedHourly.dt).hour;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0, left: 16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Selected hour: ${selectedHour > 9 ? selectedHour : '0$selectedHour'}:00',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              runSpacing: 15,
              direction: Axis.horizontal,
              children: [
                SelectedHourlyDetail(
                  icon: Icons.thermostat,
                  title: 'Feels like',
                  info: '${selectedHourly.feelsLike.toInt()}ºC',
                ),
                SelectedHourlyDetail(
                  icon: Icons.air,
                  title: 'Wind speed',
                  info: '${selectedHourly.windSpeed.toInt()} Km/h',
                ),
                SelectedHourlyDetail(
                  icon: Icons.cloudy_snowing,
                  title: 'Precipitation',
                  info: '${(selectedHourly.pop * 100).toInt()}%',
                ),
                SelectedHourlyDetail(
                  icon: Icons.light_mode,
                  title: 'UV',
                  info: '${selectedHourly.uvi.toInt()} - ${UviLevel().getIndexName(selectedHourly.uvi)}',
                ),
                SelectedHourlyDetail(
                  icon: Icons.water_drop,
                  title: 'Humidity',
                  info: '${selectedHourly.humidity}%',
                ),
                SelectedHourlyDetail(
                  icon: Icons.cloud,
                  title: 'Clouds',
                  info: '${selectedHourly.clouds}%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* *******************************
** Widget: SelectedHourlyDetail **
******************************* */
class SelectedHourlyDetail extends StatefulWidget {
  final IconData icon;
  final String title;
  final String info;

  const SelectedHourlyDetail({
    Key? key,
    required this.icon,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  State<SelectedHourlyDetail> createState() => _SelectedHourlyDetailState();
}

class _SelectedHourlyDetailState extends State<SelectedHourlyDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 48.0,
              ),
            ),
          ),
          Center(
            child: Text(
              widget.info,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Center(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
