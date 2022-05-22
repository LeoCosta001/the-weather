import 'package:flutter/material.dart';
import 'package:the_weather/pages/dashboard_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Weather',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          toolbarTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
          ),
        ),
        textTheme: const TextTheme(
          button: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
      },
    );
  }
}
