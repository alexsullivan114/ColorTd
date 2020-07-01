import 'package:colortd/GameCallback.dart';
import 'package:colortd/builder_pane.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Game.dart';
import 'game_engine.dart';

class GameWidget extends StatefulWidget {

  @override
  State createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {

  final _game = Game();
  GameEngine _gameEngine;

  _GameWidgetState() {
    _gameEngine = GameEngine(_game);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
        children: [Expanded(child: _gameEngine.widget), StreamBuilder<int>(
          stream: _game.goldStream,
          builder: (context, snapshot) {
            return BuilderPane(snapshot.data ?? 0);
          }
        )],
    ),
      ));
  }
}
