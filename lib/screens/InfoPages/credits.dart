import 'package:flutter/material.dart';

import '../../Assets/string_assets.dart';
import '../../Utils/url_launcher.dart';
import '../../widgets/circular_safe_view.dart';
import 'about_us.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularSafeView(
      child: Container(
        child: Builder(
          builder: (context) => Column(
            children: <Widget>[
              CardListTile(
                message:
                    'Credits Page is one of the most important element of a software.It is a way of showing thanks to the awesome people due to whom the software came into existence ',
              ),
              CardListTile(
                message:
                    'Flutter - for the awesome framework for App Devlopment',
                onTap: () => launchUrl(flutterLink, context),
                elevation: 8,
              ),
              CardListTile(
                message: 'App Design is inspired by Awesome Tmrwstudio',
                onTap: () => launchUrl(designInspirationLink, context),
                elevation: 8,
              ),
              CardListTile(
                message:
                    'Information is Collected From NovelCovid Api. Thank you NovelCovid Developers for your Efforts',
                elevation: 8,
                onTap: () => launchUrl(apiLink, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
