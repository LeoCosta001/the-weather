import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_weather/http/weather_api/weather_api_icon.dart';
import 'package:the_weather/http/weather_api/weather_api_utils.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/routes/routes_name.dart';

/* *********************************
** Widget: HourlyWeatherContainer **
********************************* */
class HourlyWeatherContainer extends StatefulWidget {
  final WeatherApi weatherApi;

  const HourlyWeatherContainer({
    Key? key,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<HourlyWeatherContainer> createState() => _HourlyWeatherContainerState();
}

class _HourlyWeatherContainerState extends State<HourlyWeatherContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(right: 16.0, bottom: 16.0, left: 16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Next hours',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.NEXT_HOURS_DETAIL_PAGE);
                        },
                        child: const Text(
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
                    itemCount: widget.weatherApi.hourly.length - 1,
                    itemBuilder: (context, index) {
                      final WeatherApiHourly weatherApiHourly = widget.weatherApi.hourly[index + 1];
                      final DayCycle getCycleToHourly = WeatherApiUtils().getDayCycle(
                        weatherApiHourly.dt,
                        WeatherApiUtils().getDayOfCycle(
                          weatherApiHourly.dt,
                          widget.weatherApi.daily,
                        ),
                      );

                      return HourlyWeather(
                        isFirstItem: index == 0,
                        hour: DateTime.fromMillisecondsSinceEpoch(weatherApiHourly.dt).hour,
                        temp: weatherApiHourly.temp,
                        iconName: WeatherApiIcon().getById(
                          weatherApiHourly.weather[0].id,
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

/* ************************
** Widget: HourlyWeather **
************************ */
class HourlyWeather extends StatefulWidget {
  final bool isFirstItem;
  final int hour;
  final double temp;
  final String iconName;

  const HourlyWeather({
    Key? key,
    this.isFirstItem = true,
    required this.hour,
    required this.temp,
    required this.iconName,
  }) : super(key: key);

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  @override
  Widget build(BuildContext context) {
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
              child: Text('${widget.hour > 9 ? widget.hour : '0${widget.hour}'}:00'),
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
