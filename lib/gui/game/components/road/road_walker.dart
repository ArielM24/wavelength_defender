import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';

mixin RoadWalker on PositionComponent {
  RoadDirection? get direction =>
      directions.isNotEmpty ? directions.first : null;
  double currentSpeed = 0;
  List<RoadDirection> directions = [];
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is RoadCell) {
      directions.add(other.direction);
      currentSpeed = other.roadSpeed;
    }
  }

  void onCollisionEnd(PositionComponent other) {
    if (other is RoadCell) {
      directions.removeAt(0);
    }
  }

  @override
  void update(double dt) {
    switch (direction) {
      case RoadDirection.top:
        position.y -= currentSpeed;
        break;
      case RoadDirection.bottom:
        position.y += currentSpeed;
        break;
      case RoadDirection.left:
        position.x -= currentSpeed;
        break;
      case RoadDirection.right:
        position.x += currentSpeed;
        break;
      default:
    }

    super.update(dt);
  }
}
