import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:the_weather/http/weather_api/weather_api_icon.dart';
import 'package:the_weather/http/weather_api/weather_api_utils.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';

/* ***********************
** Widget: SelectDay **
*********************** */
class SelectDayContainer extends StatefulWidget {
  final WeatherApi weatherApi;
  final int selectedDay;
  final Function(int selectedDay) updateSelectedDay;

  const SelectDayContainer({
    Key? key,
    required this.weatherApi,
    required this.selectedDay,
    required this.updateSelectedDay,
  }) : super(key: key);

  @override
  State<SelectDayContainer> createState() => _SelectDayContainerState();
}

class _SelectDayContainerState extends State<SelectDayContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8.0),
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
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Select to show details',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 145.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.weatherApi.daily.length - 1,
                  itemBuilder: (context, index) {
                    final WeatherApiDaily weatherApiDaily = widget.weatherApi.daily[index];
                    final DayCycle getCycleToHourly = WeatherApiUtils().getDayCycle(
                      weatherApiDaily.dt,
                      WeatherApiUtils().getDayOfCycle(
                        weatherApiDaily.dt,
                        widget.weatherApi.daily,
                      ),
                    );

                    return SelectDayButton(
                      isFirstItem: index == 0,
                      isSelected: widget.selectedDay == weatherApiDaily.dt,
                      date: DateTime.fromMillisecondsSinceEpoch(weatherApiDaily.dt),
                      temp: weatherApiDaily.temp.day,
                      iconName: WeatherApiIcon().getById(
                        weatherApiDaily.weather[0].id,
                        getCycleToHourly == DayCycle.day ? true : false,
                      ),
                      updateSelectedDay: () {
                        widget.updateSelectedDay(weatherApiDaily.dt);
                      },
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

/* *****************************
** Widget: SelectDayButton **
***************************** */
class SelectDayButton extends StatefulWidget {
  final bool isFirstItem;
  final bool isSelected;
  final DateTime date;
  final double temp;
  final String iconName;
  final Function updateSelectedDay;

  const SelectDayButton({
    Key? key,
    this.isFirstItem = true,
    this.isSelected = false,
    required this.date,
    required this.temp,
    required this.iconName,
    required this.updateSelectedDay,
  }) : super(key: key);

  @override
  State<SelectDayButton> createState() => _SelectDayButtonState();
}

class _SelectDayButtonState extends State<SelectDayButton> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return GestureDetector(
      onTap: () => widget.updateSelectedDay(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 80.0,
          padding: const EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: widget.isFirstItem ? 0 : 8.0),
          decoration: BoxDecoration(
            color: widget.isSelected ? Colors.blue.withOpacity(0.3) : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  DateFormat('d/M').format(widget.date),
                  style: TextStyle(fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0), child: SvgPicture.asset('assets/images/weathers_icon/${widget.iconName}')),
              ),
              Center(
                child: Text(
                  '${widget.temp.toInt()}ºC',
                  style: TextStyle(fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
