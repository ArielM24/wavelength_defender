import 'dart:ui';

import 'package:flutter/foundation.dart';

class LasserColor {
  final int r, g, b;
  final int dr, dg, db;
  final double multiplier;
  const LasserColor(
      {required this.r,
      required this.g,
      required this.b,
      required this.dr,
      required this.dg,
      this.multiplier = 1,
      required this.db});

  double damageTo(LasserColor color) {
    int damage = 0;
    if (color.r == 0) {
      damage += dr;
    } else {
      damage += (dr / 3).round();
    }
    if (color.g == 0) {
      damage += dg;
    } else {
      damage += (dg / 3).round();
    }
    if (color.b == 0) {
      damage += db;
    } else {
      damage += (db / 3).round();
    }
    return (damage / 3) * multiplier;
  }

  static const LasserColor red =
      LasserColor(r: 255, g: 0, b: 0, dr: 0, dg: 0, db: 0);
  static const LasserColor green =
      LasserColor(r: 0, g: 255, b: 0, dr: 0, dg: 0, db: 0);
  static const LasserColor blue =
      LasserColor(r: 0, g: 0, b: 255, dr: 0, dg: 0, db: 0);
  static const LasserColor gray =
      LasserColor(r: 100, g: 100, b: 100, dr: 0, dg: 0, db: 0, multiplier: 0);

  Color get color => Color.fromARGB(255, r, g, b);

  @override
  String toString() {
    return "[$r,$g,$b][$dr,$dg,$db]x$multiplier";
  }
}
