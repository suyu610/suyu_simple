library animated_splash;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

Widget _home;
Function _customFunction;

int _duration;
Color _color;
AnimatedSplashType _runfor;

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash(
      {@required Widget home,
      Function customFunction,
      int duration,
      AnimatedSplashType type,
      Color color,
      Map<dynamic, Widget> outputAndHome}) {
    assert(duration != null);
    assert(home != null);
    _color = color;
    _home = home;
    _duration = duration;
    _customFunction = customFunction;
    _runfor = type;
    _outputAndHome = outputAndHome;
  }

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 800;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  navigator(home) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 667), allowFontScaling: true);
    _runfor == AnimatedSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            var res = _customFunction();
            Future.delayed(Duration(milliseconds: _duration)).then((value) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => _outputAndHome[res]));
            });
          })
        : Future.delayed(Duration(milliseconds: _duration)).then((value) {
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (BuildContext context) => _home));
          });

    return Scaffold(
        backgroundColor: _color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                decoration: BoxDecoration(
                    // color: Colors.black,
                    ),
                child: Text(
                  "素\n语\n评\n分",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 36,
                    fontFamily: 'logoFont',
                  ),
                ),
              ),
              SizedBox(height: 20),

              BallClipRotateMultipleIndicator(
                minRadius: 8,
                maxRadius: 15,
                color: Colors.black,
                duration: const Duration(milliseconds: 600),
              ),
              // PacmanIndicator(
              //   radius: 12,
              //   color: Colors.black,
              // ),
              Spacer(),
              Text(
                "v0.1",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withAlpha(100),
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  fontFamily: 'logoFont',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
