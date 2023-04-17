import 'dart:math';

enum LasserClass {
  sss(minValue: 235, bonus: 45),
  ss(minValue: 235, bonus: 30),
  s(minValue: 235),
  a(minValue: 215),
  b(minValue: 195),
  c(minValue: 175),
  d(minValue: 155),
  x(minValue: 155, randomLimit: 100),
  i(minValue: 235, rBonus: 85),
  g(minValue: 235, gBonus: 85),
  u(minValue: 235, bBonus: 85);

  const LasserClass(
      {required this.minValue,
      this.bBonus = 0,
      this.rBonus = 0,
      this.bonus = 0,
      this.randomLimit = 20,
      this.gBonus = 0});
  final int minValue;
  final int bonus;
  final int rBonus;
  final int gBonus;
  final int bBonus;
  final int randomLimit;
  static const xDamage = 235;

  int get randomValue {
    Random r = Random();
    return r.nextInt(randomLimit) + minValue;
  }
}

enum LasserLensChannel { R, G, B }
