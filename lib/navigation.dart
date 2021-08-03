import 'package:flutter/material.dart';
import 'package:iiserk_app/Pages/Root/rootPage.dart';
import 'package:iiserk_app/Pages/Login/loginPage.dart';
import 'package:iiserk_app/Pages/Home/homePage.dart';

Route<dynamic> routes(RouteSettings settings) {
  Route<dynamic> route;
  switch (settings.name) {
    case '/login':
      route = new MyCustomRoute(
        (_) => LoginPage(),
        settings,
      );
      break;
    case '/home':
      route = new MyCustomRoute(
        (_) => HomePage(),
        settings,
      );
      break;
    case '/':
    default:
      route = new MyCustomRoute(
        (_) => RootPage(),
        settings,
      );
      break;
  }
  return route;
}

//class Routes {
//  Routes(RouteSettings settings) {
//    () {
//      switch (settings.name) {
//        case '/':
//          return new MyCustomRoute(
//             (_) => RootPage(),
//             settings,
//          );
//        case '/login':
//          return new MyCustomRoute(
//             (_) => LoginPage(),
//             settings,
//          );
//      }
//    };
//  }
//}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute(WidgetBuilder builder, RouteSettings settings)
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
