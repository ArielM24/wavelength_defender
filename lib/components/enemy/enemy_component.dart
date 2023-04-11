import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/data/lasser_color.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemyComponent extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  static const speed = 0.5;
  double life;
  double dx, dy;
  bool hasCrashed = false;
  late CircleHitbox hitbox;
  LasserColor color;
  EnemyComponent(
      {this.life = 1024, this.dx = 0, this.dy = 0, required this.color})
      : super(
            position: Vector2(1200 + dx, 150 + dy),
            size: Vector2.all(50),
            anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Color.fromARGB(155, color.r, color.g, color.b)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    add(hitbox = CircleHitbox(isSolid: true)
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
      removeFromParent();
      gameRef.enemies.remove(this);
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

  takeDamageFrom(LasserColor other) {
    double damage = other.damageTo(color, multiplier: 0.1);
    debugPrint("$damage");
    life -= damage;
    if (life <= 0) {
      removeFromParent();
      gameRef.increaseScore();
      gameRef.enemies.remove(this);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is StaticLasserRay) {
      final defaultPaint = Paint()
        ..color = Color.fromARGB(255, color.r, color.g, color.b)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      hitbox.paint = defaultPaint;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is StaticLasserRay) {
      final defaultPaint = Paint()
        ..color = Color.fromARGB(155, color.r, color.g, color.b)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      hitbox.paint = defaultPaint;
    }
    super.onCollisionEnd(other);
  }
}
