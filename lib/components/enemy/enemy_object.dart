import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemyObject extends PositionComponent with HasGameRef<WavelengthGame> {
  EnemyObject({required super.size, required super.position})
      : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    add(RectangleHitbox(isSolid: true)
      ..paint = paint
      ..renderShape = true);
    super.onLoad();
  }
}
