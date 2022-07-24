import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/pages/next_days_detail_page/widgets/select_day.dart';
import 'package:the_weather/pages/next_days_detail_page/widgets/selected_day_detail.dart';

/* *********************************
** Widget: NextDaysDetailContent **
********************************** */

class NextDaysDetailContent extends StatefulWidget {
  final bool isPortrait;
  final WeatherApi weatherApi;

  const NextDaysDetailContent({
    Key? key,
    required this.isPortrait,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<NextDaysDetailContent> createState() => _NextDaysDetailContentState();
}

class _NextDaysDetailContentState extends State<NextDaysDetailContent> {
  int _selectedDay = 0;

  @override
  void initState() {
    setState(() => _selectedDay = widget.weatherApi.daily[0].dt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPortrait
        ? ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            children: [
              SelectDayContainer(
                weatherApi: widget.weatherApi,
                selectedDay: _selectedDay,
                updateSelectedDay: (int selectedDay) => setState(() => _selectedDay = selectedDay),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SelectedDayDetailContainer(
                  weatherApi: widget.weatherApi,
                  selectedDay: _selectedDay,
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(top: 0, right: 8.0, bottom: 8.0, left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 205,
                    width: MediaQuery.of(context).size.width / 3,
                    child: SelectDayContainer(
                      weatherApi: widget.weatherApi,
                      selectedDay: _selectedDay,
                      updateSelectedDay: (int selectedDay) => setState(() => _selectedDay = selectedDay),
                    ),
                  ),
                ),
                Expanded(
                  child: SelectedDayDetailContainer(
                    weatherApi: widget.weatherApi,
                    selectedDay: _selectedDay,
                  ),
                ),
              ],
            ),
          );
  }
}
