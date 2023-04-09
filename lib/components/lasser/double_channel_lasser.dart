import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lasser/lasser_gun.dart';

import 'ray/lasser_ray.dart';

class DoubleChannelLasser extends LasserGun {
  DoubleChannelLasser({
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
        position: Vector2(center.x - size.x / 2, center.y),
        angle: angle,
        color: color));
  }
}
