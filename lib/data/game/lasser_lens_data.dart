import 'package:wavelength_defender/data/game/lasser_classes.dart';

class LasserLensData {
  LasserClass lensClass;
  LasserLensChannel channel;
  int channelValue;

  LasserLensData({required this.lensClass, required this.channel})
      : channelValue = lensClass.randomValue;

  static LasserLensData fromLensClass(
      {required LasserClass lensClass, required LasserLensChannel channel}) {
    return LasserLensData(lensClass: lensClass, channel: channel);
  }
}
