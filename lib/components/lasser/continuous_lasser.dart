import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lasser/ray/static_lasser_ray.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class ContinuousLasser extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  bool isShooting = false;
  late StaticLasserRay ray;
  ContinuousLasser({super.position})
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
      ray = StaticLasserRay(origin: position, parentSize: size);
      add(ray);
    } else if (gameRef.enemies.isEmpty && isShooting) {
      isShooting = false;
      remove(ray);
    }
    super.update(dt);
  }
}
