import 'package:colortd/builder_pane.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_td_game.dart';
import 'game_engine.dart';

class GameWidget extends StatefulWidget {

  @override
  State createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {

  final _game = ColorTdGame();
  GameEngine _gameEngine;

  _GameWidgetState() {
    _gameEngine = GameEngine(_game);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        children: [Expanded(child: _gameEngine.widget), BuilderPane(_game)],
      ),
    ));
  }
}
