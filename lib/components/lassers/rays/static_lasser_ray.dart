import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/data/lasser_data.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class StaticLasserRay extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  late RectangleHitbox hitbox;
  bool printed = false;
  LasserData data;
  StaticLasserRay({required super.position, required this.data})
      : super(anchor: Anchor.bottomCenter);

  @override
  FutureOr<void> onLoad() {
    final defualtPaint = Paint()
      ..color = data.color
      ..style = PaintingStyle.fill;
    add(hitbox = RectangleHitbox()
      ..renderShape = true
      ..collisionType = CollisionType.active
      ..paint = defualtPaint);
    size.x = 5;
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      other.takeDamageFrom(data.lasserColor);
    }
    super.onCollision(intersectionPoints, other);
  }
}
