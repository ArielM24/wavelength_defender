import 'package:flame/components.dart';

import 'lasser_gun.dart';
import '../rays/lasser_ray.dart';

class TripleShootLasser extends LasserGun {
  TripleShootLasser({
    required super.position,
    required super.size,
    required super.color,
  }) : super(shape: RectangleComponent());

  @override
  void shootLasser() {
    gameRef.add(LasserRay(
        position: Vector2(center.x + size.x / 2, center.y),
        angle: angle,
        color: color));
    gameRef.add(LasserRay(
        position: Vector2(center.x, center.y + size.y / 2),
        angle: angle,
        color: color));
    gameRef.add(LasserRay(
        position: Vector2(center.x - size.x / 2, center.y),
        angle: angle,
        color: color));
  }
}
