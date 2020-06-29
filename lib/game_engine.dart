import 'dart:math';
import 'dart:ui';

import 'package:colortd/constants.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:colortd/enemy/enemy_creator_component.dart';
import 'package:colortd/enemy/enemy_destination_component.dart';
import 'package:colortd/enemy/enemy_movement_coordinator.dart';
import 'package:colortd/grid/field_vector_component.dart';
import 'package:colortd/grid/board_grid_component.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

import 'enemy/enemy_component.dart';

class GameEngine extends BaseGame with TapDetector, PanDetector {
  final List<TowerComponent> towers = [];
  final List<EnemyComponent> enemies = [];
  final coordinator = EnemyMovementCoordinator();
  double movementTimeCounter = 0;
  double enemySpawnCounter = 0;

  GameEngine() {
    add(EnemyCreatorComponent());
    add(EnemyDestinationComponent());

    add(FieldVectorComponent());
    add(BoardGridComponent());
  }

  void adjustInvalidEnemyDestinations(List<EnemyComponent> enemies) {
    enemies.forEach((enemy) {
      final nextPoint = coordinator.vectorField[enemy.nextPoint];
      if (nextPoint == null) {
        enemy.nextPoint = enemy.previousPoint;
      }
    });
  }

  void advanceEnemiesPosition(List<EnemyComponent> enemies) {
    enemies.forEach((enemy) {
      final nextPoint = coordinator.vectorField[enemy.nextPoint];
      if (nextPoint != null) {
        enemy.nextPoint = nextPoint;
      }
      enemy.percentToNextPoint = 0;
    });
  }

  void inchEnemiesAlong(List<EnemyComponent> enemies) {
    enemies.forEach((enemy){
      enemy.percentToNextPoint = movementTimeCounter / TICK_RATE;
    });
  }

  void attackEnemies(List<EnemyComponent> enemies, List<TowerComponent> towers) {
    towers.forEach((tower) {
       final enemy = closestEnemy(tower);
       if (enemy != null) {
         enemy.health -= 1;
         if (enemy.health <= 0) {
           enemies.remove(enemy);
         }
       }
    });
  }

  @override
  void update(double t) {
    super.update(t);
    movementTimeCounter += t;
    enemySpawnCounter +=t;
    adjustInvalidEnemyDestinations(enemies);

    if (movementTimeCounter > TICK_RATE) {
      advanceEnemiesPosition(enemies);
      attackEnemies(enemies, towers);
      movementTimeCounter = 0;
    } else {
      inchEnemiesAlong(enemies);
    }

    if (enemySpawnCounter > TICK_RATE * 3) {
      final enemy = EnemyComponent();
      add(enemy);
      enemies.add(enemy);
      enemySpawnCounter = 0;
    }
  }

  EnemyComponent closestEnemy(TowerComponent tower) {
    EnemyComponent closestEnemy;
    double closestDistance = 1000000000;
    enemies.forEach((enemy) {
      final x = pow(enemy.nextPoint.x - tower.gridRect.left, 2);
      final y = pow(enemy.nextPoint.y - tower.gridRect.top, 2);
      final distance = sqrt(x + y);
      if (distance < closestDistance) {
        closestEnemy = enemy;
        closestDistance = distance;
      }
    });
    return closestEnemy;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    GridHelpers.size = size;
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }

  @override
  void onTapDown(TapDownDetails details) => maybeAddTower(details.localPosition);

  @override
  void onPanUpdate(DragUpdateDetails details) => maybeAddTower(details.localPosition);

  void maybeAddTower(Offset offset) {
    final point = GridHelpers.pointFromOffset(offset);
    final gridRect = Rect.fromLTWH(point.x.toDouble(), point.y.toDouble(), 1, 1);
    final towerRects = towers.map((e) => e.gridRect);
    if (!towerRects.contains(gridRect)) {
      final tower = TowerComponent()
        ..gridRect = gridRect;
      towers.add(tower);
      components.add(tower);
      Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
      coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
    }
  }
}
