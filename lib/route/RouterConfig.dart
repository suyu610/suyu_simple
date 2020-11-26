import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/ui/pages/Home.dart';
import 'package:suyu_simple/ui/pages/Login.dart';
import 'package:suyu_simple/ui/pages/Paint.dart';
import 'package:suyu_simple/ui/pages/quiz/screens/challenge_three_screen.dart';

class RouterConfig {
  static void configureRoutes(FluroRouter router) {
    var loginPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginPage();
    });

    var homePageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    });
    var quizHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return ChallengeThreeScreen();
    });

    var paintHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Paint();
    });

    router.define("/login", handler: loginPageHandler);
    router.define("/home", handler: homePageHandler);
    router.define("/quiz", handler: quizHandler);
    router.define("/paint", handler: paintHandler);
  }
}
