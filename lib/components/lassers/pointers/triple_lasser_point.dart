import 'dart:async';

import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lassers/pointers/single_lasser_point.dart';
import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class TriplePointerLasser extends PositionComponent
    with HasGameRef<WavelengthGame> {
  TriplePointerLasser({required super.size, required super.position})
      : super(anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    gameRef.add(SingleLasserPoint(
        position: position, size: size, chooserType: EnemyChooserType.nearest));
    gameRef.add(SingleLasserPoint(
        position: position, size: size, chooserType: EnemyChooserType.farest));
    gameRef.add(SingleLasserPoint(
        position: position, size: size, chooserType: EnemyChooserType.first));
    // gameRef.add(SingleLasserPoint(
    //     position: position, size: size, chooserType: EnemyChooserType.last));
    //gameRef.add(SingleLasserPoint(position: position, size: size));
    super.onLoad();
  }
}
