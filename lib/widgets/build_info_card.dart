import 'package:flutter/material.dart';

import 'package:numeral/numeral.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import '../models/nav_tab.dart.dart';

class BuildInfoCard extends StatelessWidget {
  final ReportSectionVisualInfo info;
  const BuildInfoCard(
    this.info, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(sz(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(color: info.color),
                ),
                sbw(5),
                Text(info.title,
                    style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.bold, fontSize: szw(14))),
              ],
            ),
            sbh(20),
            Text(Numeral(info.noOfCases).value(), //info.noOfCases.toString(),
                // textAlign: TextAlign.start,
                style: getThemeData()
                    .textTheme
                    .subhead
                    .copyWith(fontWeight: FontWeight.bold, fontSize: szw(18))),
          ],
        ),
      ),
    );
  }
}
