import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class RadiousLight extends PositionComponent
    with HasCollisionDetection, HasGameRef<WavelengthGame> {
  Ray2? ray;
  late CircleComponent circle;
  late Vector2 origin;
  bool isOriginCasted = false;
  Paint paint = Paint();
  static const numberOfRays = 300;
  final List<Ray2> rays = [];
  final List<RaycastResult<ShapeHitbox>> results = [];
  final _colorTween = ColorTween(
    begin: Colors.blue.withOpacity(0.2),
    end: Colors.red.withOpacity(0.2),
  );
  @override
  FutureOr<void> onLoad() {
    position = Vector2(100, 100);
    // final defaultPaint = Paint()
    //   ..color = Colors.green
    //   ..style = PaintingStyle.stroke;
    // circle = CircleComponent(position: Vector2(10, 10), radius: 25, children: [
    //   CircleHitbox(isSolid: true)
    //     ..renderShape = true
    //     ..paint = defaultPaint
    // ]);

    // add(circle);

    paint.color = Colors.cyan;
    paint.style = PaintingStyle.stroke;
    add(CircleHitbox(radius: 100));
    //position = Vector2(400, 50);
    size = Vector2(200, 200);
    //origin = Vector2(position.x + size.x / 2, position.y + size.y / 2);
    origin = position;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    final res = gameRef.collisionDetection.raycastAll(
      position,
      numberOfRays: numberOfRays,
      rays: rays,
      out: results,
    );
    // if (results.isNotEmpty) {
    //   debugPrint("${res.first.hitbox.runtimeType}");
    // }
    // if (circle.position.x < gameRef.size.x - circle.size.x) {
    //   circle.position.x++;
    // }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderResult(canvas, origin, results, paint);
  }

  void renderResult(Canvas canvas, Vector2 origin,
      List<RaycastResult<ShapeHitbox>> results, Paint paint) {
    final originOffset = origin.toOffset();
    for (final result in results) {
      if (!result.isActive) {
        continue;
      }
      if (result.hitbox is RectangleHitbox) {
        continue;
      }
      final intersectionPoint = result.intersectionPoint!.toOffset();
      final Offset offset =
          Offset(intersectionPoint.dx - 100, intersectionPoint.dy - 100);
      canvas.drawLine(
        originOffset,
        offset,
        paint,
      );
    }
  }
}
