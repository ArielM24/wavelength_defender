import 'dart:async';

import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lassers/pointers/single_lasser_point.dart';
import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/data/lasser_data.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class TriplePointerLasser extends PositionComponent
    with HasGameRef<WavelengthGame> {
  LasserData data;
  TriplePointerLasser(
      {required super.size, required super.position, required this.data})
      : super(anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    gameRef.add(SingleLasserPoint(position: position, size: size, data: data));
    gameRef.add(SingleLasserPoint(position: position, size: size, data: data));
    gameRef.add(SingleLasserPoint(position: position, size: size, data: data));
    // gameRef.add(SingleLasserPoint(
    //     position: position, size: size, chooserType: EnemyChooserType.last));
    //gameRef.add(SingleLasserPoint(position: position, size: size));
    super.onLoad();
  }
}
