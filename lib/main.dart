import 'package:flutter/material.dart';
import 'package:the_weather/pages/dashboard_page/dashboard_page.dart';
import 'package:the_weather/pages/next_hours_detail_page/next_hours_detail_page.dart';
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const DashboardPage(),
        '/next-hours-detail': (context) => const NextHoursDetailPage(),
      },
    );
  }
}
