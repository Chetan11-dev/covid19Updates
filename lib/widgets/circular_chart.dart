import 'package:covid19/widgets/build_info_card.dart';
import 'package:covid19/widgets/colored_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:responsive_ui_by_default/responsiveui.dart';
import 'package:self_widget/Utils/list_utils.dart';

import '../models/nav_tab.dart.dart';

class CircularPieChart extends StatelessWidget {
  final List<ReportSectionVisualInfo> reportsforPieChart;

  const CircularPieChart({Key key, @required this.reportsforPieChart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: reportsforPieChart
            .map<PieChartSectionData>((percValue) => PieChartSectionData(
                color: percValue.color,
                value: percValue.percentage.toDouble(),
                title: ''))
            .toList(),
        sectionsSpace: 0,
        borderData: FlBorderData(
          show: false,
        ),
        // centerSpaceRadius: 50,
      ),
    );
  }
}

class Indicators extends StatelessWidget {
  const Indicators({Key key, @required this.reportsforIndicators})
      : super(key: key);
  final List<ReportSectionVisualInfo> reportsforIndicators;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
            reportsforIndicators.map((r) => ColoredIndicator(r)).toList());
  }
}

class NumericInfoCard extends StatelessWidget {
  const NumericInfoCard({Key key, @required this.numericReport})
      : super(key: key);

  final List<ReportSectionVisualInfo> numericReport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              child: BuildInfoCard(numericReport[0]),
              width: getScreenWidth() * 0.4,
            ),
            SizedBox(
              child: BuildInfoCard(numericReport[1]),
              width: getScreenWidth() * 0.4,
            )
          ],
        ),
        sbh(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              child: BuildInfoCard(numericReport[2]),
              width: getScreenWidth() * 0.4,
            ),
            SizedBox(
              child: BuildInfoCard(numericReport[3]),
              width: getScreenWidth() * 0.4,
            )
          ],
        ),
        sbh(20),
      ],
    );
  }
}

class VisualReportCard extends StatefulWidget {
  VisualReportCard({Key key, @required this.percentageReport})
      : super(key: key);
  final PercentageReport percentageReport;
  @override
  _VisualReportCardState createState() => _VisualReportCardState();
}

class _VisualReportCardState extends State<VisualReportCard> {
  @override
  Widget build(BuildContext context) {
    List<ReportSectionVisualInfo> allReportSections =
        getReportSpectionInfo(widget.percentageReport);

    List<ReportSectionVisualInfo> reportSectionWithOutAllCases =
        getReportWithoutAllCasesAndZeroPercentageReport(allReportSections);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          sbh(24),
          Center(
            child: Text("Today's Covid 19 Report",
                style: Theme.of(context).textTheme.title),
          ),
          SizedBox(
            // width is connected to row and its sizes
            width: getScreenWidth() * 0.86,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(szw(20)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: CircularPieChart(
                            reportsforPieChart: reportSectionWithOutAllCases)),
                    sbw(10),
                    Indicators(
                        reportsforIndicators: reportSectionWithOutAllCases)
                  ],
                ),
              ),
            ),
          ),
          sbh(20),
          NumericInfoCard(numericReport: allReportSections)
        ],
      ),
    );
  }

  List<ReportSectionVisualInfo> getReportWithoutAllCasesAndZeroPercentageReport(
          List<ReportSectionVisualInfo> xs) =>
      filter<ReportSectionVisualInfo>(xs,
          (x) => x.title == 'All Cases' || x.percentage == 0 ? false : true);

  List<ReportSectionVisualInfo> getReportSpectionInfo(
      PercentageReport percentageReport) {
    return [
      ReportSectionVisualInfo(
        color: const Color(0xfff55d52),
        noOfCases: percentageReport.death,
        percentage: percentageReport.deathPerc,
        title: 'Death',
      ),
      ReportSectionVisualInfo(
          color: getThemeData().primaryColor,
          noOfCases: percentageReport.confirmed,
          title: 'Confirmed',
          percentage: percentageReport.confirmedPerc),
      ReportSectionVisualInfo(
          color: const Color(0xff3fcbfb),
          noOfCases: percentageReport.recovered,
          title: 'Recovered',
          percentage: percentageReport.recoveredPerc),
      ReportSectionVisualInfo(
          color: Colors.grey,
          noOfCases: percentageReport.totalCases,
          title: 'All Cases',
          // Total cases are 100 Percentages so asign 100 to percentage to it
          percentage: 100)
    ];
  }
}
