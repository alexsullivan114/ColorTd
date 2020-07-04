import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ColorTdGame {
  // ignore: close_sinks
  final BehaviorSubject<int> _goldSubject = BehaviorSubject.seeded(10);

  Stream<int> get goldStream => _goldSubject.stream;
  int get gold => _goldSubject.value;

  void onEnemyDestroyed() {
    _goldSubject.value += 1;
  }

  void onEnemyReachedDestination() {

  }

  void onTowerPurchased() {
    _goldSubject.value -= 1;
  }
}
