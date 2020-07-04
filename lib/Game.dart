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

  double get spawnTime => _currentLevel.spawnTime;

  EnemyComponent createEnemy() {
    _currentLevel.remainingEnemies -= 1;
    if (levelFinished) {
      Future.delayed(Duration(seconds: 5), (){
        _currentLevel = _currentLevel.nextLevel;
      });
    }
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
