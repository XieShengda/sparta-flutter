import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Router {
  /*
   * Method to handle launching of URL
   */
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String login = '/login';
  static String home = '/home';

  static toHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, home, (route) => route == null);
  }

  static toLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, login, (route) => route == null);
  }
}
