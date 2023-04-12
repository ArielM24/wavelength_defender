import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_object.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/components/road/road_cell.dart';
import 'package:wavelength_defender/components/road/road_walker.dart';
import 'package:wavelength_defender/data/lasser_color.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemyComponent extends PositionComponent
    with HasGameRef<WavelengthGame>, CollisionCallbacks, RoadWalker {
  static const speed = 0.5;
  double life;
  double dx, dy;
  double xp, yp;
  bool hasCrashed = false;
  late CircleHitbox hitbox;
  LasserColor color;
  EnemyComponent({
    this.life = 1024,
    this.dx = 0,
    this.dy = 0,
    required this.xp,
    required this.yp,
    required this.color,
  }) : super(
            position: Vector2(xp + dx, yp + dy),
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
    bool outOfScreen = position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > game.size.y;
    if (outOfScreen && !hasCrashed) {
      crash();
    }
    super.update(dt);
  }

  crash() {
    hasCrashed = true;
    gameRef.crashes++;
    removeFromParent();
    gameRef.enemies.remove(this);
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
    double damage = other.damageTo(color);
    //debugPrint("$damage $other");
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
    } else if (other is EnemyObject) {
      crash();
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
