import 'dart:async';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'levels/level.dart';
import 'levels/level_1.dart';

class ColorTdGame {
  // ignore: close_sinks
  final BehaviorSubject<GameState> _gameStateSubject = BehaviorSubject.seeded(GameState(10, Colors.red));
  Stream<GameState> get stateStream => _gameStateSubject.stream;

  int get gold => _gameStateSubject.value.gold;

  Color get selectedColor => _gameStateSubject.value.selectedColor;
  set selectedColor(Color color) {
    final currentGameState = _gameStateSubject.value;
    final updatedGameState = currentGameState.copy(selectedColor: color);
    _gameStateSubject.add(updatedGameState);
  }

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
    final currentGameState = _gameStateSubject.value;
    final updatedGameState = currentGameState.copy(gold: currentGameState.gold + 1);
    _gameStateSubject.add(updatedGameState);
  }

  void onEnemyReachedDestination() {
  }

  void onTowerPurchased() {
    final currentGameState = _gameStateSubject.value;
    final updatedGameState = currentGameState.copy(gold: currentGameState.gold - 1);
    _gameStateSubject.add(updatedGameState);
  }
}

class GameState {
  final int gold;
  final Color selectedColor;

  GameState(this.gold, this.selectedColor);

  GameState copy({int gold, Color selectedColor}) {
    final goldValue = gold ?? this.gold;
    final colorValue = selectedColor ?? this.selectedColor;

    return GameState(goldValue, colorValue);
  }
}
