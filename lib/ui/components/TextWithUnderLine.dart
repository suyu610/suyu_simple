import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';

class TextWithUnderLine extends StatelessWidget {
  const TextWithUnderLine(this.text, {Key key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final String fontfamily =
        Provider.of<FontFamilyProvider>(context, listen: false).fontFamily;
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
              // decorationStyle: TextDecorationStyle.solid,
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: ThemeColors.colorTheme,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              fontFamily: fontfamily,

              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
