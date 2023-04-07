import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';

class LasserRay extends PositionComponent with CollisionCallbacks, HasGameRef {
  double speed = 10;
  double damage;
  late final Vector2 velocity;
  final Vector2 deltaPosition = Vector2.zero();
  LasserRay({required super.position, required super.angle, this.damage = 10})
      : super(size: Vector2(5, 60));

  @override
  FutureOr<void> onLoad() {
    final defaulPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;
    add(RectangleHitbox()
      ..paint = defaulPaint
      ..renderShape = true);
    velocity = Vector2(0, -1)
      ..rotate(angle)
      ..scale(speed);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyComponent) {
      other.takeHit(damage);
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    deltaPosition.setFrom(velocity);
    position += deltaPosition;
    // debugPrint("$position");
    if (position.y < 0 ||
        position.x > gameRef.size.x ||
        position.x + size.x < 0 ||
        position.y + size.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
