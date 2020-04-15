import 'package:flutter/material.dart';

import 'package:self_widget/self_widget.dart';

import '../Assets/string_assets.dart';
import '../Utils/url_launcher.dart';

class LearnMore extends StatelessWidget {
  const LearnMore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallBouncyButton(
      message: 'Learn More',
      onTap: () {
        launchUrl(whosite, context);
      },
    );
  }
}
