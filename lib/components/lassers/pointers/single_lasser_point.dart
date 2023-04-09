import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/components/util/distance_util.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class SingleLasserPoint extends PositionComponent
    with HasGameRef<WavelengthGame> {
  bool isShooting = false;
  late StaticLasserRay ray;
  double maxDistance = 400;

  int targetIndex;
  SingleLasserPoint(
      {required super.position, required super.size, this.targetIndex = 1})
      : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    add(CircleComponent(paint: defaultPaint, radius: size.x / 2)
      ..renderShape = true);
    gameRef.add(
        ray = StaticLasserRay(position: position, targetIndex: targetIndex));

    super.onLoad();
  }

  Vector2? chooseTarget() {
    if (gameRef.enemies.isNotEmpty) {
      Vector2 target = gameRef.enemies.first.position;
      double minDistance = position.distanceTo(target);
      for (int i = 1; i < gameRef.enemies.length; i++) {
        double aux = position.distanceTo(gameRef.enemies[i].position);
        if (aux < minDistance) {
          minDistance = aux;
          target = gameRef.enemies[i].position;
        }
      }
      if (minDistance < maxDistance) {
        return target;
      }
    }
    return null;
  }

  @override
  void update(double dt) {
    Vector2? target =
        gameRef.enemies.nearestTo(position, maxDistance: maxDistance);
    if (target != null) {
      double yDistance = position.distanceTo(target);
      ray.size.y = yDistance;
      ray.lookAt(target);
    } else {
      ray.size.y = 0;
    }
    // if (gameRef.enemies.isNotEmpty && !isShooting) {
    //   isShooting = true;
    //   ray = StaticLasserRay(position: position, targetIndex: targetIndex);
    //   gameRef.add(ray);
    // } else if (gameRef.enemies.isEmpty && isShooting) {
    //   isShooting = false;
    //   gameRef.remove(ray);
    // }
    super.update(dt);
  }
}
