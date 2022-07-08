import 'package:flutter/material.dart';
import 'package:the_weather/routes/route_generator.dart';
import 'package:the_weather/routes/route_name.dart';
import 'package:the_weather/styles/custom_theme_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Weather',
      theme: CustomThemeData().apply,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteName.DASHBOARD_PAGE,
    );
  }
}
