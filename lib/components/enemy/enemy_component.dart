import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemyComponent extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks {
  static const speed = 1.5;
  double life;
  double dx, dy;
  bool hasCrashed = false;
  late CircleHitbox hitbox;
  EnemyComponent({this.life = 100, this.dx = 0, this.dy = 0})
      : super(
            position: Vector2(1200 + dx, 150 + dy),
            size: Vector2.all(50),
            anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is StaticLasserRay) {
      final defaultPaint = Paint()
        ..color = Colors.grey.withAlpha(150)
        ..style = PaintingStyle.stroke;
      hitbox.paint = defaultPaint;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is StaticLasserRay) {
      final defaultPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke;
      hitbox.paint = defaultPaint;
    }
    super.onCollisionEnd(other);
  }
}
