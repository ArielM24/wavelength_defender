import 'dart:ui';

import 'package:flame/components.dart';
import 'package:wavelength_defender/gui/game/components/extensions/enemy_chooser.dart';
import 'package:wavelength_defender/data/game/lasser_classes.dart';
import 'package:wavelength_defender/gui/game/components/lassers/guns/double_channel_lasser.dart';
import 'package:wavelength_defender/gui/game/components/lassers/guns/lasser_gun.dart';
import 'package:wavelength_defender/gui/game/components/lassers/guns/single_channel_lasser.dart';
import 'package:wavelength_defender/gui/game/components/lassers/guns/triple_shoot_lasser.dart';
import 'package:wavelength_defender/gui/game/components/lassers/lights/circular_lasser.dart';
import 'package:wavelength_defender/gui/game/components/lassers/pointers/single_lasser_point.dart';

import 'lasser_color.dart';
import 'lasser_lens_data.dart';

enum LasserType { single, double, triple, area, pointer }

class LasserData {
  LasserType type;
  LasserClass lasserClass;
  double fireRate;
  EnemyChooserType chooserType;
  EnemyChooserType? chooserType2;
  EnemyChooserType? chooserType3;
  LasserLensData? lensDataR;
  LasserLensData? lensDataG;
  LasserLensData? lensDataB;
  int damageLimit;
  double baseProjectileSpeed;
  double maxDistance;
  double multiplier;
  Vector2 position;
  double size;

  LasserData(
      {this.lasserClass = LasserClass.s,
      required this.type,
      this.lensDataR,
      this.lensDataG,
      this.lensDataB,
      required this.position,
      this.fireRate = 1,
      this.multiplier = 1,
      this.maxDistance = 300,
      this.baseProjectileSpeed = 10,
      this.chooserType2,
      this.chooserType3,
      int? useDamageLimit,
      this.size = 50,
      this.chooserType = EnemyChooserType.nearest})
      : damageLimit = useDamageLimit ?? lasserClass.randomValue;

  LasserData copyWith(
      {LasserClass? lasserClass,
      double? fireRate,
      EnemyChooserType? chooserType,
      EnemyChooserType? chooserType2,
      EnemyChooserType? chooserType3,
      LasserLensData? lensDataR,
      LasserLensData? lensDataG,
      LasserLensData? lensDataB,
      int? damageLimit,
      double? baseProjectileSpeed,
      LasserType? type,
      double? size,
      Vector2? position,
      double? maxDistance,
      double? multiplier}) {
    return LasserData(
        position: position ?? this.position,
        type: type ?? this.type,
        size: size ?? this.size,
        lasserClass: lasserClass ?? this.lasserClass,
        useDamageLimit: lasserClass == this.lasserClass ? damageLimit : null,
        fireRate: fireRate ?? this.fireRate,
        chooserType: chooserType ?? this.chooserType,
        chooserType2: chooserType2 ?? this.chooserType2,
        chooserType3: chooserType3 ?? this.chooserType3,
        lensDataR: lensDataR ?? this.lensDataR,
        lensDataG: lensDataG ?? this.lensDataG,
        lensDataB: lensDataB ?? this.lensDataB,
        baseProjectileSpeed: baseProjectileSpeed ?? this.baseProjectileSpeed,
        maxDistance: maxDistance ?? this.maxDistance,
        multiplier: multiplier ?? this.multiplier);
  }

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

  Component toComponent() {
    switch (type) {
      case LasserType.area:
        return CircularLasser(data: this);
      case LasserType.pointer:
        return SingleLasserPoint(data: this);
      case LasserType.single:
        return SingleChannelLasser(data: this);
      case LasserType.double:
        return DoubleChannelLasser(data: this);
      case LasserType.triple:
        return TripleShootLasser(data: this);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "size": size,
      "position_x": position.x,
      "position_y": position.y,
      "damageLimit": damageLimit,
      "baseProjectileSpeed": baseProjectileSpeed,
      "maxDistance": maxDistance,
      "multiplier": multiplier,
      "type": type.index,
      "lasserClass": lasserClass.index,
      "fireRate": fireRate,
      "chooserType": chooserType.index,
      "chooserType2": chooserType2?.index,
      "chooserType3": chooserType3?.index,
      "lensDataR": lensDataR?.toJson(),
      "lensDataG": lensDataG?.toJson(),
      "lensDataB": lensDataB?.toJson(),
    };
  }

  factory LasserData.fromJson(Map<String, dynamic> json) {
    int typeIndex = json["type"] ?? 0;
    int classIndex = json["lasserClass"] ?? 0;
    double x = json["position_x"] ?? 0;
    double y = json["position_y"] ?? 0;
    int chooserIndex = json["chooserType"] ?? 0;
    int chooser2Index = json["chooserType2"] ?? 0;
    int chooser3Index = json["chooserType3"] ?? 0;
    return LasserData(
      type: LasserType.values[typeIndex],
      position: Vector2(x, y),
      size: json["size"] ?? 50,
      maxDistance: json["maxDistance"] ?? 300,
      multiplier: json["multiplier"] ?? 1,
      useDamageLimit: json["damageLimit"],
      baseProjectileSpeed: json["baseProjectileSpeed"] ?? 10,
      lasserClass: LasserClass.values[classIndex],
      fireRate: json["fireRate"] ?? 1,
      chooserType: EnemyChooserType.values[chooserIndex],
      chooserType2: json["chooserType2"] != null
          ? EnemyChooserType.values[chooser2Index]
          : null,
      chooserType3: json["chooserType3"] != null
          ? EnemyChooserType.values[chooser3Index]
          : null,
      lensDataR: json["lensDataR"] != null
          ? LasserLensData.fromJson(json["lensDataR"])
          : null,
      lensDataG: json["lensDataG"] != null
          ? LasserLensData.fromJson(json["lensDataG"])
          : null,
      lensDataB: json["lensDataB"] != null
          ? LasserLensData.fromJson(json["lensDataB"])
          : null,
    );
  }
}
