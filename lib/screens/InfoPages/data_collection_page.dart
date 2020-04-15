import 'package:covid19/Assets/string_assets.dart';
import 'package:covid19/Utils/url_launcher.dart';
import 'package:covid19/widgets/circular_safe_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

class DataCollectionPage extends StatefulWidget {
  DataCollectionPage({Key key}) : super(key: key);

  @override
  _DataCollectionPageState createState() => _DataCollectionPageState();
}

class _DataCollectionPageState extends State<DataCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return CircularSafeView(
      title: 'Data Collection',
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(szh(20)),
            child: Text(
              'How is the data collected? ',
              style: t.title,
            ),
          ),
          Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.all(szh(20)),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            'The data about the Corona pandemic is collected through the ',
                        style: t.subhead),
                    TextSpan(
                        text: 'NovelCovid API ',
                        style: t.subhead.copyWith(
                            color: Colors.blue, fontStyle: FontStyle.italic),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(apiLink, context);
                          }),
                    TextSpan(
                        text:
                            "which provides information about coronavirus cases (total cases, deaths and recovered) and is updated timely. While all parties try to provide as accurate data as possible, errors may occur. It is recommended that you compare the data here with other sources to be sure for its validity.",
                        style: t.subhead),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
