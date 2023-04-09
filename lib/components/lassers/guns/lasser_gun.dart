import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/wavelength_game.dart';

abstract class LasserGun extends PositionComponent
    with HasGameRef<WavelengthGame> {
  Color color;
  late TimerComponent lasserCreator;
  bool isShooting = false;
  ShapeComponent shape;
  LasserGun(
      {required super.position,
      required super.size,
      required this.color,
      required this.shape})
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

  void shootLasser();

  @override
  void update(double dt) {
    if (gameRef.enemies.isNotEmpty) {
      lookAt(gameRef.enemies.first.position);
    }
    if (gameRef.enemies.isEmpty && isShooting) {
      stopShootingLasser();
    } else if (gameRef.enemies.isNotEmpty && !isShooting) {
      startShootingLasser();
      add(RotateEffect.to(
        angleTo(gameRef.enemies.first.absolutePosition),
        LinearEffectController(1),
      ));
    }
    super.update(dt);
  }
}
