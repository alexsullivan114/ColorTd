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
  static const double maxHealth = 10;
  static const int _speed = 4;
  GridPoint _previousPoint = GridPoint(0, 0);
  GridPoint _nextPoint = GridPoint(0, 0);
  GridPoint _currentLocation = GridPoint(0, 0);
  double health = maxHealth;

  Rect get realRect {
    final gridRect = Rect.fromLTWH(
        _currentLocation.x.toDouble(), _currentLocation.y.toDouble(), 1, 1);
    return GridHelpers.rectFromGridRect(gridRect);
  }

  set nextPoint(GridPoint point) {
    _previousPoint = _nextPoint;
    _nextPoint = point;
  }

  GridPoint get nextPoint => _nextPoint;

  @override
  void render(Canvas c) {
    renderEnemy(c);
    renderHealth(c);
  }

  void renderHealth(Canvas c) {
    final healthOutlinePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final left = realRect.left;
    final top = realRect.top - 20;
    final healthRect = Rect.fromLTWH(left, top, realRect.width, 15);
    c.drawRect(healthRect, healthOutlinePaint);

    final healthFillPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;
    final fillLeft = left + healthOutlinePaint.strokeWidth;
    final fillTop = top + healthOutlinePaint.strokeWidth;
    final fullWidth = realRect.width - healthOutlinePaint.strokeWidth;
    final fillHeight = 15 - healthOutlinePaint.strokeWidth;
    final width = fullWidth * (health / maxHealth);
    final fillRect = Rect.fromLTWH(fillLeft, fillTop, width, fillHeight);
    c.drawRect(fillRect, healthFillPaint);
  }

  void renderEnemy(Canvas c) {
    final enemyPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(realRect, enemyPaint);
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
    final distance = GridHelpers.adjustedMagnitude(dt * _speed);
    final nextPointOffset = GridHelpers.offsetFromGridPoint(_nextPoint);
    final currentPointOffset = GridHelpers.offsetFromGridPoint(_currentLocation);
    final adjustedOffset = nextPointOffset - currentPointOffset;
    final movementX = min(adjustedOffset.dx.abs(), distance);
    final movementY = min(adjustedOffset.dy.abs(), distance);
    final modifierX = adjustedOffset.dx > 0 ? 1 : -1;
    final modifierY = adjustedOffset.dy > 0 ? 1 : -1;
    double newX = currentPointOffset.dx + (modifierX * movementX);
    double newY = currentPointOffset.dy + (modifierY * movementY);

    _currentLocation = GridHelpers.pointFromOffset(Offset(newX, newY));
    if (GridHelpers.withinSpittingDistance(_currentLocation, _nextPoint)) {
      final potentialNextPoint = gameRef.coordinator.vectorField[nextPoint];
      if (potentialNextPoint != null) {
        nextPoint = potentialNextPoint;
      }
    }
  }

  @override
  bool destroy() {
    return health <= 0 || GridHelpers.withinSpittingDistance(_currentLocation, GridHelpers.endPoint);
  }


  @override
  void onDestroy() {
    if (health <= 0) {
      gameRef.enemyDestroyed();
    } else if (GridHelpers.withinSpittingDistance(_currentLocation, GridHelpers.endPoint)) {
      gameRef.enemyReachedDestination();
    }
  }

  void attack(double damage) {
    health -= damage;
  }

  @override
  int priority() {
    return 100;
  }
}
