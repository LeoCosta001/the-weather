import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_api/weather_api.dart';
import 'package:the_weather/pages/next_days_detail_page/widgets/next_days_detail_content.dart';

class NextDaysDetailPage extends StatefulWidget {
  const NextDaysDetailPage({Key? key}) : super(key: key);

  @override
  State<NextDaysDetailPage> createState() => _NextDaysDetailPageState();
}

class _NextDaysDetailPageState extends State<NextDaysDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Get value of preview page
    final weatherApi = ModalRoute.of(context)?.settings.arguments as WeatherApi;

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
          title: const Text(
            'Next days detail',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
            ),
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return NextDaysDetailContent(
            isPortrait: isPortrait,
            weatherApi: weatherApi,
          );
        }),
      ),
    );
  }
}
