import 'package:flutter/material.dart';
import 'package:the_weather/pages/dashboard_page/dashboard_page.dart';
import 'package:the_weather/pages/next_hours_detail_page/next_hours_detail_page.dart';
import 'package:the_weather/routes/route_name.dart';

/* *************************
** Page routes navigation **
************************* */

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.DASHBOARD_PAGE:
        return _GeneratePageRoute(
          widget: const DashboardPage(),
          routeName: settings.name as String,
        );
      case RouteName.NEXT_HOURS_DETAIL_PAGE:
        return _GeneratePageRoute(
          widget: const NextHoursDetailPage(),
          routeName: settings.name as String,
          arguments: settings.arguments as Object,
        );
      default:
        return _GeneratePageRoute(
          widget: const DashboardPage(),
          routeName: RouteName.DASHBOARD_PAGE,
        );
    }
  }
}

/* *****************
** Page generator **
****************** */

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  final Object? arguments;
  _GeneratePageRoute({required this.widget, required this.routeName, this.arguments})
      : super(
            settings: RouteSettings(name: routeName, arguments: arguments),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                // Define animation direction
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
