import 'package:covid19/screens/coutry_page.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:fl_chart/fl_chart.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:http_util/http_util.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';
import 'package:self_widget/self_widget.dart';



import '../infrastructure/url_request_manager_stream.dart';
import '../models/url_response.dart';

class TimeLineReport extends StatefulWidget {
  const TimeLineReport({Key key}) : super(key: key);

  @override
  _TimeLineReportState createState() => _TimeLineReportState();
}

class _TimeLineReportState extends State<TimeLineReport> {
  @override
  void initState() {
    if (UrlRequestManagerStream.I.getSpecificCountryTimelineReport.lastResult ==
            null ||
        UrlRequestManagerStream.I.getSpecificCountryTimelineReport.lastResult
            .isLeft()) {
      UrlRequestManagerStream.I.getSpecificCountryTimelineReport('India');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<dartz.Either<Failure, CountryHistory>>(
          stream: UrlRequestManagerStream.I.getSpecificCountryTimelineReport,
          initialData: UrlRequestManagerStream
              .I.getSpecificCountryTimelineReport.lastResult,
          builder: (BuildContext context,
              AsyncSnapshot<dartz.Either<Failure, CountryHistory>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.fold<Widget>(
                  (failure) => Padding(
                        padding: EdgeInsets.only(
                            top: getScreenWidth() * 0.3,
                            left: szw(24),
                            right: szw(24)),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              FlevaIcons.wifi_off,
                              size: getScreenWidth() * 0.4,
                            ),
                            Text(
                              failure.toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: szh(27),
                                  ),
                            ),
                            sbh(24),
                            SmallBouncyButton(
                              message: 'Refresh',
                              onTap: () {
                                UrlRequestManagerStream.I
                                    .getSpecificCountryTimelineReport('India');
                              },
                            )
                          ],
                        ),
                      ),
                  (result) => BuildTimeGraph(history: result));
            } else
              return sbh(0);
          },
        ),
        StreamBuilder<bool>(
          stream: UrlRequestManagerStream
              .I.getSpecificCountryTimelineReport.isExecuting,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData || snapshot.data == false) {
              return sbh(0);
            } else {
              return Padding(
                  padding: EdgeInsets.all(szh(8)),
                  child: SkinCircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

class BuildTimeGraph extends StatelessWidget {
  final CountryHistory history;
  const BuildTimeGraph({Key key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: linesBarData1(),
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(showTitles: false),
            leftTitles: SideTitles(showTitles: false)),
      ),
    );
  }

  List<LineChartBarData> linesBarData1() {
    List<FlSpot> confrmed = [], deaths = [], recovered = [];

    List<Event> cur = history.confirmed;
    for (int i = 0, len = cur.length; i < len; i++) {
      confrmed.add(FlSpot(i.toDouble(), cur[i].numberOfEvents.toDouble()));
    }
    cur = history.deaths;
    for (int i = 0, len = cur.length; i < len; i++) {
      deaths.add(FlSpot(i.toDouble(), cur[i].numberOfEvents.toDouble()));
    }
    cur = history.recovered;
    for (int i = 0, len = cur.length; i < len; i++) {
      recovered.add(FlSpot(i.toDouble(), cur[i].numberOfEvents.toDouble()));
    }
    List<List<FlSpot>> finallist = [confrmed, deaths, recovered];
    return List.generate(
        3,
        (index) => LineChartBarData(
              spots: finallist[index],
              isCurved: true,
              colors: [
                const Color(0xff4af699),
              ],
              barWidth: 8,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: false,
              ),
            ));
  }
}
