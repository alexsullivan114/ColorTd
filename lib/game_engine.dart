import 'dart:math';
import 'dart:ui';

import 'package:colortd/constants.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:colortd/enemy/enemy_creator_component.dart';
import 'package:colortd/enemy/enemy_destination_component.dart';
import 'package:colortd/enemy/enemy_movement_coordinator.dart';
import 'package:colortd/enemy/field_vector_component.dart';
import 'package:colortd/grid/board_grid_component.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flame/components/component.dart';
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


  @override
  void update(double t) {
    super.update(t);
    movementTimeCounter += t;
    enemySpawnCounter +=t;
    if (movementTimeCounter > TICK_RATE) {
      enemies.forEach((enemy) {
        final nextPoint = coordinator.vectorField[enemy.nextPoint];
        if (nextPoint != null) {
          enemy.nextPoint = nextPoint;
        }
        enemy.percentToNextPoint = 0;
      });
      movementTimeCounter = 0;
    } else {
      enemies.forEach((enemy){
        enemy.percentToNextPoint = movementTimeCounter / TICK_RATE;
      });
    }

    if (enemySpawnCounter > TICK_RATE * 3) {
      final enemy = EnemyComponent();
      add(enemy);
      enemies.add(enemy);
      enemySpawnCounter = 0;
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    GridHelpers.size = size;
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }

  @override
  void onTapDown(TapDownDetails details) {
    final point = GridHelpers.pointFromOffset(details.localPosition);
    final tower = TowerComponent()
      ..gridRect = Rect.fromLTWH(point.x.toDouble(), point.y.toDouble(), 1, 1);
    towers.add(tower);
    components.add(tower);
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    final point = GridHelpers.pointFromOffset(details.localPosition);
    final tower = TowerComponent()
      ..gridRect = Rect.fromLTWH(point.x.toDouble(), point.y.toDouble(), 1, 1);
    towers.add(tower);
    components.add(tower);
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }
}
