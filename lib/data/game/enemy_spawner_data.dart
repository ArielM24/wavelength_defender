import 'package:flame/extensions.dart';
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
}
