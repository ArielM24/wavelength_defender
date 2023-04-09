import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lasser/lasser_gun.dart';
import 'package:wavelength_defender/components/lasser/ray/lasser_ray.dart';

class SingleChannelLasser extends LasserGun {
  SingleChannelLasser(
      {super.position, required super.size, required super.color})
      : super(
            shape: PolygonComponent.relative([
          Vector2(0, -1),
          Vector2(1, 1),
          Vector2(-1, 1),
        ], parentSize: size!));

  @override
  shootLasser() {
    gameRef.add(LasserRay(position: position, angle: angle, color: color));
  }
}
