import 'package:flutter/material.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

class InformationText extends StatelessWidget {
  final String info;

  const InformationText({
    Key key,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: szw(15),
        right: szw(15),
      ),
      child: Text(
        info ?? 'Coming Soon',
        style: t.subhead.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
