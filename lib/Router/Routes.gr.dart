// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart';
import 'package:covid19/Router/Routes.dart';
import 'package:covid19/screens/Home.dart';
import 'package:covid19/screens/InfoPages/about_us.dart';
import 'package:covid19/screens/InfoPages/credits.dart';
import 'package:covid19/screens/InfoPages/data_collection_page.dart';
import 'package:covid19/screens/coutry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const dataCollectionPage = '/data-collection-page';
  static const creditsPage = '/credits-page';
  static const aboutUs = '/about-us';
  static const homeScreen = '/home-screen';
  static const determiner = '/';
  static const countryPage = '/country-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.dataCollectionPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => DataCollectionPage(key: typedArgs),
          settings: settings,
        );
      case Routes.creditsPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => CreditsPage(key: typedArgs),
          settings: settings,
        );
      case Routes.aboutUs:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => AboutUs(key: typedArgs),
          settings: settings,
        );
      case Routes.homeScreen:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }

        return CupertinoPageRoute<dynamic>(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case Routes.determiner:
        return MaterialPageRoute<dynamic>(
          builder: (_) => determinPage(),
          settings: settings,
        );
      case Routes.countryPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CountryPage(),
          settings: settings,
        );

      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//InfoScreen arguments holder class
class InfoScreenArguments {
  final Key key;
  final Widget child;
  InfoScreenArguments({this.key, this.child});
}
