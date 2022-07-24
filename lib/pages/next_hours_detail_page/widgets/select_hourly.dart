import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_weather/http/weather_api/weather_api_icon.dart';
import 'package:the_weather/http/weather_api/weather_api_utils.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/shared/utils/hour_normalize.dart';

/* ***********************
** Widget: SelectHourly **
*********************** */
class SelectHourlyContainer extends StatefulWidget {
  final WeatherApi weatherApi;
  final int selectedHour;
  final Function(int selectedHour) updateSelectedHourly;

  const SelectHourlyContainer({
    Key? key,
    required this.weatherApi,
    required this.selectedHour,
    required this.updateSelectedHourly,
  }) : super(key: key);

  @override
  State<SelectHourlyContainer> createState() => _SelectHourlyContainerState();
}

class _SelectHourlyContainerState extends State<SelectHourlyContainer> {
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

                    return SelectHourlyButton(
                      isFirstItem: index == 0,
                      isSelected: widget.selectedHour == weatherApiHourly.dt,
                      dateInMilliseconds: weatherApiHourly.dt,
                      temp: weatherApiHourly.temp,
                      iconName: WeatherApiIcon().getById(
                        weatherApiHourly.weather[0].id,
                        getCycleToHourly == DayCycle.day ? true : false,
                      ),
                      updateSelectedHourly: () {
                        widget.updateSelectedHourly(weatherApiHourly.dt);
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
** Widget: SelectHourlyButton **
***************************** */
class SelectHourlyButton extends StatefulWidget {
  final bool isFirstItem;
  final bool isSelected;
  final int dateInMilliseconds;
  final double temp;
  final String iconName;
  final Function updateSelectedHourly;

  const SelectHourlyButton({
    Key? key,
    this.isFirstItem = true,
    this.isSelected = false,
    required this.dateInMilliseconds,
    required this.temp,
    required this.iconName,
    required this.updateSelectedHourly,
  }) : super(key: key);

  @override
  State<SelectHourlyButton> createState() => _SelectHourlyButtonState();
}

class _SelectHourlyButtonState extends State<SelectHourlyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.updateSelectedHourly(),
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
                  HourNormalize().onlyHour(widget.dateInMilliseconds),
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
