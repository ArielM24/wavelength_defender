import 'package:flame/components.dart';

import 'lasser_gun.dart';
import '../rays/lasser_ray.dart';

class DoubleChannelLasser extends LasserGun {
  DoubleChannelLasser(
      {required super.position,
      required super.size,
      required super.color,
      required super.chooserType})
      : super(shape: RectangleComponent());

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
