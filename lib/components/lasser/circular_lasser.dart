import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class CircularLasser extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  double damage = 0.1;
  CircularLasser() : super(position: Vector2(300, 200));
  @override
  FutureOr<void> onLoad() {
    size = Vector2(200, 200);
    final defaultPaint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    add(CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true);
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      other.takeHit(damage);
    }
    super.onCollision(intersectionPoints, other);
  }
}
