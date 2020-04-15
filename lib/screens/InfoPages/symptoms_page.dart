import 'package:covid19/widgets/circular_safe_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import 'package:covid19/Assets/string_assets.dart';
import 'package:covid19/widgets/information_text.dart';
import 'package:covid19/widgets/learn_more.dart';
import 'package:covid19/widgets/value_list.dart';

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeView(
      child: Column(
        children: <Widget>[
          sbh(20),
          ValueList(values: symptomsList),
          sbh(24),
          InformationText(info: symptomText),
          sbh(20),
          LearnMore(),
          sbh(20),
        ],
      ),
    );
  }
}
