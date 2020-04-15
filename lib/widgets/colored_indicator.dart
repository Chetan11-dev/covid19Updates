import 'package:flutter/material.dart';

import 'package:responsive_ui_by_default/responsiveui.dart';


import '../models/nav_tab.dart.dart';

class ColoredIndicator extends StatelessWidget {
  final ReportSectionVisualInfo colorValue;
  const ColoredIndicator(this.colorValue, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizeInfo) {
      return Row(
        children: <Widget>[
          Container(
            width: szw(25),
            height: szh(8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: colorValue.color,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ),
          sbw(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(colorValue.title,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              Text('${colorValue.percentage}%',
                  style: getThemeData().textTheme.subhead.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
          sbw(5)
        ],
      );
    });
  }
}
