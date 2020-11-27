import 'package:flutter/material.dart';

import 'package:suyu_simple/constant/ThemeColor.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ThemeColors.colorWhite,
  backgroundColor: ThemeColors.colorWhite,
  dialogBackgroundColor: ThemeColors.colorTheme,
  primaryColor: ThemeColors.colorTheme,
  textSelectionColor: Colors.black,
  hintColor: Colors.black,
);

final ThemeData darkTheme = ThemeData(
  primaryColor: ThemeColors.colorWhite,
  dialogBackgroundColor: Colors.black,
  backgroundColor: ThemeColors.colorBlack,
  textSelectionColor: Colors.white,
  hintColor: Colors.grey[100],
);