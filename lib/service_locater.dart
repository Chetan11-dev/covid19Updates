import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:http_util/http_util.dart';

import 'infrastructure/key_value_manager.dart';
import 'infrastructure/url_request_manager.dart';
import 'models/nav_tab.dart.dart';
import 'models/url_response.dart';

bool isSlInstatiated = false;
final GetIt sl = initSl();

GetIt initSl() {
  if (isSlInstatiated) {
    throw 'isSlInstatiated instantiated twice';
  }

  setup();
  isSlInstatiated = true;
  return GetIt.instance;
}

void setup() {
  // debugSetup();
  productionSetup();
  commonSetup();
}

void commonSetup() {}

void debugSetup() {
  GetIt.instance.registerLazySingleton<UrlRequestManager>(
      () => (MockUrlRequestManager()));

  GetIt.instance
      .registerLazySingleton<KeyValueManager>(() => (MockKeyValueManager()));
}

void productionSetup() {
  GetIt.instance
      .registerLazySingleton<UrlRequestManager>(() => (UrlRequestManager()));
  GetIt.instance
      .registerLazySingleton<KeyValueManager>(() => (KeyValueManager()));
}

class MockKeyValueManager implements KeyValueManager {
  @override
  Future instantiate(String appName) {
    return null;
  }

  bool isAgrementAccepted() => true;
  @override
  bool isAgrementAcceptedByUser() {
    return true;
  }
}

class MockUrlRequestManager implements UrlRequestManager {
  @override
  Future<Either<Failure, PercentageReport>> getSpecificCountryReport(
          String country) async =>
      right(PercentageReport(
          updatedDate: null,
          updatedTime: null,
          deathPerc: 20,
          recoveredPerc: 40,
          totalCases: 100,
          confirmedPerc: 60,
          death: 20,
          recovered: 40,
          confirmed: 60));

  @override
  Future<Either<Failure, PercentageReport>> getWorldPercentageReport() async =>
      right(PercentageReport(
          updatedDate: null,
          updatedTime: null,
          deathPerc: 0,
          recoveredPerc: 40,
          totalCases: 100,
          confirmedPerc: 60,
          death: 0,
          recovered: 40,
          confirmed: 60));

  @override
  DateFormat get timeFormatter => null;
  @override
  Future<Either<Failure, CountryHistory>> getSpecificCountryTimelineReport(
      String country) {
    return null;
  }

  @override
  DateFormat get dateFormatter => null;
}
