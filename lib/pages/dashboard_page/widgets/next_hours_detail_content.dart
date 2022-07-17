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
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8.0),
      children: [
        SelectHourlyContainer(
          weatherApi: widget.weatherApi,
          selectedHour: _selectedHour,
          updateSelectedHourly: (int selectedHour) => setState(() => _selectedHour = selectedHour),
        ),
        SelectedHourlyDetailContainer(
          weatherApi: widget.weatherApi,
          selectedHour: _selectedHour,
        )
      ],
    );
  }
}
