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
  GridPoint _previousPoint = GridPoint(0, 0);
  GridPoint _nextPoint = GridPoint(0, 0);
  double elapsedTimeSinceMove = 0;
  double percentToNextPoint = 0;
  double health = 100;

  Rect get realRect => GridHelpers.blendRect(_previousPoint, _nextPoint, percentToNextPoint);

  set nextPoint(GridPoint point) {
    _previousPoint = _nextPoint;
    _nextPoint = point;
  }

  GridPoint get nextPoint => _nextPoint;

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(realRect, paint);
  }

  void _correctPotentialInvalidDestination() {
    final potentialNextPoint = gameRef.coordinator.vectorField[nextPoint];
    if (potentialNextPoint == null) {
      final potentialNextPointAfterPreviousPoint = gameRef.coordinator.vectorField[_previousPoint];
      if (potentialNextPointAfterPreviousPoint != null) {
        nextPoint = _previousPoint;
      } else {
        gameRef.trapped();
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _correctPotentialInvalidDestination();
    elapsedTimeSinceMove += dt;
    if (elapsedTimeSinceMove > TICK_RATE) {
      final potentialNextPoint = gameRef.coordinator.vectorField[nextPoint];
      if (potentialNextPoint != null) {
        nextPoint = potentialNextPoint;
      }
      elapsedTimeSinceMove = 0;
      percentToNextPoint = 0;
    } else {
      percentToNextPoint = elapsedTimeSinceMove / TICK_RATE;
    }
  }

  @override
  bool destroy() {
    return health <= 0 || _previousPoint == GridHelpers.endPoint;
  }

  void attack(double damage) {
    health -= damage;
  }
}
