import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_spawner.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';

class EnemySpawnerData {
  final double size;
  final Vector2 position;
  final double spawnDelay;
  final bool repeat;
  final bool autoStart;
  final RoadDirection direction;
  final double roadSpeed;
  final Color? color;
  final int? spawnLimit;
  const EnemySpawnerData(
      {this.size = 70,
      required this.position,
      this.spawnDelay = 1,
      this.repeat = true,
      this.spawnLimit,
      this.autoStart = true,
      required this.direction,
      this.roadSpeed = 1,
      this.color});

  EnemySpawner toComponent() => EnemySpawner(
      spawnDelay: spawnDelay,
      repeat: repeat,
      autoStart: autoStart,
      roadSpeed: roadSpeed,
      position: position,
      color: color,
      spawnLimit: spawnLimit,
      size: Vector2.all(size),
      direction: direction);

  Map<String, dynamic> toJson() {
    return {
      "size": size,
      "position_x": position.x,
      "position_y": position.y,
      "spawnDelay": spawnDelay,
      "repeat": repeat,
      "spawnLimit": spawnLimit,
      "autostart": autoStart,
      "direction": direction.index,
      "roadSpeed": roadSpeed,
      "color": color?.value
    };
  }

  factory EnemySpawnerData.fromJson(Map<String, dynamic> json) {
    int direccionIndex = json["direction"] ?? 0;
    double x = json["position_x"] ?? 0;
    double y = json["position_y"] ?? 0;
    int colorValue = json["color"] ?? 0;
    return EnemySpawnerData(
      position: Vector2(x, y),
      direction: RoadDirection.values[direccionIndex],
      color: Color(colorValue),
      size: json["size"] ?? 70,
      spawnDelay: json["spawnDelay"] ?? 1,
      repeat: json["repeat"] ?? true,
      spawnLimit: json["spawnLimit"],
      autoStart: json["autostart"] ?? true,
      roadSpeed: json["roadSpeed"] ?? 1,
    );
  }
}
