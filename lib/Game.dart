import 'dart:async';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:rxdart/rxdart.dart';

import 'levels/level.dart';
import 'levels/level_1.dart';

class ColorTdGame {
  // ignore: close_sinks
  final BehaviorSubject<int> _goldSubject = BehaviorSubject.seeded(10);

  Stream<int> get goldStream => _goldSubject.stream;
  int get gold => _goldSubject.value;

  Level _currentLevel = Level1();

  bool get levelFinished => _currentLevel.remainingEnemies <= 0;

  int get spawnTime => _currentLevel.spawnTime;

  EnemyComponent createEnemy() {
    _currentLevel.remainingEnemies -= 1;
    return _currentLevel.enemyCreator();
  }

  void onEnemyDestroyed() {
    _goldSubject.value += 1;
  }

  void onEnemyReachedDestination() {
  }

  void onTowerPurchased() {
    _goldSubject.value -= 1;
  }
}
