import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:hive_manager/hive_manager.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import '../../Assets/string_assets.dart';
import '../../Router/Routes.gr.dart';
import '../../Utils/url_launcher.dart';

class ConfirmPage extends StatelessWidget {
  final Widget nextWidget;

  const ConfirmPage({Key key, @required this.nextWidget}) : super(key: key);

  Future showAgreementAcceptanceDialog(BuildContext context) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'I agree to the',
                          style: t.subhead.copyWith(
                              color: getThemeData().colorScheme.onSurface)),
                      TextSpan(
                          text: 'Terms and conditions ',
                          style: t.subhead.copyWith(
                              color: Colors.blue, fontStyle: FontStyle.italic),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(termsAndConditions, context);
                            }),
                      TextSpan(
                          text: 'and  ',
                          style: t.subhead.copyWith(
                              color: getThemeData().colorScheme.onSurface)),
                      TextSpan(
                          text: 'Privacy Policy ',
                          style: t.subhead.copyWith(
                              color: Colors.blue, fontStyle: FontStyle.italic),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(privacypolicy, context);
                            }),
                      TextSpan(
                          text: 'of $appName. ',
                          style: t.subhead.copyWith(
                              color: getThemeData().colorScheme.onSurface))
                    ])),
                    sbw(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            FlevaIcons.close,
                            color: Colors.red[400],
                            size: sz(36),
                          ),
                          onPressed: () => SystemNavigator.pop(),
                        ),
                        IconButton(
                          icon: Icon(
                            FlevaIcons.checkmark,
                            color: Colors.green,
                            size: sz(36),
                          ),
                          onPressed: () {
                            HiveManager.put(isAgrementAccepted, true);
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.homeScreen);
                          },
                        ),
                        // Icon(Icons.accessibility),
                      ],
                    )
                  ],
                ),
              ),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            ));
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.bounceOut,
      duration: Duration(milliseconds: 900),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      showAgreementAcceptanceDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation Page'),
      ),
      body: sb(0),
    );
  }
}
