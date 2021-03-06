import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';

class TextWithUnderLine extends StatelessWidget {
  const TextWithUnderLine(this.text, {Key key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              decorationStyle: TextDecorationStyle.solid,
              // decorationStyle: TextDecorationStyle.wavy,
              decorationColor: ThemeColors.colorTheme,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              fontFamily: Provider.of<FontFamilyProvider>(context).fontFamily,

              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
