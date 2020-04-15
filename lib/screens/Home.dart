import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';
import 'package:self_widget/self_widget.dart';

import 'coutry_page.dart';
import 'home_back.dart';
import 'home_front.dart';

final RxCommand<Widget, Widget> navButtonTapped =
    RxCommand.createSync((w) => w, initialLastResult: worldReport);

final Widget worldReport = WorldReport(), countryReport = CountryPage();
// timelineReport = TimeLineReport();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text("Covid 19"),
      iconPosition: BackdropIconPosition.action,
      backLayer: BackLayer(),
      animationCurve: Curves.easeOut,
      animatedIcon: AnimatedIcons.close_menu,
      frontLayer: StreamBuilder<Widget>(
          initialData: navButtonTapped.lastResult,
          stream: navButtonTapped,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: snapshot.data,
              physics: BouncingScrollPhysics(),
            );
          }),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: getThemeData().scaffoldBackgroundColor,
        items: <Widget>[
          Icon(FlevaIcons.globe_3, size: szh(30)),
          Icon(FlevaIcons.flag_outline, size: szh(30)),
          // Icon(FlevaIcons.info, size: szh(30)),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              navButtonTapped(worldReport);
              break;
            case 1:
              navButtonTapped(countryReport);
              break;
            // case 2:
            //   navButtonTapped(timelineReport);
            //   break;
            default:
          }
        },
      ),
    );
  }
}
