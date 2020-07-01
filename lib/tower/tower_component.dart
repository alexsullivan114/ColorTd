import 'dart:math';
import 'dart:ui';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/game_engine.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:colortd/tower/projectile_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flame/particles/moving_particle.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent with HasGameRef<GameEngine> {

  static const double ATTACK_RATE = 0.6;
  static const int RANGE = 7;
  double _attackTimeCounter = 0;
  Rect gridRect = Rect.fromLTWH(0, 0, 0, 0);

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(GridHelpers.rectFromGridRect(gridRect), paint);
  }


  @override
  void update(double dt) {
    super.update(dt);
    _attackTimeCounter += dt;
    if (_attackTimeCounter >= ATTACK_RATE) {
      final projectile = fireAt(gameRef?.enemies ?? []);
      if (projectile != null) {
        gameRef.add(projectile);
      }
      _attackTimeCounter = 0;
    }
  }

  ProjectileComponent fireAt(List<EnemyComponent> enemies) {
    final enemy = _closestEnemyInRange(enemies);
    if (enemy != null) {
      return _projectileComponent(enemy);
    } else {
      return null;
    }
  }

  ProjectileComponent _projectileComponent(EnemyComponent firingAt) {
    return ProjectileComponent(firingAt, GridHelpers.rectFromGridRect(gridRect).center, 1);
  }

  EnemyComponent _closestEnemyInRange(List<EnemyComponent> enemies) {
    EnemyComponent closestEnemy;
    double closestDistance = 1000000000;
    enemies.forEach((enemy) {
      final x = pow(enemy.nextPoint.x - gridRect.left, 2);
      final y = pow(enemy.nextPoint.y - gridRect.top, 2);
      final distance = sqrt(x + y);
      if (distance < closestDistance && distance <= RANGE) {
        closestEnemy = enemy;
        closestDistance = distance;
      }
    });
    return closestEnemy;
  }

}
