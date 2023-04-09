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
  int targetIndex;
  //Vector2 target;
  final defualtPaint = Paint()
    ..color = Colors.yellow
    ..style = PaintingStyle.fill;
  StaticLasserRay({required super.position, this.targetIndex = 0})
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
    // double yDistance = position.distanceTo(target);
    // size.y = yDistance;
    // lookAt(target);
    // if (gameRef.enemies.isNotEmpty) {
    //   bool useIndex = gameRef.enemies.length > targetIndex;
    //   final target = gameRef.enemies[useIndex ? targetIndex : 0];
    //   double yDistance = position.distanceTo(target.position);
    //   if (yDistance <= maxDistance) {
    //     size.y = yDistance;
    //   } else {
    //     size.y = 0;
    //   }
    //   lookAt(target.position);
    // }
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
