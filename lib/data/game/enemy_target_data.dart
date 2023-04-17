import 'package:flame/components.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_target.dart';

class EnemyTargetData {
  final double size;
  final Vector2 position;
  const EnemyTargetData({this.size = 70, required this.position});

  EnemyTarget toComponent() =>
      EnemyTarget(position: position, size: Vector2.all(size));
}
