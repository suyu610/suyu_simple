import 'package:flutter/material.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';

class RulePage extends StatefulWidget {
  RulePage({Key key}) : super(key: key);

  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "规则页面",
            style: ThemeFonts.titleFont,
          ),
        ),
      ],
    );
  }
}
