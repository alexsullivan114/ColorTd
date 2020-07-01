import 'dart:async';

import 'package:colortd/GameCallback.dart';
import 'package:rxdart/rxdart.dart';

class Game extends GameCallback {
  final BehaviorSubject<int> goldStream = BehaviorSubject.seeded(10);
  @override
  void onEnemyDestroyed() {
    goldStream.value += 1;
  }

  @override
  void onEnemyReachedDestination() {
    goldStream.value -= 1;
  }
}
