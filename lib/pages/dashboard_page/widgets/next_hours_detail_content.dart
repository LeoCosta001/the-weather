import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/pages/dashboard_page/widgets/select_hourly.dart';
import 'package:the_weather/pages/dashboard_page/widgets/selected_hourly_detail.dart';

/* *********************************
** Widget: NextHoursDetailContent **
********************************** */

class NextHoursDetailContent extends StatefulWidget {
  final bool isPortrait;
  final WeatherApi weatherApi;

  const NextHoursDetailContent({
    Key? key,
    required this.isPortrait,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<NextHoursDetailContent> createState() => _NextHoursDetailContentState();
}

class _NextHoursDetailContentState extends State<NextHoursDetailContent> {
  int _selectedHour = 0;

  @override
  void initState() {
    setState(() => _selectedHour = widget.weatherApi.hourly[1].dt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPortrait
        ? ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            children: [
              SelectHourlyContainer(
                weatherApi: widget.weatherApi,
                selectedHour: _selectedHour,
                updateSelectedHourly: (int selectedHour) => setState(() => _selectedHour = selectedHour),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SelectedHourlyDetailContainer(
                  weatherApi: widget.weatherApi,
                  selectedHour: _selectedHour,
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
                    child: SelectHourlyContainer(
                      weatherApi: widget.weatherApi,
                      selectedHour: _selectedHour,
                      updateSelectedHourly: (int selectedHour) => setState(() => _selectedHour = selectedHour),
                    ),
                  ),
                ),
                Expanded(
                  child: SelectedHourlyDetailContainer(
                    weatherApi: widget.weatherApi,
                    selectedHour: _selectedHour,
                  ),
                ),
              ],
            ),
          );
  }
}
