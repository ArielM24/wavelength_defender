import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemyComponent extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  static const speed = 0.5;
  double life;
  double dx, dy;
  bool hasCrashed = false;
  EnemyComponent({this.life = 20, this.dx = 0, this.dy = 0})
      : super(
            position: Vector2(1200 + dx, 150 + dy),
            size: Vector2.all(50),
            anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    add(CircleHitbox()
      ..collisionType = CollisionType.passive
      ..renderShape = true
      ..paint = defaultPaint);

    super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x > size.x) {
      position.x -= speed;
    } else if (!hasCrashed) {
      hasCrashed = true;
      gameRef.crashes++;
    }

    super.update(dt);
  }

  takeHit(double damage) {
    life -= damage;
    if (life <= 0) {
      removeFromParent();
      gameRef.increaseScore();
      gameRef.enemies.remove(this);
    }
  }
}
