import 'package:auto_route/auto_route.dart';
import 'package:covid19/Assets/string_assets.dart';
import 'package:covid19/Router/Routes.gr.dart';
import 'package:covid19/Utils/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: Container(
        child: Builder(
          builder: (context) => Column(
            children: <Widget>[
              CardListTile(
                message: 'Credits',
                icon: FontAwesomeIcons.creativeCommons,
                onTap: () {
                  ExtendedNavigator.ofRouter<Router>()
                      .pushNamed(Routes.creditsPage);
                },
              ),

              CardListTile(
                message: 'Privacy Policy',
                icon: Icons.info,
                onTap: () => launchUrl(privacypolicy, context),
              ),
              CardListTile(
                message: 'Terms and Conditions',
                icon: Icons.info,
                onTap: () => launchUrl(termsAndConditions, context),
              ),
              CardListTile(
                message: 'Information Source',
                icon: Icons.info,
                onTap: () {
                  ExtendedNavigator.ofRouter<Router>()
                      .pushNamed(Routes.dataCollectionPage);
                },
              ),

              // CardListTile(
              //     message: 'Credits', icon: FontAwesomeIcons.creativeCommons),
            ],
          ),
        ),
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String message;

  final double elevation;
  final IconData icon;
  final VoidCallback onTap;
  const CardListTile({
    this.message,
    this.icon,
    Key key,
    this.onTap,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        child: ListTile(
          title: Text(message,
              style: t.title.copyWith(fontWeight: FontWeight.bold)),
          leading: icon != null
              ? Icon(
                  icon,
                  color: getThemeData().primaryColor,
                  size: szh(32),
                )
              : null,
        ),
      ),
    );
  }
}
