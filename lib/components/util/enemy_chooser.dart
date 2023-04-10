import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';

enum EnemyChooserType { nearest, farest, first, last }

extension EnemyChooser on List<EnemyComponent> {
  Vector2? nearestTo(Vector2 position, {double? maxDistance}) {
    Vector2? nearest;
    if (isEmpty) {
      return null;
    }
    nearest = first.position;
    double nearestDistance = position.distanceTo(nearest);
    for (int i = 1; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      if (aux < nearestDistance) {
        nearestDistance = aux;
        nearest = this[i].position;
      }
    }
    if (maxDistance == null) {
      return nearest;
    }
    if (nearestDistance < maxDistance) {
      return nearest;
    }
    return null;
  }

  Vector2? farestTo(Vector2 position, {required double maxDistance}) {
    Vector2? farest;
    if (isEmpty) {
      return farest;
    }
    double farestDistance = 0;

    for (int i = 0; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      if (aux > farestDistance && aux < maxDistance) {
        farestDistance = aux;
        farest = this[i].position;
      }
    }

    return farest;
  }

  Vector2? firstIn(Vector2 position, {double? maxDistance}) {
    Vector2? firstEnemy;
    if (isEmpty) {
      return firstEnemy;
    }
    for (int i = 0; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      if (maxDistance == null) {
        firstEnemy = this[i].position;
        return firstEnemy;
      }
      if (aux < maxDistance) {
        firstEnemy = this[i].position;
        return firstEnemy;
      }
    }
    return firstEnemy;
  }

  Vector2? lastIn(Vector2 position, {double? maxDistance}) {
    Vector2? lastEnemy;
    if (isEmpty) {
      return lastEnemy;
    }
    for (int i = length - 1; i > 0; i--) {
      double aux = position.distanceTo(this[i].position);
      if (maxDistance == null) {
        lastEnemy = this[i].position;
        return lastEnemy;
      }
      if (aux < maxDistance) {
        lastEnemy = this[i].position;
        return lastEnemy;
      }
    }
    return lastEnemy;
  }
}
