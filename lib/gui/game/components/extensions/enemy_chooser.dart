import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_component.dart';

enum EnemyChooserType { nearest, farest, first, last, lowest, higher }

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

  Vector2? farestTo(Vector2 position, {double? maxDistance}) {
    Vector2? farest;
    if (isEmpty) {
      return farest;
    }
    double farestDistance = 0;

    for (int i = 0; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      if (aux > farestDistance && aux < (maxDistance ?? double.infinity)) {
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

  Vector2? lowestLife(Vector2 position, {double? maxDistance}) {
    Vector2? lowest;
    if (isEmpty) {
      return lowest;
    }
    double lowestLifeValue = double.infinity;
    for (int i = 0; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      double auxLife = this[i].life;
      if (maxDistance == null && auxLife < lowestLifeValue) {
        lowest = this[i].position;
        lowestLifeValue = auxLife;
        continue;
      }
      if (aux < (maxDistance ?? double.infinity) && auxLife < lowestLifeValue) {
        lowest = this[i].position;
        lowestLifeValue = auxLife;
      }
    }
    return lowest;
  }

  Vector2? higherLife(Vector2 position, {double? maxDistance}) {
    Vector2? higher;
    if (isEmpty) {
      return higher;
    }
    double highestLifeValue = 0;
    for (int i = 0; i < length; i++) {
      double aux = position.distanceTo(this[i].position);
      double auxLife = this[i].life;
      if (maxDistance == null && auxLife > highestLifeValue) {
        higher = this[i].position;
        highestLifeValue = auxLife;
        continue;
      }
      if (aux < (maxDistance ?? double.infinity) &&
          auxLife > highestLifeValue) {
        higher = this[i].position;
        highestLifeValue = auxLife;
      }
    }
    return higher;
  }
}
