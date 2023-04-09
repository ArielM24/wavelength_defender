import 'package:flame/components.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';

extension EnemyChooser on List<EnemyComponent> {
  Vector2? nearestTo(Vector2 position, {double? maxDistance}) {
    Vector2? nearest;
    if (isNotEmpty) {
      nearest = first.position;
      double nearestDistance = position.distanceTo(nearest);
      for (int i = 1; i < length; i++) {
        double aux = position.distanceTo(this[i].position);
        if (aux < nearestDistance) {
          nearestDistance = aux;
          nearest = this[i].position;
        }
      }
      if (maxDistance != null) {
        if (nearestDistance < maxDistance) {
          return nearest;
        } else {
          return null;
        }
      } else {
        return nearest;
      }
    }
    return null;
  }
}
