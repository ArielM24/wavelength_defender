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

  Map<String, dynamic> toJson() {
    return {
      "direction": direction.index,
      "roadSpeed": roadSpeed,
      "color": color?.value,
      "size": size,
      "position_x": position.x,
      "position_y": position.y,
    };
  }

  factory RoadCellData.fromJson(Map<String, dynamic> json) {
    int direccionIndex = json["direction"] ?? 0;
    double x = json["position_x"] ?? 0;
    double y = json["position_y"] ?? 0;
    int colorValue = json["color"] ?? 0;
    return RoadCellData(
      direction: RoadDirection.values[direccionIndex],
      position: Vector2(x, y),
      color: json["color"] != null ? Color(colorValue) : null,
      size: json["size"] ?? 70,
    );
  }
}
