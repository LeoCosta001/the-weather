import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:the_weather/http/weather_api/weather_api_icon.dart';
import 'package:the_weather/http/weather_api/weather_api_utils.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';

/* ********************************
** Widget: DailyWeatherContainer **
******************************** */
class DailyWeatherContainer extends StatefulWidget {
  final WeatherApi weatherApi;

  const DailyWeatherContainer({
    Key? key,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<DailyWeatherContainer> createState() => _DailyWeatherContainerState();
}

class _DailyWeatherContainerState extends State<DailyWeatherContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0, left: 16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Next days',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 145.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.weatherApi.daily.length - 1,
                  itemBuilder: (context, index) {
                    final WeatherApiDaily weatherApiDaily = widget.weatherApi.daily[index + 1];
                    final DayCycle getCycleToHourly = WeatherApiUtils().getDayCycle(
                      weatherApiDaily.dt,
                      weatherApiDaily,
                    );

                    return DailyWeather(
                      isFirstItem: index == 0,
                      date: DateTime.fromMillisecondsSinceEpoch(weatherApiDaily.dt),
                      temp: weatherApiDaily.temp.max,
                      iconName: WeatherApiIcon().getById(
                        weatherApiDaily.weather[0].id,
                        getCycleToHourly == DayCycle.day ? true : false,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ***********************
** Widget: DailyWeather **
*********************** */
class DailyWeather extends StatefulWidget {
  final bool isFirstItem;
  final DateTime date;
  final double temp;
  final String iconName;

  const DailyWeather({
    Key? key,
    this.isFirstItem = true,
    required this.date,
    required this.temp,
    required this.iconName,
  }) : super(key: key);

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 80.0,
        padding: const EdgeInsets.all(8.0),
        margin: EdgeInsets.only(left: widget.isFirstItem ? 0 : 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(DateFormat('d/M').format(widget.date)),
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SvgPicture.asset('assets/images/weathers_icon/${widget.iconName}')),
            ),
            Center(
              child: Text('${widget.temp.toInt()}ºC'),
            ),
          ],
        ),
      ),
    );
  }
}