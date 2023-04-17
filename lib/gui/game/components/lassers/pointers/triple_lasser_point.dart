import 'dart:async';

import 'package:flame/components.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/gui/game/components/lassers/pointers/single_lasser_point.dart';
import 'package:wavelength_defender/gui/game/components/extensions/enemy_chooser.dart';
import 'package:wavelength_defender/gui/game/wavelength_game.dart';

class TriplePointerLasser extends PositionComponent
    with HasGameRef<WavelengthGame> {
  LasserData data;
  TriplePointerLasser({required this.data})
      : super(
            anchor: Anchor.center,
            position: data.position,
            size: Vector2.all(data.size));
  @override
  FutureOr<void> onLoad() {
    gameRef.add(SingleLasserPoint(data: data));
    gameRef.add(SingleLasserPoint(data: data));
    gameRef.add(SingleLasserPoint(data: data));
    // gameRef.add(SingleLasserPoint(
    //     position: position, size: size, chooserType: EnemyChooserType.last));
    //gameRef.add(SingleLasserPoint(position: position, size: size));
    super.onLoad();
  }
}
