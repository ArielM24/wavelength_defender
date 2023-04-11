import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lassers/rays/lasser_ray.dart';
import 'package:wavelength_defender/data/lasser_data.dart';

import 'lasser_gun.dart';

class SingleChannelLasser extends LasserGun {
  SingleChannelLasser(
      {required super.position, required super.size, required super.data})
      : super(
            shape: PolygonComponent.relative([
          Vector2(0, -1),
          Vector2(1, 1),
          Vector2(-1, 1),
        ], parentSize: size!));

  @override
  shootLasser() {
    gameRef.add(LasserRay(position: position, angle: angle, data: data));
  }
}
