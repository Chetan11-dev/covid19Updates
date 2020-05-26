
import 'package:covid19/infrastructure/url_request_manager_stream.dart';
import 'package:covid19/widgets/search_widget.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:http_util/http_util.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import '../models/country.dart';
import '../models/nav_tab.dart.dart';
import '../widgets/circular_chart.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchCountryWidget(onCountrySelected: (country) {
          UrlRequestManagerStream.I
            ..countrySelected(country)
            ..getSpecificCountry(country.name);
        }),
        StreamBuilder<Country>(
          stream: UrlRequestManagerStream.I.countrySelected,
          initialData: UrlRequestManagerStream.I.countrySelected.lastResult,
          builder: (BuildContext context, AsyncSnapshot<Country> snapshot) {
            if (!snapshot.hasData) {
              return sbh(0);
            } else {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: szw(16), vertical: szh(8)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            ' ${snapshot.data.flag}  ${snapshot.data.name}',
                            style: t.headline),
                      ),
                    ],
                  ));
            }
          },
        ),
        StreamBuilder<bool>(
          stream: UrlRequestManagerStream.I.getSpecificCountry.isExecuting,
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

        //TODO ADD TIMELINE
        StreamBuilder<dartz.Either<Failure, PercentageReport>>(
          stream: UrlRequestManagerStream.I.getSpecificCountry,
          initialData: UrlRequestManagerStream.I.getSpecificCountry.lastResult,
          builder: (BuildContext context,
              AsyncSnapshot<dartz.Either<Failure, PercentageReport>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.fold<Widget>(
                  (f) => Text(f.toString()),
                  (PercentageReport s) =>
                      VisualReportCard(percentageReport: s));
              // return ;
            } else
              return sbh(0);
          },
        ),
      ],
    );
  }
}

class SkinCircularProgressIndicator extends StatelessWidget {
  final Animation<Color> valueColor;
  const SkinCircularProgressIndicator({Key key, this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      valueColor:
          valueColor ?? AlwaysStoppedAnimation(getThemeData().primaryColor),
    );
  }
}
