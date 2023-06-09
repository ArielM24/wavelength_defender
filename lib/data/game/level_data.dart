import 'package:wavelength_defender/data/game/enemy_spawner_data.dart';
import 'package:wavelength_defender/data/game/enemy_target_data.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/data/game/road_cell_data.dart';

class LevelData {
  List<RoadCellData> roadCells;
  List<EnemySpawnerData> spawners;
  List<LasserData> lassers;
  List<EnemyTargetData> targets;
  LevelData(
      {this.roadCells = const [],
      this.lassers = const [],
      this.targets = const [],
      this.spawners = const []});

  Map<String, dynamic> toJson() {
    return {
      "roadCells": roadCells.map((cell) => cell.toJson()).toList(),
      "spawners": spawners.map((spawner) => spawner.toJson()).toList(),
      "targets": targets.map((target) => target.toJson()).toList(),
      "lassers": lassers.map((lasser) => lasser.toJson()).toList(),
    };
  }

  factory LevelData.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> cells =
        (json["roadCells"] ?? []).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> spawners =
        (json["spawners"] ?? []).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> targets =
        (json["targets"] ?? []).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> lassers =
        (json["lassers"] ?? []).cast<Map<String, dynamic>>();
    return LevelData(
      roadCells: cells
          .map((cell) => RoadCellData.fromJson(cell))
          .toList()
          .cast<RoadCellData>(),
      spawners: spawners
          .map((spawner) => EnemySpawnerData.fromJson(spawner))
          .toList()
          .cast<EnemySpawnerData>(),
      targets: targets
          .map((target) => EnemyTargetData.fromJson(target))
          .toList()
          .cast<EnemyTargetData>(),
      lassers: lassers
          .map((lasser) => LasserData.fromJson(lasser))
          .toList()
          .cast<LasserData>(),
    );
  }
}
