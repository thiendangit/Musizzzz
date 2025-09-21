import 'package:flutter/material.dart';

String convertRgboHex(Color color) {
  return '#${((color.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((color.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((color.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex.substring(1), radix: 16));
}

Color parseColorObjectString(String colorString) {
  try {
    // Parse Color object string format: "Color(alpha: 1.0000, red: 0.6118, green: 0.1529, blue: 0.6902, colorSpace: ColorSpace.sRGB)"
    final regex = RegExp(r'red: ([\d.]+), green: ([\d.]+), blue: ([\d.]+)');
    final match = regex.firstMatch(colorString);
    if (match != null) {
      final red = (double.parse(match.group(1)!) * 255).round();
      final green = (double.parse(match.group(2)!) * 255).round();
      final blue = (double.parse(match.group(3)!) * 255).round();
      return Color.fromRGBO(red, green, blue, 1.0);
    } else {
      return Colors.purple; // Fallback
    }
  } catch (e) {
    return Colors.purple; // Fallback
  }
}
