import 'dart:math';
import 'dart:ui';

import 'package:colortd/game_engine.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/material.dart';

class FieldVectorComponent extends Component with HasGameRef<GameEngine> {

  @override
  void update(double t) {

  }

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.red.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final map = gameRef.coordinator.vectorField;
    for (Point p in map.keys) {
      final rect = Rect.fromLTWH(p.x, p.y, 0.5, 0.5);
      c.drawRect(rect, paint);
    }
  }
}
