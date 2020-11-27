import 'package:flutter/material.dart';

import 'package:suyu_simple/constant/theme_color.dart';

// ignore: non_constant_identifier_names
final ThemeData LIGHT = ThemeData(
  scaffoldBackgroundColor: ThemeColors.colorWhite,
  backgroundColor: ThemeColors.colorWhite,
  dialogBackgroundColor: ThemeColors.colorTheme,
  primaryColor: ThemeColors.colorTheme,
  textSelectionColor: Colors.black,
  hintColor: Colors.black,
);

// ignore: non_constant_identifier_names
final ThemeData DARK = ThemeData(
  primaryColor: ThemeColors.colorWhite,
  dialogBackgroundColor: Colors.black,
  backgroundColor: ThemeColors.colorBlack,
  textSelectionColor: Colors.white,
  hintColor: Colors.grey[100],
);
