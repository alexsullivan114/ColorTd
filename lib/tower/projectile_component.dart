import 'dart:math';
import 'dart:ui';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class ProjectileComponent extends PositionComponent {
  double _damage;
  double _speed = 8;
  Offset _enemyLocation;
  Offset _currentLocation;

  final EnemyComponent _enemyComponent;

  ProjectileComponent(this._enemyComponent, this._currentLocation, this._damage) {
    _enemyLocation = _enemyComponent.realRect.center;
  }

  @override
  void render(Canvas c) {
    final paint = Paint()..color = Colors.red;

    c.drawCircle(_currentLocation, GridHelpers.gridSize / 6, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_enemyComponent.destroy()) {
      final enemyRect = _enemyComponent.realRect;
      _enemyLocation = enemyRect.center;
    }

    final adjustedOffset = _enemyLocation - _currentLocation;
    final distance = GridHelpers.adjustedMagnitude(dt * _speed);
    final movementX = min(adjustedOffset.dx.abs(), distance);
    final movementY = min(adjustedOffset.dy.abs(), distance);
    final modifierX = adjustedOffset.dx > 0 ? 1 : -1;
    final modifierY = adjustedOffset.dy > 0 ? 1 : -1;
    double newX = _currentLocation.dx + (modifierX * movementX);
    double newY = _currentLocation.dy + (modifierY * movementY);

    _currentLocation = Offset(newX, newY);
  }

  @override
  bool destroy() =>
      _currentLocation == _enemyLocation;

  @override
  void onDestroy() {
    _enemyComponent.attack(_damage);
  }
}
