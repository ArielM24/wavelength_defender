import 'package:flame/components.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_target.dart';

class EnemyTargetData {
  final double size;
  final Vector2 position;
  const EnemyTargetData({this.size = 70, required this.position});

  EnemyTarget toComponent() =>
      EnemyTarget(position: position, size: Vector2.all(size));

  Map<String, dynamic> toJson() {
    return {
      "size": size,
      "position_x": position.x,
      "position_y": position.y,
    };
  }

  factory EnemyTargetData.fromJson(Map<String, dynamic> json) {
    double x = json["position_x"] ?? 0;
    double y = json["position_y"] ?? 0;
    return EnemyTargetData(
      size: json["size"] ?? 70,
      position: Vector2(x, y),
    );
  }
}
