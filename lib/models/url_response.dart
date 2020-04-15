import 'package:flutter/foundation.dart';

class Report {
  final int recovered;
  final int confirmed;
  final int deaths;
  final int totalCases;
  final String updatedDate;
  final String updatedTime;

  const Report(
      {@required this.confirmed,
      @required this.recovered,
      @required this.deaths,
      @required this.totalCases,
      @required this.updatedDate,
      @required this.updatedTime});

  @override
  String toString() {
    return """
   recovered =    $recovered  , 
   confirmed =    $confirmed  , 
   deaths =    $deaths  , 
   totalCases =    $totalCases  , 
   updatedDate =    $updatedDate  , 
   updatedTime =    $updatedTime  , 
      """;
  }
}

class CountryReport {
  final int recovered;
  final int todayDeaths;
  final int todayCases;
  final int confirmed;
  final int deaths;
  final int totalCases;
  final String countryName;

  const CountryReport(
      {this.confirmed,
      this.deaths,
      this.recovered,
      this.todayCases,
      this.todayDeaths,
      this.totalCases,
      this.countryName});

  @override
  String toString() {
    return """
 recovered = $recovered,
 todayDeaths =  $todayDeaths,
 todayCases =  $todayCases,
 confirmed =  $confirmed,
 deaths =  $deaths,
 totalCases =  $totalCases,
 countryName =  $countryName,
""";
  }
}

class CountryHistoryMap {
  // Map<DateTime, int> cases;
  Map<DateTime, int> deaths;
  Map<DateTime, int> confirmed;
  Map<DateTime, int> recovered;

  CountryHistoryMap({this.deaths, this.confirmed, this.recovered});

  @override
  String toString() => '''
  ---------------------------
   ---------------------------
   deaths : $deaths ,
   ---------------------------
   recovere: $recovered ,
   ---------------------------
   confirmed: $confirmed
  ''';
}

class CountryHistory {
  // Map<DateTime, int> cases;

  List<Event> deaths;
  List<Event> confirmed;
  List<Event> recovered;

  CountryHistory({this.deaths, this.confirmed, this.recovered});

  @override
  String toString() => '''
  ---------------------------
   ---------------------------
   deaths : $deaths ,
   ---------------------------+
   recovere: $recovered ,
   ---------------------------
   confirmed: $confirmed
   ---------------------------
   ---------------------------
  ''';
}

class Event {
  final int numberOfEvents;
  final DateTime eventData;

  Event({this.numberOfEvents, this.eventData});
  @override
  String toString() {
    return '''
     numberOfEvents = $numberOfEvents ,
     eventData = $eventData ,
  ''';
  }
}
