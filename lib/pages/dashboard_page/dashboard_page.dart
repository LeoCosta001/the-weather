import 'package:flutter/material.dart';
import 'package:the_weather/http/weather_api/weather_api_webclient.dart';
import 'package:the_weather/models/positionstack_api/positionstack_location_normalize.dart';
import 'package:the_weather/pages/dashboard_page/widgets/dashboard_content.dart';
import 'package:the_weather/pages/dashboard_page/widgets/drawer.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/shared/enums/request_state.dart';

/* ************************
** Widget: DashboardPage **
************************ */

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final WeatherApiWebClient _weatherApiWebClient = WeatherApiWebClient();

  // States
  RequestState _requestState = RequestState.initial;
  PositionstackLocationNormalize? _selectedLocation;
  WeatherApi? _selectedLocationWeather;

  // Methods
  void _updateSelectedLocation(PositionstackLocationNormalize newLocation) {
    setState(() => _requestState = RequestState.loading);
    setState(() => _selectedLocation = newLocation);

    _weatherApiWebClient
        .getWeatherApiOneCall(
      WeatherApiWebClientOneCallOption(longitude: newLocation.longitude, latitude: newLocation.latitude),
    )
        .then((WeatherApi newWeatherApi) {
      setState(() => _selectedLocationWeather = newWeatherApi);
      setState(() => _requestState = RequestState.ok);
    }).catchError((onError) {
      setState(() => _requestState = RequestState.error);
    });
  }

  String _getPageTitleText() {
    return _selectedLocation == null ? 'Select location' : '${_selectedLocation!.title} - ${_selectedLocation!.subTitle}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/weathers_bg/sunset-01.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.0),
                ],
              ),
            ),
          ),
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.room),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _getPageTitleText(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: DashboardDrawer(
          onSelectLocation: (PositionstackLocationNormalize selectedLocation) {
            _updateSelectedLocation(selectedLocation);
          },
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return RefreshIndicator(
            onRefresh: () async {
              /// TODO: Refresh page function
            },
            child: DashboardContent(
              requestState: _requestState,
              selectedLocation: _selectedLocation,
              selectedLocationWeather: _selectedLocationWeather,
              isPortrait: isPortrait,
            ),
          );
        }),
      ),
    );
  }
}
