import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum RoadDirection { left, right, top, bottom }

class RoadCell extends RectangleComponent {
  RoadDirection direction;
  RoadCell(
      {this.direction = RoadDirection.left,
      required super.position,
      required super.size})
      : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    final indicator = RectangleComponent(size: Vector2.all(size.x * 0.1));
    indicator.position = getIndicatorPosition();
    add(RectangleHitbox(isSolid: true));
    add(indicator);
    super.onLoad();
  }

  double get indicatorSize => size.x * 0.1;

  Vector2 getIndicatorPosition() {
    Vector2 indicatorPosition = Vector2(0, 0);
    switch (direction) {
      case RoadDirection.left:
        indicatorPosition.y = (size.y / 2) - (indicatorSize / 2);
        break;
      case RoadDirection.right:
        indicatorPosition.y = size.y / 2 - (indicatorSize / 2);
        indicatorPosition.x = size.x - (indicatorSize);
        break;
      case RoadDirection.top:
        indicatorPosition.x = size.x / 2 - (indicatorSize / 2);
        break;
      case RoadDirection.bottom:
        indicatorPosition.y = size.y - (indicatorSize);
        indicatorPosition.x = size.x / 2 - (indicatorSize / 2);
        break;
      default:
    }
    return indicatorPosition;
  }
}
