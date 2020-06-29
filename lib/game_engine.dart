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

import 'enemy/enemy_component.dart';

class GameEngine extends BaseGame with TapDetector {
  static final t1 = TowerComponent()
    ..gridRect = Rect.fromLTWH(4, 4, 5, 5);

  final towers = [t1];
  final enemy = EnemyComponent();
  final coordinator = EnemyMovementCoordinator();
  double elapsedTimeSinceLastUpdate = 0;

  GameEngine() {
    add(EnemyCreatorComponent());
    add(EnemyDestinationComponent());

    towers.forEach((element) => add(element));
//    add(FieldVectorComponent());
//    add(BoardGridComponent());

    add(enemy);
  }


  @override
  void update(double t) {
    super.update(t);
    elapsedTimeSinceLastUpdate += t;
    if (elapsedTimeSinceLastUpdate > TICK_RATE) {
      final nextPoint = coordinator.vectorField[enemy.nextPoint];
      if (nextPoint != null) {
        enemy.nextPoint = nextPoint;
      }
      enemy.percentToNextPoint = 0;
      elapsedTimeSinceLastUpdate = 0;
    } else {
      enemy.percentToNextPoint = elapsedTimeSinceLastUpdate / TICK_RATE;
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    GridHelpers.size = size;
    Size gridSize = Size(GridHelpers.width.toDouble(), GridHelpers.height.toDouble());
    coordinator.calculateVectorField(towers, gridSize, GridHelpers.endPoint);
  }
}
