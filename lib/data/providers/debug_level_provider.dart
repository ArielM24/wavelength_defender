import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/data/game/enemy_spawner_data.dart';
import 'package:wavelength_defender/data/game/enemy_target_data.dart';
import 'package:wavelength_defender/data/game/lasser_classes.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/data/game/lasser_lens_data.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/game/road_cell_data.dart';
import 'package:wavelength_defender/gui/game/components/extensions/enemy_chooser.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';

class DebugLeverProvider {
  double roadSpeed = 1;
  LevelData get debugLevel {
    return LevelData(
      spawners: [
        EnemySpawnerData(
            position: Vector2(1000, 270),
            direction: RoadDirection.top,
            spawnDelay: 0.3,
            color: Colors.red,
            spawnLimit: 10)
      ],
      lassers: [
        LasserData(
            type: LasserType.pointer,
            multiplier: 0.1,
            maxDistance: 500,
            size: 50,
            position: Vector2(500, 150),
            chooserType: EnemyChooserType.farest,
            lensDataB: LasserLensData.fromLensClass(
                lensClass: LasserClass.s, channel: LasserLensChannel.B)),
        LasserData(
            type: LasserType.single,
            position: Vector2(400, 500),
            size: 50,
            multiplier: 3,
            fireRate: 0.9,
            baseProjectileSpeed: 30,
            lensDataB: LasserLensData.fromLensClass(
                lensClass: LasserClass.a, channel: LasserLensChannel.B))
      ],
      roadCells: [
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(1000, 200),
            size: 70,
            direction: RoadDirection.top),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(1000, 130),
            size: 70,
            direction: RoadDirection.top),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(1000, 60),
            size: 70,
            direction: RoadDirection.left),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(930, 60),
            size: 70,
            direction: RoadDirection.left),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(860, 60),
            size: 70,
            direction: RoadDirection.bottom),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(860, 130),
            size: 70,
            direction: RoadDirection.left),
        RoadCellData(
            roadSpeed: roadSpeed,
            position: Vector2(790, 130),
            size: 70,
            direction: RoadDirection.bottom),
        RoadCellData(
          roadSpeed: roadSpeed,
          position: Vector2(790, 200),
          size: 70,
          direction: RoadDirection.right,
        ),
      ],
      targets: [EnemyTargetData(position: Vector2(860, 200))],
    );
  }
}
