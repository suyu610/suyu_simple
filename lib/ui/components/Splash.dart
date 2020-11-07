library animated_splash;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';

Widget _home;
Function _customFunction;
String _imagePath;
int _duration;
Color _color;
AnimatedSplashType _runfor;

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash(
      {@required String imagePath,
      @required Widget home,
      Function customFunction,
      int duration,
      AnimatedSplashType type,
      Color color,
      Map<dynamic, Widget> outputAndHome}) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);
    _color = color;
    _home = home;
    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;
    _runfor = type;
    _outputAndHome = outputAndHome;
  }

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  navigator(home) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  @override
  Widget build(BuildContext context) {
    _runfor == AnimatedSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            var res = _customFunction();
            //print("$res+${_outputAndHome[res]}");
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                  tag: "logoImg",
                  child:
                      SizedBox(height: 80.0, child: Image.asset(_imagePath))),
              // ScaleTransition(
              //   scale: _animation,
              //   child: Hero(
              //       tag: "logoImg",
              //       child: SizedBox(
              //           height: 150.0, child: Image.asset(_imagePath))
              //           ),
              // ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Text(
                    "素",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 36,
                      fontFamily: 'kaitiFont',
                    ),
                  ),
                  Text(
                    "语",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 36,
                      fontFamily: 'kaitiFont',
                    ),
                  ),
                  Text(
                    "评",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 36,
                        fontFamily: 'kaitiFont'),
                  ),
                  Text(
                    "分",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 36,
                      fontFamily: 'kaitiFont',
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
