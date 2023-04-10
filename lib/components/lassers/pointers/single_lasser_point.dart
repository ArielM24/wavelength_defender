import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class SingleLasserPoint extends PositionComponent
    with HasGameRef<WavelengthGame> {
  bool isShooting = false;
  late StaticLasserRay ray;
  double maxDistance = 400;
  EnemyChooserType chooserType;

  SingleLasserPoint(
      {required super.position, required super.size, required this.chooserType})
      : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    add(CircleComponent(paint: defaultPaint, radius: size.x / 2)
      ..renderShape = true);
    gameRef.add(ray = StaticLasserRay(position: position));

    super.onLoad();
  }

  @override
  void update(double dt) {
    Vector2? target;
    switch (chooserType) {
      case EnemyChooserType.nearest:
        target = gameRef.enemies.nearestTo(position, maxDistance: maxDistance);
        break;
      case EnemyChooserType.farest:
        target = gameRef.enemies.farestTo(position, maxDistance: maxDistance);
        break;
      case EnemyChooserType.first:
        target = gameRef.enemies.firstIn(position, maxDistance: maxDistance);
        break;
      case EnemyChooserType.last:
        target = gameRef.enemies.lastIn(position, maxDistance: maxDistance);
        break;
      case EnemyChooserType.lowest:
        target = gameRef.enemies.lowestLife(position, maxDistance: maxDistance);
        break;
      case EnemyChooserType.higher:
        target = gameRef.enemies.higherLife(position, maxDistance: maxDistance);
        break;
      default:
    }

    if (target != null) {
      double yDistance = position.distanceTo(target);
      ray.size.y = yDistance;
      ray.lookAt(target);
    } else {
      ray.size.y = 0;
    }
    super.update(dt);
  }
}
