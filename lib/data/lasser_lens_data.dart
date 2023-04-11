import 'package:wavelength_defender/data/lasser_classes.dart';

class LasserLensData1 {
  LasserClass lensClass;
  LasserLensChannel channel;
  int channelValue;

  LasserLensData1({required this.lensClass, required this.channel})
      : channelValue = lensClass.randomValue;

  static LasserLensData1 fromLensClass(
      {required LasserClass lensClass, required LasserLensChannel channel}) {
    return LasserLensData1(lensClass: lensClass, channel: channel);
  }
}
