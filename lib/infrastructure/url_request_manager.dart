import 'package:covid19/models/nav_tab.dart.dart';

import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:http_util/http_util.dart';

import '../models/url_response.dart';

const String BaseUrl = "https://corona.lmao.ninja";
const String AllReport = "$BaseUrl/all";

String _getHistoricalCountryLink(String country) =>
    "$BaseUrl/v2/historical/$country";

String _getSpecificCountryReportLink(String country) =>
    "$BaseUrl/countries/$country";

class UrlRequestManager {
  // static final I = UrlRequestManager._();
  // UrlRequestManager._();

  // final DateFormat formatter = DateFormat("MMM d y");
  final DateFormat timeFormatter = DateFormat().add_jm();
  final DateFormat dateFormatter = new DateFormat("MM/dd/yy");

  Future<Either<Failure, PercentageReport>> getWorldPercentageReport() {
    return getSafeResponse<PercentageReport, Map<String, dynamic>>(
        (m) =>
            mapToPercentageReport(_getReport(m, dateFormatter, timeFormatter)),
        AllReport);
  }

  Future<Either<Failure, PercentageReport>> getSpecificCountryReport(
          String country) =>
      getSafeResponse<PercentageReport, Map<String, dynamic>>(
          (m) => mapToPercentageReport(
              _getReport(m, dateFormatter, timeFormatter)),
          _getSpecificCountryReportLink(country));

  Future<Either<Failure, CountryHistory>> getSpecificCountryTimelineReport(
          String country) =>
      getSafeResponse<CountryHistory, Map<String, dynamic>>((m) {
        final CountryHistoryMap countryHistoryMap =
            getCountryHistoryReport(m, dateFormatter);

        final CountryHistory countryHistory = CountryHistory();

        countryHistory.confirmed = convertToList<DateTime, int, Event>(
            countryHistoryMap.confirmed,
            (e) => Event(eventData: e.key, numberOfEvents: e.value));

        countryHistory.deaths = convertToList<DateTime, int, Event>(
            countryHistoryMap.deaths,
            (e) => Event(eventData: e.key, numberOfEvents: e.value));

        countryHistory.recovered = convertToList<DateTime, int, Event>(
            countryHistoryMap.recovered,
            (e) => Event(eventData: e.key, numberOfEvents: e.value));

        return countryHistory;
      }, _getHistoricalCountryLink(country));
}

List<C> convertToList<A, B, C>(Map<A, B> m, C Function(MapEntry<A, B> e) f) {
  List<C> l = [];
  m.entries.forEach((e) => l.add(f(e)));
  return l;
}

Report _getReport(Map<String, dynamic> r, DateFormat dateFormatter,
        DateFormat timeFormatter) =>
    Report(
      deaths: r["deaths"],
      recovered: r["recovered"],
      totalCases: r["cases"],
      confirmed: r['cases'] - (r['deaths'] + r['recovered']),
      updatedDate: dateFormatter
          .format(DateTime.fromMillisecondsSinceEpoch(r['updated'])),
      updatedTime: timeFormatter
          .format(DateTime.fromMillisecondsSinceEpoch(r['updated'])),
    );

// CONFIRMED = PENDING CASES
CountryHistoryMap getCountryHistoryReport(
    Map<String, dynamic> data, DateFormat dateFormatter) {
  Map<String, dynamic> cases = (data["timeline"][
      "cases"]); //TOBE DISCARDEDMap<String, dynamic> cases = (data["timeline"]["cases"]);

  Map<String, dynamic> deaths = (data["timeline"]["deaths"]);
  Map<String, dynamic> recovered = (data["timeline"]["recovered"]);
  Map<String, dynamic> confirmed = {};

  deaths.keys.forEach((key) {
    confirmed[key] =
        cases[key].toInt() - (deaths[key].toInt() + recovered[key].toInt());
  });

  MapEntry<DateTime, int> mapHistoryRecord(String dateString, dynamic count) {
    return MapEntry<DateTime, int>(
        dateFormatter.parse(dateString), count.toInt());
  }

  final ch = CountryHistoryMap(
    // cases: cases.map(mapHistoryRecord),
    recovered: recovered.map(mapHistoryRecord),
    deaths: deaths.map(mapHistoryRecord),
    confirmed: confirmed.map(mapHistoryRecord),
  );

  return ch;
}

PercentageReport mapToPercentageReport(Report report) {
  final deathPerc = ((report.deaths / report.totalCases) * 100).round();
  var recoveredPerc = ((report.recovered / report.totalCases) * 100).round();
  final confirmedPerc = ((report.confirmed / report.totalCases) * 100).round();

  final sum = confirmedPerc + deathPerc + recoveredPerc;

  final tobeAdded = 100 - sum;
  recoveredPerc = recoveredPerc + tobeAdded;

  return PercentageReport(
    confirmed: report.confirmed,
    death: report.deaths,
    recovered: report.recovered,
    confirmedPerc: confirmedPerc,
    deathPerc: deathPerc,
    recoveredPerc: recoveredPerc,
    totalCases: report.totalCases,
    updatedDate: report.updatedDate,
    updatedTime: report.updatedTime,
  );
}
