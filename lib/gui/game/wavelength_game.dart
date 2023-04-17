import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_target.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_spawner.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';

class WavelengthGame extends FlameGame with HasCollisionDetection {
  late final TextComponent scoreText, crashesText, spawnedText, enemiesText;
  List<EnemyComponent> enemies = [];
  List<EnemySpawner> spawners = [];
  List<RoadCell> roadCells = [];
  List<EnemyTarget> targets = [];
  List<PositionComponent> lassers = [];

  int score = 0;
  int crashes = 0;
  int spawned = 0;

  final LevelData levelData;
  WavelengthGame({required this.levelData});
  @override
  void onMount() {
    overlays.add("back");
    super.onMount();
  }

  @override
  void onRemove() {
    overlays.remove("back");
    super.onRemove();
  }

  @override
  FutureOr<void> onLoad() {
    for (int i = 0; i < levelData.lassers.length; i++) {
      add(levelData.lassers[i].toComponent());
    }
    for (int i = 0; i < levelData.targets.length; i++) {
      add(levelData.targets[i].toComponent());
    }
    for (int i = 0; i < levelData.roadCells.length; i++) {
      add(levelData.roadCells[i].toComponent());
    }
    for (int i = 0; i < levelData.spawners.length; i++) {
      add(levelData.spawners[i].toComponent());
    }

    addAll([
      FpsTextComponent(
        position: size - Vector2(0, 100),
        anchor: Anchor.bottomRight,
      ),
      scoreText = TextComponent(
          position: size - Vector2(0, 75),
          anchor: Anchor.bottomRight,
          priority: 1),
      crashesText = TextComponent(
          position: size - Vector2(0, 50),
          anchor: Anchor.bottomRight,
          priority: 1),
      spawnedText = TextComponent(
          position: size - Vector2(0, 25),
          anchor: Anchor.bottomRight,
          priority: 1),
      enemiesText = TextComponent(
          position: size - Vector2(0, 0),
          anchor: Anchor.bottomRight,
          priority: 1),
    ]);

    super.onLoad();
  }

  @override
  void update(double dt) {
    scoreText.text = "score $score";
    crashesText.text = "crashes $crashes";
    spawnedText.text = "spawned $spawned";
    enemiesText.text = "enemies ${enemies.length}";

    if (score > 50 || crashes > 10) {
      pauseSpawners();
    }
    super.update(dt);
  }

  pauseSpawners() {
    for (int i = 0; i < spawners.length; i++) {
      spawners[i].pause();
    }
  }

  increaseScore() {
    score++;
  }
}
