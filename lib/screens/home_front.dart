import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';
import 'package:self_widget/self_widget.dart';

import '../infrastructure/url_request_manager_stream.dart';
import '../widgets/circular_chart.dart';
import 'coutry_page.dart';

class WorldReport extends StatefulWidget {
  const WorldReport({
    Key key,
  }) : super(key: key);

  @override
  _WorldReportState createState() => _WorldReportState();
}

class _WorldReportState extends State<WorldReport> {
  @override
  void initState() {
    super.initState();
    // Stops it's Refiring
    if (UrlRequestManagerStream.I.getGlobalPercentage.lastResult == null ||
        UrlRequestManagerStream.I.getGlobalPercentage.lastResult.isLeft()) {
      UrlRequestManagerStream.I.getGlobalPercentage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: UrlRequestManagerStream.I.getGlobalPercentage,
          initialData: UrlRequestManagerStream.I.getGlobalPercentage.lastResult,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              style:
                                  Theme.of(context).textTheme.headline.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: szh(27),
                                      ),
                            ),
                            sbh(24),
                            SmallBouncyButton(
                              message: 'Refresh',
                              onTap: () {
                                UrlRequestManagerStream.I.getGlobalPercentage();
                                // setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                  (result) => VisualReportCard(percentageReport: result));
            } else
              return sbh(0);
          },
        ),
        StreamBuilder<bool>(
          stream: UrlRequestManagerStream.I.getGlobalPercentage.isExecuting,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData || snapshot.data == false) {
              return sbh(0);
            } else {
              return Center(
                child: Padding(
                    padding: EdgeInsets.all(szh(32)),
                    child: SkinCircularProgressIndicator()),
              );
            }
          },
        ),
      ],
    );
  }
}

// List<String> msgs = [];

// addToQueue(msg) {
//   msgs.add(msg.toString());
// }

// logQueue() {
//   String message = '';
//   msgs.forEach((msg) => message += '$msg ');
//   _logMessage(message);
//   msgs.clear();
// }

// _logMessage(String message) {
//   return;
//   Logger().i(message);
// }
