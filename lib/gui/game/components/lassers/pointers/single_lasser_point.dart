import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/gui/game/components/lassers/rays/static_lasser_ray.dart';
import 'package:wavelength_defender/gui/game/components/extensions/enemy_chooser.dart';
import 'package:wavelength_defender/gui/game/wavelength_game.dart';

class SingleLasserPoint extends PositionComponent
    with HasGameRef<WavelengthGame> {
  bool isShooting = false;
  late StaticLasserRay ray;
  LasserData data;

  SingleLasserPoint({required this.data})
      : super(
            anchor: Anchor.center,
            position: data.position,
            size: Vector2.all(data.size));

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = data.color
      ..style = PaintingStyle.fill;
    add(CircleComponent(paint: defaultPaint, radius: size.x / 2)
      ..renderShape = true);
    gameRef.add(ray = StaticLasserRay(position: position, data: data));

    super.onLoad();
  }

  getTarget() {
    Vector2? target;
    switch (data.chooserType) {
      case EnemyChooserType.nearest:
        target =
            gameRef.enemies.nearestTo(position, maxDistance: data.maxDistance);
        break;
      case EnemyChooserType.farest:
        target =
            gameRef.enemies.farestTo(position, maxDistance: data.maxDistance);
        break;
      case EnemyChooserType.first:
        target =
            gameRef.enemies.firstIn(position, maxDistance: data.maxDistance);
        break;
      case EnemyChooserType.last:
        target =
            gameRef.enemies.lastIn(position, maxDistance: data.maxDistance);
        break;
      case EnemyChooserType.lowest:
        target =
            gameRef.enemies.lowestLife(position, maxDistance: data.maxDistance);
        break;
      case EnemyChooserType.higher:
        target =
            gameRef.enemies.higherLife(position, maxDistance: data.maxDistance);
        break;
      default:
    }
    return target;
  }

  @override
  void update(double dt) {
    final target = getTarget();
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
