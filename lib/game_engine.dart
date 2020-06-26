import 'dart:math';
import 'dart:ui';

import 'package:colortd/enemy/enemy_creator_component.dart';
import 'package:colortd/enemy/enemy_destination_component.dart';
import 'package:colortd/enemy/enemy_movement_coordinator.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'enemy/enemy_component.dart';

class GameEngine extends BaseGame with TapDetector {
  static final t1 = TowerComponent()
    ..x = 100
    ..y = 100
    ..width = 50
    ..height = 50;

  static final t2 = TowerComponent()
    ..x = 100
    ..y = 200
    ..width = 50
    ..height = 50;

  static final t3 = TowerComponent()
    ..x = 200
    ..y = 200
    ..width = 50
    ..height = 50;

  static final t4 = TowerComponent()
    ..x = 200
    ..y = 300
    ..width = 50
    ..height = 50;

  static final t5 = TowerComponent()
    ..x = 200
    ..y = 400
    ..width = 50
    ..height = 50;

  static final t6 = TowerComponent()
    ..x = 100
    ..y = 300
    ..width = 50
    ..height = 50;

  static final t7 = TowerComponent()
    ..x = 100
    ..y = 400
    ..width = 50
    ..height = 50;

  final towers = [t1, t2, t3, t4, t5, t6, t7];
  final enemy = EnemyComponent();
  final coordinator = EnemyMovementCoordinator();

  GameEngine() {
    add(EnemyCreatorComponent());
    add(EnemyDestinationComponent());
    add(enemy);

    towers.forEach((element) => add(element));
  }


  @override
  void update(double t) {
    super.update(t);
    final nextPoint = coordinator.vectorField[enemy.nextPoint];
    if (nextPoint != null) {
      enemy.nextPoint = nextPoint;
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    final endPoint = Point(size.width - 20, size.height - 20);
    coordinator.calculateVectorField(towers, size, endPoint);
  }
}
