import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class SingleLasserPoint extends PositionComponent
    with HasGameRef<WavelengthGame> {
  bool isShooting = false;
  late StaticLasserRay ray;
  int targetIndex;
  SingleLasserPoint({super.position, this.targetIndex = 1})
      : super(anchor: Anchor.center, size: Vector2(50, 50));

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    add(CircleComponent(paint: defaultPaint, radius: size.x / 2)
      ..renderShape = true);
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (gameRef.enemies.isNotEmpty && !isShooting) {
      isShooting = true;
      ray = StaticLasserRay(position: position, targetIndex: targetIndex);
      gameRef.add(ray);
    } else if (gameRef.enemies.isEmpty && isShooting) {
      isShooting = false;
      gameRef.remove(ray);
    }
    super.update(dt);
  }
}
