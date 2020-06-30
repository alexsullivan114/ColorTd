import 'dart:math';
import 'dart:ui';

import 'package:colortd/game_engine.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EnemyComponent extends PositionComponent with Resizable, HasGameRef<GameEngine> {
  List<GridPoint> points = [];
  GridPoint previousPoint = GridPoint(0, 0);
  GridPoint _nextPoint = GridPoint(0, 0);
  double percentToNextPoint = 0;
  int health = 100;

  set nextPoint(GridPoint point) {
    previousPoint = _nextPoint;
    _nextPoint = point;
    points.add(point);
  }

  GridPoint get nextPoint => _nextPoint;

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final rect = GridHelpers.blendRect(previousPoint, _nextPoint, percentToNextPoint);
    c.drawRect(rect, paint);

//    points.forEach((element) {
//      final rect = GridHelpers.rect(element);
//      c.drawRect(rect, paint);
//    });
  }

  @override
  bool destroy() {
    return health <= 0;
  }

  void attack(int damage) {
    health -= damage;
  }
}
