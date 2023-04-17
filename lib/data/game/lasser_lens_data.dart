import 'package:wavelength_defender/data/game/lasser_classes.dart';

class LasserLensData {
  LasserClass lensClass;
  LasserLensChannel channel;
  int channelValue;

  LasserLensData(
      {required this.lensClass,
      required this.channel,
      required this.channelValue});

  static LasserLensData fromLensClass(
      {required LasserClass lensClass, required LasserLensChannel channel}) {
    return LasserLensData(
        lensClass: lensClass,
        channel: channel,
        channelValue: lensClass.randomValue);
  }

  Map<String, dynamic> toJson() {
    return {
      "channelValue": channelValue,
      "channel": channel.index,
      "lensClass": lensClass.index
    };
  }

  factory LasserLensData.fromJson(Map<String, dynamic> json) {
    int classIndex = json["lensClass"] ?? 0;
    int channelIndex = json["channel"] ?? 0;
    int channelValue =
        json["channelValue"] ?? LasserClass.values[classIndex].randomValue;
    return LasserLensData(
        lensClass: LasserClass.values[classIndex],
        channel: LasserLensChannel.values[channelIndex],
        channelValue: channelValue);
  }
}
