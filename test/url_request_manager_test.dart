import 'package:covid19/models/url_response.dart';
import 'package:covid19/service_locater.dart';
import 'package:covid19/infrastructure/url_request_manager.dart';
import 'package:covid19/models/nav_tab.dart.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_util/http_util.dart';

void main() {
  test('get Specific Country Report', () async {
    Either<Failure, PercentageReport> r =
        await sl.get<UrlRequestManager>().getSpecificCountryReport('Anguilla');

    r.fold((e) {
      expect(e.toString(), isNotNull);
      throw e;
    }, (PercentageReport report) {
      expect(report.deathPerc + report.confirmedPerc + report.recoveredPerc,
          equals(100));

      nonNullExpectation([
        report.confirmed,
        report.recovered,
        report.death,
        report.totalCases,
        report.updatedDate,
        report.updatedTime
      ]);
    });
  });

  test('get Global Reports', () async {
    Either<Failure, PercentageReport> r =
        await sl.get<UrlRequestManager>().getWorldPercentageReport();

    r.fold((e) {
      expect(e.toString(), isNotNull);
      throw e;
    }, (PercentageReport report) {
      expect(report.deathPerc + report.confirmedPerc + report.recoveredPerc,
          equals(100));

      nonNullExpectation([
        report.confirmed,
        report.recovered,
        report.death,
        report.totalCases,
        report.updatedDate,
        report.updatedTime
      ]);
    });
  });

  test('get Specific Country TimeLine Report', () async {
    final r = await sl
        .get<UrlRequestManager>()
        .getSpecificCountryTimelineReport('India');

    r.fold((e) {
      expect(e.toString(), isNotNull);

      throw e;
    }, (CountryHistory timeline) {
      nonNullExpectation([
        ...timeline.recovered,
        ...timeline.recovered,
        ...timeline.deaths,
        ...timeline.deaths,
        ...timeline.confirmed,
        ...timeline.confirmed,
      ]);

      expect(timeline.confirmed.length, equals(timeline.deaths.length));
      expect(timeline.deaths.length, equals(timeline.recovered.length));
    });
  });
}

nonNullExpectation(List list) {
  list.forEach((i) {
    assert(!(i.runtimeType is List));
    assert(i != null);
  });
}
