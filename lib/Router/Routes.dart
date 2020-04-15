import 'package:auto_route/auto_route_annotations.dart';
import 'package:covid19/infrastructure/key_value_manager.dart';
import 'package:covid19/screens/coutry_page.dart';
import 'package:covid19/service_locater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Home.dart';
import '../screens/InfoPages/about_us.dart';
import '../screens/InfoPages/confirm_page.dart';
import '../screens/InfoPages/credits.dart';
import '../screens/InfoPages/data_collection_page.dart';

@MaterialAutoRouter()
class $Router {
  @CupertinoRoute()
  DataCollectionPage dataCollectionPage;
  @CupertinoRoute()
  CreditsPage creditsPage;
  @CupertinoRoute()
  AboutUs aboutUs;

  @CupertinoRoute()
  HomeScreen homeScreen;
  @CupertinoRoute()
  CountryPage countryPage;
  @initial
  FakePage determiner;
}

class FakePage {}

/// Doing this crazy stuff to determine initial Page as Router does not allow handling custom login just
/// determinPage() in the initial Route
Widget determinPage() {
  if (sl.get<KeyValueManager>().isAgrementAcceptedByUser()) {
    return HomeScreen();
  } else {
    return ConfirmPage(nextWidget: HomeScreen());
  }
}
