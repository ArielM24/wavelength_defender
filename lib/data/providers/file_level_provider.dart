import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wavelength_defender/data/game/level_data.dart';

class FileLevelProvider {
  List<LevelData> levels = [];
  static const List<String> _assetNames = ["assets/levels/level1.json"];
  Future<bool> loadAssetLevels() async {
    try {
      for (int i = 0; i < _assetNames.length; i++) {
        String jsonString = await rootBundle.loadString(_assetNames[i]);
        Map<String, dynamic> js = json.decode(jsonString);
        levels.add(LevelData.fromJson(js));
      }
      return true;
    } catch (ex) {
      debugPrint("$ex");
      return false;
    }
  }
}
