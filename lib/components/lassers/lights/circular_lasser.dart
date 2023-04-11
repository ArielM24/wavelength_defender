import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/data/lasser_data.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class CircularLasser extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  LasserData data;
  double damage = 0.1;
  late CircleHitbox hitbox;

  bool isHitting = false;
  CircularLasser(
      {required super.position, required super.size, required this.data});
  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = (data.lasserColor.color.withOpacity(0.5))
      ..style = PaintingStyle.fill;
    add(hitbox = CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true);
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      isHitting = true;
      final defaultPaint = Paint()
        ..color = data.lasserColor.color
        ..style = PaintingStyle.fill;
      hitbox.paint = defaultPaint;
      other.takeDamageFrom(data.lasserColor);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is EnemyComponent) {
      final defaultPaint = Paint()
        ..color = (data.lasserColor.color.withOpacity(0.5))
        ..style = PaintingStyle.fill;
      hitbox.paint = defaultPaint;
    }
    super.onCollisionEnd(other);
  }
}
