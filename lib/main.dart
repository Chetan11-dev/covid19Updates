import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import 'Assets/multi_media_assets.dart';
import 'Assets/string_assets.dart';
import 'Router/Routes.gr.dart';
import 'infrastructure/key_value_manager.dart';
import 'service_locater.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeStyleManager.instantiate(
      context,
      f: GoogleFonts.openSans,
    );
    return FutureBuilder(
      future:
          Future.wait([sl.get<KeyValueManager>().instantiate(appName), fdr(0)]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color(0xFF4D1F7C),
              textTheme: t.textTheme,
            ),
            builder: (context, _) {
              ThemeDataManager.instantiate(context);
              UtilsManager.instantiate(context);

              return ExtendedNavigator<Router>(router: Router());
            },
          );
        } else {
          return Container(
            color: Colors.white,
            child: Image.asset(Assets.AppIcon),
          );
        }
      },
    );
  }
}
