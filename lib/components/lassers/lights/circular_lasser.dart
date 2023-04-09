import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class CircularLasser extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  double damage = 0.1;
  late CircleHitbox hitbox;
  final defaultPaint = Paint()
    ..color = Colors.green.withOpacity(0.5)
    ..style = PaintingStyle.fill;
  bool isHitting = false;
  CircularLasser({required super.position, required super.size});
  @override
  FutureOr<void> onLoad() {
    add(hitbox = CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true);
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      isHitting = true;
      final paint = Paint()
        ..color = Colors.green.withOpacity(0.8)
        ..style = PaintingStyle.fill;
      hitbox.paint = paint;
      other.takeHit(damage);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is EnemyComponent) {
      hitbox.paint = defaultPaint;
    }
    super.onCollisionEnd(other);
  }
}
