import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/InfoPages/prevention_page.dart';
import '../screens/InfoPages/symptoms_page.dart';

class ValueNavTab {
  final IconData icon;
  final String title, subTitle;
  final Widget Function() getPage;
  const ValueNavTab({this.getPage, this.icon, this.title, this.subTitle});
}

// ignore :non_constant_identifier_names
final symptoms = ValueNavTab(
    icon: FontAwesomeIcons.medkit,
    title: 'Symptoms',
    subTitle: 'Find symptoms of Covid-19 in early stages',
    getPage: () {
      return SymptomsPage();
    });

final prevention = ValueNavTab(
    icon: FontAwesomeIcons.bookMedical,
    title: 'Prevention',
    subTitle: 'Prevent Infection',
    getPage: () {
      return PreventionPage();
      // navigateToInfoScreen();
    });

// const Reports = ValueNavTab(
//   icon: Icons.insert_chart,
//   title: 'Reports',
//   subTitle: 'Data and info related to the disease',
// );

// const Countries = ValueNavTab(
//   icon: FontAwesomeIcons.globeAmericas,
//   title: 'Countries',
//   subTitle: 'Countries infected by COVID-19',
// );

List<ValueNavTab> getNavs() => _navs;

final List<ValueNavTab> _navs = [
  symptoms,
  prevention,
];

class ReportSectionVisualInfo {
  final Color color;
  final int percentage;
  final String title;
  final int noOfCases;
  ReportSectionVisualInfo(
      {this.color, this.percentage, this.noOfCases, this.title});

  @override
  String toString() {
    return '''
  color = $color , 
  percentage = $percentage , 
  title = $title , 
  noOfCases = $noOfCases , 
''';
  }
}

class PercentageReport {
  final int deathPerc,
      recoveredPerc,
      confirmedPerc,
      death,
      recovered,
      confirmed,
      totalCases;
  final String updatedDate;
  final String updatedTime;
  PercentageReport({
    @required this.updatedDate,
    @required this.updatedTime,
    @required this.deathPerc,
    @required this.recoveredPerc,
    @required this.totalCases,
    @required this.confirmedPerc,
    @required this.death,
    @required this.recovered,
    @required this.confirmed,
  });

  // double get deathPercD => deathPerc.toDouble();
  // double get recoveredPercD => recoveredPerc.toDouble();
  // double get confirmedPercD => confirmedPerc.toDouble();

  @override
  String toString() {
    return '''
    deathPerc = $deathPerc,
    recoveredPerc = $recoveredPerc,
    confirmedPerc = $confirmedPerc,
  ''';
  }
}
