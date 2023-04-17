import 'package:flutter/foundation.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/providers/debug_level_provider.dart';
import 'package:wavelength_defender/data/providers/file_level_provider.dart';

class GameRepository {
  final FileLevelProvider fileProvider;
  final DebugLeverProvider debugLeverProvider;
  bool hasLevel = false;
  LevelData _currentLevelData = LevelData();

  GameRepository()
      : fileProvider = FileLevelProvider(),
        debugLeverProvider = DebugLeverProvider();

  LevelData get debugLevel => debugLeverProvider.debugLevel;
  setDebugLevelData() {
    _currentLevelData = debugLevel;
  }

  LevelData get currentLevelData => _currentLevelData;
  Future<bool> loadLevels() async {
    bool loaded = await fileProvider.loadAssetLevels();
    if (loaded && fileProvider.levels.isNotEmpty) {
      _currentLevelData = fileProvider.levels.first;
      hasLevel = true;
    }
    debugPrint("levels loaded $loaded");
    return loaded;
  }
}
