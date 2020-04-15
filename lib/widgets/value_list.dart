import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

class ValueList extends StatelessWidget {
  final IconData leading;
  final List<String> values;

  const ValueList({
    Key key,
    this.leading = LineIcons.medkit,
    this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: values.map<Widget>((value) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: szw(10), vertical: szh(5)),
          color: getThemeData().primaryColor,
          child: InkWell(
            onTap: () {},
            child: ListTile(
              leading: FaIcon(
                leading,
                color: getThemeData().colorScheme.onPrimary,
              ),
              title: Text(
                value,
                style: t.title.copyWith(
                  color: getThemeData().colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
