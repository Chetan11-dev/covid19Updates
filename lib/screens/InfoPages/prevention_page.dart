import 'package:flutter/material.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import '../../Assets/string_assets.dart';
import '../../widgets/circular_safe_view.dart';
import '../../widgets/information_text.dart';
import '../../widgets/learn_more.dart';
import '../../widgets/value_list.dart';

class PreventionPage extends StatelessWidget {
  const PreventionPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeView(
      child: Column(
        children: <Widget>[
          sbh(20),
          ValueList(values: preventionList),
          sbh(24),
          InformationText(info: preventionText),
          sbh(20),
          LearnMore(),
          sbh(20),
        ],
      ),
    );
  }
}
