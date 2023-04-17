import 'package:wavelength_defender/data/game/enemy_spawner_data.dart';
import 'package:wavelength_defender/data/game/enemy_target_data.dart';
import 'package:wavelength_defender/data/game/lasser_data.dart';
import 'package:wavelength_defender/data/game/road_cell_data.dart';

class LevelData {
  int score;
  int crashes;
  List<RoadCellData> roadCells;
  List<EnemySpawnerData> spawners;
  List<LasserData> lassers;
  List<EnemyTargetData> targets;
  LevelData(
      {this.score = 0,
      this.crashes = 0,
      this.roadCells = const [],
      this.lassers = const [],
      this.targets = const [],
      this.spawners = const []});
}
