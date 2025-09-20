import 'package:flutter/material.dart';

String convertRgboHex(Color color) {
  return '#${((color.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((color.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((color.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex.substring(1), radix: 16));
}
