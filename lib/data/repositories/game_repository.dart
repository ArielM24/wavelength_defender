import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/providers/debug_level_provider.dart';
import 'package:wavelength_defender/data/providers/file_level_provider.dart';

class GameRepository {
  final FileLevelProvider fileProvider;
  final DebugLeverProvider debugLeverProvider;
  LevelData _currentLevelData = LevelData();

  GameRepository()
      : fileProvider = FileLevelProvider(),
        debugLeverProvider = DebugLeverProvider();

  LevelData get debugLevel => debugLeverProvider.debugLevel;
  setDebugLevelData() {
    _currentLevelData = debugLevel;
  }

  LevelData get currentLevelData => _currentLevelData;
}
