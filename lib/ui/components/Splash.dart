library animated_splash;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                decoration: BoxDecoration(
                    // color: Colors.black,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "素",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 36,
                        fontFamily: 'kaitiFont',
                      ),
                    ),
                    Text(
                      "语",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 36,
                        fontFamily: 'kaitiFont',
                      ),
                    ),
                    Text(
                      "评",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 36,
                          fontFamily: 'kaitiFont'),
                    ),
                    Text(
                      "分",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 36,
                        fontFamily: 'kaitiFont',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
