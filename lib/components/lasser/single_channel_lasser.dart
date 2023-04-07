import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/components/lasser/ray/lasser_ray.dart';

class SingleChannelLasser extends PositionComponent with HasGameRef {
  late TimerComponent lasserCreator;
  bool isShooting = false;
  int shoots = 0;
  SingleChannelLasser()
      : super(
            size: Vector2(50, 50),
            position: Vector2(700, 600),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    final defaultPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;
    final polygon = PolygonComponent.relative([
      Vector2(0, -1),
      Vector2(1, 1),
      Vector2(-1, 1),
    ], paint: defaultPaint, parentSize: size);

    add(polygon);

    add(lasserCreator = TimerComponent(
        period: 1, repeat: true, autoStart: false, onTick: shootLasser));
    super.onLoad();
  }

  shootLasser() {
    shoots++;
    gameRef.add(
        LasserRay(position: position + Vector2(0, -size.y / 2), angle: angle));
  }

  startShootingLasser() {
    isShooting = true;
    lasserCreator.timer.resume();
  }

  stopShootingLasser() {
    isShooting = false;
    lasserCreator.timer.pause();
    add(
      RotateEffect.to(0, LinearEffectController(1)),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // if (shoots > 5) {
    //   stopShootingLasser();
    // }
  }
}
