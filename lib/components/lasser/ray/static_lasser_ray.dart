import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class StaticLasserRay extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  double maxDistance = 400;
  double damage = 0.1;
  late RectangleHitbox hitbox;
  bool printed = false;
  final defualtPaint = Paint()
    ..color = Colors.yellow
    ..style = PaintingStyle.fill;
  StaticLasserRay({required super.position})
      : super(anchor: Anchor.bottomCenter);

  @override
  FutureOr<void> onLoad() {
    add(hitbox = RectangleHitbox()
      ..renderShape = true
      ..collisionType = CollisionType.active
      ..paint = defualtPaint);
    size.x = 5;
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (gameRef.enemies.isNotEmpty) {
      final target = gameRef.enemies.first;
      double yDistance = position.distanceTo(target.position);
      if (yDistance <= maxDistance) {
        size.y = yDistance;
      } else {
        size.y = 0;
      }
      lookAt(target.position);
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      other.takeHit(damage);
    }
    super.onCollision(intersectionPoints, other);
  }
}
