import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_component.dart';

class LasserRay extends PositionComponent with CollisionCallbacks, HasGameRef {
  late final Vector2 velocity;
  final Vector2 deltaPosition = Vector2.zero();
  final LasserData data;
  LasserRay({required super.position, required super.angle, required this.data})
      : super(size: Vector2(5, 60), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    final defaulPaint = Paint()
      ..color = data.color
      ..style = PaintingStyle.fill;
    add(RectangleHitbox()
      ..paint = defaulPaint
      ..renderShape = true);
    velocity = Vector2(0, -1)
      ..rotate(angle)
      ..scale(data.baseProjectileSpeed);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyComponent) {
      other.takeDamageFrom(data.lasserColor);
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    deltaPosition.setFrom(velocity);
    position += deltaPosition;
    if (position.y < 0 ||
        position.x > gameRef.size.x ||
        position.x + size.x < 0 ||
        position.y + size.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
