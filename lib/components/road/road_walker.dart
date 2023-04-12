import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/components/road/road_cell.dart';

mixin RoadWalker on PositionComponent {
  RoadDirection? get direction =>
      directions.isNotEmpty ? directions.first : null;
  List<RoadDirection> directions = [];
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is RoadCell) {
      directions.add(other.direction);
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
        position.y--;
        break;
      case RoadDirection.bottom:
        position.y++;
        break;
      case RoadDirection.left:
        position.x--;
        break;
      case RoadDirection.right:
        position.x++;
        break;
      default:
    }

    super.update(dt);
  }
}
