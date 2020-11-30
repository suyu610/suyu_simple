import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/ui/pages/Home.dart';
import 'package:suyu_simple/ui/pages/Login.dart';
import 'package:suyu_simple/ui/pages/Paint.dart';
import 'package:suyu_simple/ui/pages/game/break_game.dart';
import 'package:suyu_simple/ui/pages/quiz/challenge_three_screen.dart';
import 'package:suyu_simple/ui/pages/songs.dart';
import 'package:suyu_simple/ui/test/test_login_view.dart';

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
    var testloginHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginView();
    });
    var breakGameHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return BreakGame();
    });
    var songPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return SongPage(title: "播放列表");
    });
    router.define("/login", handler: loginPageHandler);
    router.define("/home", handler: homePageHandler);
    router.define("/quiz", handler: quizHandler);
    router.define("/paint", handler: paintHandler);
    router.define("/test_login", handler: testloginHandler);
    router.define("/break_game", handler: breakGameHandler);
    router.define("/song", handler: songPageHandler);
  }
}
