import 'dart:math';
import 'dart:ui';

import 'package:colortd/game_engine.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

class EnemyComponent extends PositionComponent with Resizable, HasGameRef<GameEngine> {
  Point nextPoint = Point(0, 0);

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromLTWH(nextPoint.x.toDouble(), nextPoint.y.toDouble(), 20, 20);
    c.drawRect(rect, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
//    position = position.shift(Offset(1, 1));
//    if (size == null) return;
//    if (position.left < 0 ||
//        position.right > size.width ||
//        position.bottom > size.height ||
//        position.top < 0) {
//      this.destroy();
//    }
  }
}
