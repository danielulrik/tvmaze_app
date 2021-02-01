import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsUtil {
  static final white = Colors.white;

  static final green = getColorByHex('#318378');
  static final clearGreen = getColorByHex('#38A057');

  static final clearestGreen = getColorByHex('#318378');
  
  static final background = getColorByHex('#F5F7FA');
  static final darkBackground = getColorByHex('#556A4B');
  static final blueGray = getColorByHex('#95A2B2');


  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  }
}
