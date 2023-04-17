import 'dart:ui';

import 'package:flame/components.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';

class RoadCellData {
  final RoadDirection direction;
  final double roadSpeed;
  final Color? color;
  final double size;
  final Vector2 position;

  const RoadCellData(
      {required this.direction,
      this.roadSpeed = 1,
      this.color,
      required this.position,
      this.size = 70});

  RoadCell toComponent() => RoadCell(
      roadSpeed: roadSpeed,
      color: color,
      position: position,
      direction: direction,
      size: Vector2.all(size));
}
