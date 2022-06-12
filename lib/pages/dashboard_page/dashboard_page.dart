import 'package:flutter/material.dart';
import 'package:the_weather/http/weather_api/weather_api_webclient.dart';
import 'package:the_weather/pages/dashboard_page/widgets/drawer.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/pages/dashboard_page/widgets/current_weather.dart';
import 'package:the_weather/pages/dashboard_page/widgets/daily_weather.dart';
import 'package:the_weather/pages/dashboard_page/widgets/hourly_weather.dart';
import 'package:the_weather/shared/widgets/centered_message.dart';
import 'package:the_weather/shared/widgets/loading_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final WeatherApiWebClient _weatherApiWebClient = WeatherApiWebClient();

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
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.room),
              ),
              Text(
                'SP - Santo André',
                style: TextStyle(
                  fontWeight: FontWeight.w400,

                  /// TODO: The font size must take into account the number of characters to be displayed so that it does not exceed the demarcated size
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        drawer: DashboardDrawer(
          onSelectLocation: (selectedLocation) {
            print(selectedLocation.toString());
          },
        ),

        body: OrientationBuilder(builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          // Responsive size
          final topContainerPadding = MediaQuery.of(context).size.width / (isPortrait ? 3 : 20);

          return RefreshIndicator(
              onRefresh: () async {
                /// TODO: Refresh page function
              },
              child: FutureBuilder(
                initialData: const [],
                future: _weatherApiWebClient.getWeatherApiOneCall(
                  WeatherApiWebClientOneCallOption(longitude: -46.51, latitude: -23.68),
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      // TODO: Handle this case.
                      break;
                    case ConnectionState.waiting:
                      return const LoadingData();
                    case ConnectionState.active:
                      // TODO: Handle this case.
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        final WeatherApi weatherApi = snapshot.data as WeatherApi;

                        if (isPortrait) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(top: topContainerPadding, right: 8.0, bottom: 8.0, left: 8.0),
                            children: [
                              // Current weather
                              CurrentWeatherContainer(weatherApi: weatherApi),
                              // Hourly weather
                              HourlyWeatherContainer(weatherApi: weatherApi),
                              // Daily weather
                              DailyWeatherContainer(weatherApi: weatherApi)
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 0, right: 8.0, bottom: 8.0, left: 8.0),
                            child: Row(
                              children: [
                                // Current weather
                                CurrentWeatherContainer(weatherApi: weatherApi),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      // Hourly weather
                                      HourlyWeatherContainer(weatherApi: weatherApi),
                                      // Daily weather
                                      DailyWeatherContainer(weatherApi: weatherApi)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return CenteredMessage(
                        'Unknown error!',
                        icon: Icons.error,
                        color: Theme.of(context).errorColor,
                      );
                  }

                  return Container();
                },
              ));
        }),
      ),
    );
  }
}

