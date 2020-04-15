import 'package:auto_route/auto_route.dart';
import 'package:covid19/Router/Routes.gr.dart';
import 'package:covid19/models/nav_tab.dart.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import 'InfoPages/about_us.dart';

class BackLayer extends StatelessWidget {
  const BackLayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(szh(8)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Prevent Covid-19",
              style: t.display1.copyWith(color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.all(szh(12)),
            children: getNavs().map<Widget>((v) {
              return Padding(
                padding: EdgeInsets.all(szh(8)),
                child: InkWell(
                  onTap: () async {
                    await Future.delayed(dr(250));
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => v.getPage()));
                  },
                  child: Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(szh(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // use FaIcon for better support
                          FaIcon(v.icon, color: Colors.amber, size: szh(32)),
                          Expanded(child: const SizedBox()),
                          Text(v.title,
                              style: t.title.copyWith(color: Colors.white)),
                          sbh(8),
                          Text(v.subTitle,
                              style: t.caption.copyWith(color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: szw(24.0)),
          child: InkWell(
            onTap: () async {
              await Future.delayed(dr(250));
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AboutUs()));
            },
            child: InkWell(
              onTap: () => ExtendedNavigator.ofRouter<Router>()
                  .pushNamed(Routes.aboutUs),
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(szh(14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FaIcon(Icons.info, color: Colors.amber, size: szh(32)),
                      sbw(20),
                      Text('About Us',
                          style: t.title.copyWith(color: Colors.white))
                      // ListTile(
                      //     leading: FaIcon(Icons.info,
                      //         color: Colors.amber, size: szh(32)),
                      //     title:) // getThemeData().colorScheme.primary)),
                      //     )
                      // use FaIcon for better support
                      //   FaIcon(v.icon, color: Colors.amber, size: szh(32)),
                      //   Expanded(child: const SizedBox()),
                      //   Text(v.title,
                      //       style: t.title.copyWith(color: Colors.white)),
                      //   sbh(8),
                      //   Text(v.subTitle,
                      //       style:
                      //           t.caption.copyWith(color: Colors.white54)),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // doing this weird thing so that as BackDrop has sideeffects
        //  of giving us all height rather than available height
        SizedBox(
          height: getScreenHeight() * .1,
        )
      ],
    );
  }
}
