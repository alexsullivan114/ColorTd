import 'dart:math';
import 'dart:ui';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/game_engine.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flame/particles/moving_particle.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent with HasGameRef<GameEngine> {

  static const double ATTACK_RATE = 1.0;
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
      final particle = fireAt(gameRef?.enemies ?? []);
      if (particle != null) {
        gameRef.add(particle.asComponent());
      }
      _attackTimeCounter = 0;
    }
  }

  Particle fireAt(List<EnemyComponent> enemies) {
    final enemy = _closestEnemyInRange(enemies);
    if (enemy != null) {
      enemy.attack(1);
      return _projectileParticle(enemy);
    } else {
      return null;
    }
  }

  Particle _projectileParticle(EnemyComponent firingAt) {
    final paint = Paint()
      ..color = Colors.teal;

    final particle = MovingParticle(
      child: CircleParticle(paint: paint, radius: GridHelpers.gridSize / 3),
      from: GridHelpers.offsetFromGridPoint(GridPoint(gridRect.left.toInt(), gridRect.top.toInt())),
      to: GridHelpers.offsetFromGridPoint(GridPoint(firingAt.nextPoint.x + 1, firingAt.nextPoint.y + 1)),
      lifespan: 1,
    );

    return particle;
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
