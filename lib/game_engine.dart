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
import 'package:flutter/material.dart';

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

//    add(FieldVectorComponent());
    add(BoardGridComponent());
  }

  @override
  void update(double t) {
    super.update(t);
    movementTimeCounter += t;
    enemySpawnCounter +=t;
    enemies.removeWhere((enemy) => enemy.health <= 0);

    if (movementTimeCounter > TICK_RATE) {
      towers.forEach((element) {
        final particle = element.fireAt(enemies)?.asComponent();
        if (particle != null) {
          add(particle);
        }
      });
      movementTimeCounter = 0;
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
