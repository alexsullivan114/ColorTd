import 'dart:math';
import 'dart:ui';

import 'package:colortd/color_td_game.dart';
import 'package:colortd/grid/GridHelper.dart';
import 'package:colortd/enemy/enemy_creator_component.dart';
import 'package:colortd/enemy/enemy_destination_component.dart';
import 'package:colortd/enemy/enemy_movement_coordinator.dart';
import 'package:colortd/grid/field_vector_component.dart';
import 'package:colortd/grid/board_grid_component.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'enemy/enemy_component.dart';

class GameEngine extends BaseGame with TapDetector, PanDetector {
  double enemySpawnCounter = 0;
  final ColorTdGame _game;
  final List<TowerComponent> towers = [];
  final List<EnemyComponent> enemies = [];
  final coordinator = EnemyMovementCoordinator();

  GameEngine(this._game) {
    add(EnemyCreatorComponent());
    add(EnemyDestinationComponent());

//    add(FieldVectorComponent());
    add(BoardGridComponent());
  }

  @override
  void update(double t) {
    super.update(t);
    enemySpawnCounter +=t;
    enemies.removeWhere((enemy) => enemy.health <= 0);

    if (enemySpawnCounter > _game.spawnTime && !_game.levelFinished) {
      final enemy = _game.createEnemy();
      add(enemy);
      enemies.add(enemy);
      enemySpawnCounter = 0;
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    GridHelpers.gridSize = min((size.width / GridHelpers.width), (size.height / GridHelpers.height));
    GridHelpers.size = size;
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }

  @override
  void onTapDown(TapDownDetails details) => _maybeAddTower(details.localPosition);

  @override
  void onPanUpdate(DragUpdateDetails details) => _maybeAddTower(details.localPosition);

  void _maybeAddTower(Offset offset) {
    final point = GridHelpers.roundedPointFromOffset(offset);
    final gridRect = Rect.fromLTWH(point.x.toDouble(), point.y.toDouble(), 1, 1);
    final towerRects = towers.map((e) => e.gridRect);
    if (!towerRects.contains(gridRect) && _game.gold > 0) {
      final tower = TowerComponent()
        ..gridRect = gridRect;
      towers.add(tower);
      add(tower);
      Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
      coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
      _game.onTowerPurchased();
    }
  }

  void trapped() {
    towers.forEach((tower) {
      components.remove(tower);
    });
    towers.clear();
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }

  void enemyDestroyed() {
    _game.onEnemyDestroyed();
  }

  void enemyReachedDestination() {
    _game.onEnemyReachedDestination();
  }
}
