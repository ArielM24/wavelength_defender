import 'dart:ui';

import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/data/lasser_classes.dart';
import 'package:wavelength_defender/data/lasser_lens_data.dart';

import 'lasser_color.dart';

class LasserData {
  LasserClass lasserClass;
  double fireRate;
  EnemyChooserType chooserType;
  LasserLensData? lensDataR;
  LasserLensData? lensDataG;
  LasserLensData? lensDataB;
  int damageLimit;
  double baseProjectileSpeed;
  double maxDistance;
  double multiplier;

  LasserData(
      {this.lasserClass = LasserClass.s,
      this.lensDataR,
      this.lensDataG,
      this.lensDataB,
      this.fireRate = 1,
      this.multiplier = 1,
      this.maxDistance = 300,
      this.baseProjectileSpeed = 10,
      this.chooserType = EnemyChooserType.nearest})
      : damageLimit = lasserClass.randomValue;

  LasserColor get lasserColor {
    if (lensDataR == null && lensDataG == null && lensDataB == null) {
      return LasserColor.gray;
    }
    int r = 0;
    int g = 0;
    int b = 0;
    int dr = 0;
    int dg = 0;
    int db = 0;
    if (lensDataR != null) {
      r = lensDataR!.channelValue;
      dr = r + lensDataR!.lensClass.rBonus + lensDataR!.lensClass.bonus;
    }
    if (lensDataG != null) {
      g = lensDataG!.channelValue;
      dg = g + lensDataG!.lensClass.gBonus + lensDataG!.lensClass.bonus;
    }
    if (lensDataB != null) {
      b = lensDataB!.channelValue;
      db = b + lensDataB!.lensClass.bBonus + lensDataB!.lensClass.bonus;
    }
    if (lasserClass == LasserClass.x) {
      return LasserColor(
          r: r,
          g: g,
          b: b,
          dr: LasserClass.xDamage,
          dg: LasserClass.xDamage,
          db: LasserClass.xDamage);
    }
    return LasserColor(
        r: r, g: g, b: b, dr: dr, dg: dg, db: db, multiplier: multiplier);
  }

  Color get color => lasserColor.color;
}
