import 'package:audio_adventure/Consts/colors.dart';
import 'package:flutter/material.dart';

const bold = 'Bold';
const regular = 'Regular';

ourStyle({family = regular, double? size = 14, color = whitecolor}) {
  return TextStyle(fontFamily: family, fontSize: size, color: color);
}
