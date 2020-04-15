import 'package:flutter/material.dart';
import 'package:self_widget/self_widget.dart';

import 'package:url_launcher/url_launcher.dart';

Future launchUrl(String url, BuildContext context) async {
  if (await canLaunch(url))
    launch(url);
  else
    showSnackBar('Could not connect.', context);
}
