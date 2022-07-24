import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/shared/utils/hour_normalize.dart';
import 'package:the_weather/shared/utils/uvi_level.dart';

/* ****************************************
** Widget: SelectedDayDetailContainer **
**************************************** */
class SelectedDayDetailContainer extends StatefulWidget {
  final WeatherApi weatherApi;
  final int selectedDay;

  const SelectedDayDetailContainer({
    Key? key,
    required this.weatherApi,
    required this.selectedDay,
  }) : super(key: key);

  @override
  State<SelectedDayDetailContainer> createState() => _SelectedDayDetailContainerState();
}

class _SelectedDayDetailContainerState extends State<SelectedDayDetailContainer> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final WeatherApiDaily selectedDayDetail = widget.weatherApi.daily.where((value) => value.dt == widget.selectedDay).toList()[0];
    final DateTime selectedDay = DateTime.fromMillisecondsSinceEpoch(selectedDayDetail.dt);

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
                'Selected day: ${DateFormat('d/M').format(selectedDay)}',
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
                SelectedDayDetail(
                  icon: Icons.thermostat,
                  title: 'Feels like',
                  info: '${selectedDayDetail.feelsLike.day.toInt()}ºC',
                ),
                SelectedDayDetail(
                  icon: Icons.air,
                  title: 'Wind speed',
                  info: '${selectedDayDetail.windSpeed.toInt()} Km/h',
                ),
                SelectedDayDetail(
                  icon: Icons.cloudy_snowing,
                  title: 'Precipitation',
                  info: '${(selectedDayDetail.pop * 100).toInt()}%',
                ),
                SelectedDayDetail(
                  icon: Icons.light_mode,
                  title: 'UV',
                  info: '${selectedDayDetail.uvi.toInt()} - ${UviLevel().getIndexName(selectedDayDetail.uvi)}',
                ),
                SelectedDayDetail(
                  icon: Icons.water_drop,
                  title: 'Humidity',
                  info: '${selectedDayDetail.humidity}%',
                ),
                SelectedDayDetail(
                  icon: Icons.cloud,
                  title: 'Clouds',
                  info: '${selectedDayDetail.clouds}%',
                ),
                SelectedDayDetail(
                  icon: Icons.wb_twilight_rounded,
                  title: 'Sunrise',
                  info: HourNormalize().hourAndMinutes(selectedDayDetail.sunrise),
                ),
                SelectedDayDetail(
                  icon: Icons.wb_twighlight,
                  title: 'Sunset',
                  info: HourNormalize().hourAndMinutes(selectedDayDetail.sunset),
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
** Widget: SelectedDayDetail **
******************************* */
class SelectedDayDetail extends StatefulWidget {
  final IconData icon;
  final String title;
  final String info;

  const SelectedDayDetail({
    Key? key,
    required this.icon,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  State<SelectedDayDetail> createState() => _SelectedDayDetailState();
}

class _SelectedDayDetailState extends State<SelectedDayDetail> {
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
