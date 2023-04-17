import 'package:flame/components.dart';
import 'package:wavelength_defender/gui/game/components/lassers/rays/lasser_ray.dart';

import 'lasser_gun.dart';

class SingleChannelLasser extends LasserGun {
  SingleChannelLasser({required super.data})
      : super(
            shape: PolygonComponent.relative([
          Vector2(0, -1),
          Vector2(1, 1),
          Vector2(-1, 1),
        ], parentSize: Vector2.all(data.size)));

  @override
  shootLasser() {
    gameRef.add(LasserRay(position: position, angle: angle, data: data));
  }
}
