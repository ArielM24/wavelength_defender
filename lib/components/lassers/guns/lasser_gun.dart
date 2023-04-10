import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/wavelength_game.dart';

abstract class LasserGun extends PositionComponent
    with HasGameRef<WavelengthGame> {
  Color color;
  late TimerComponent lasserCreator;
  bool isShooting = false;
  ShapeComponent shape;
  Vector2? tagret;
  EnemyChooserType chooserType;
  LasserGun(
      {required super.position,
      required super.size,
      required this.color,
      required this.shape,
      required this.chooserType})
      : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    shape.paint = Paint()..color = color;
    shape.size = size;
    add(shape);
    add(lasserCreator = TimerComponent(
        period: 1, repeat: true, autoStart: false, onTick: shootLasser));
  }

  startShootingLasser() {
    isShooting = true;
    lasserCreator.timer.resume();
  }

  stopShootingLasser() {
    isShooting = false;
    lasserCreator.timer.pause();
    add(RotateEffect.to(0, LinearEffectController(1)));
  }

  getTarget() {
    Vector2? target;
    switch (chooserType) {
      case EnemyChooserType.nearest:
        target = gameRef.enemies.nearestTo(position);
        break;
      case EnemyChooserType.farest:
        target = gameRef.enemies.farestTo(position);
        break;
      case EnemyChooserType.first:
        target = gameRef.enemies.firstIn(position);
        break;
      case EnemyChooserType.last:
        target = gameRef.enemies.lastIn(position);
        break;
      case EnemyChooserType.lowest:
        target = gameRef.enemies.lowestLife(position);
        break;
      case EnemyChooserType.higher:
        target = gameRef.enemies.higherLife(position);
        break;
      default:
    }
    return target;
  }

  void shootLasser();

  @override
  void update(double dt) {
    final target = getTarget();
    if (target != null) {
      lookAt(target);
    }
    if (target == null && isShooting) {
      stopShootingLasser();
    } else if (target != null && !isShooting) {
      startShootingLasser();
      add(RotateEffect.to(
        angleTo(target),
        LinearEffectController(1),
      ));
    }
    super.update(dt);
  }
}
