import 'dart:async';

import 'package:flame/components.dart';
import 'package:wavelength_defender/components/lassers/pointers/single_lasser_point.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class DoublePointerLasser extends PositionComponent
    with HasGameRef<WavelengthGame> {
  DoublePointerLasser({required super.size, required super.position})
      : super(anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    gameRef.add(SingleLasserPoint(targetIndex: 0, position: position));
    gameRef.add(SingleLasserPoint(targetIndex: 1, position: position));
    super.onLoad();
  }
}