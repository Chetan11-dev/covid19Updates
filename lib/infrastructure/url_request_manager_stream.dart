import 'package:dartz/dartz.dart';
import 'package:http_util/http_util.dart';
import 'package:rx_command/rx_command.dart';

import '../infrastructure/url_request_manager.dart';
import '../models/country.dart';
import '../models/nav_tab.dart.dart';
import '../models/url_response.dart';
import '../service_locater.dart';

class UrlRequestManagerStream {
  static final I = UrlRequestManagerStream._();
  final RxCommand<Country, Country> countrySelected = RxCommand.createSync(
    (w) => w,
  );

  final RxCommand<String, Either<Failure, PercentageReport>>
      getSpecificCountry = RxCommand.createAsync(
    (query) => sl.get<UrlRequestManager>().getSpecificCountryReport(query),
  );

  final RxCommand<String, Either<Failure, CountryHistory>>
      getSpecificCountryTimelineReport = RxCommand.createAsync(
    (query) {
      final r =
          sl.get<UrlRequestManager>().getSpecificCountryTimelineReport(query);
      return sl
          .get<UrlRequestManager>()
          .getSpecificCountryTimelineReport(query);
    },
  );

  final RxCommand<void, Either<Failure, PercentageReport>> getGlobalPercentage =
      RxCommand.createAsyncNoParam(
    () async {
      return sl.get<UrlRequestManager>().getWorldPercentageReport();
    },
  );

  UrlRequestManagerStream._();
}

A executorDebuggerSync<A>(Function0<A> f) {
  final r = f();

  return r;
}

Future<A> executorDebugger<A>(Function0<Future<A>> f) async {
  final A r = await f();

  return r;
}
