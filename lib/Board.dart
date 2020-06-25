import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:colortd/grid/grid_painter.dart';
import 'package:colortd/positionable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'board_painter.dart';
import 'constants.dart';
import 'enemy.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Positionable<Enemy>> enemies = [Positionable(Enemy(), 0, 200)];
  Timer _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(Duration(milliseconds: 80), (timer) {
      setState(() {
        enemies = enemies.map((e) => e.dx(10)).toList();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tick.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final gridSize = min(constraints.maxWidth / HORIZONTAL_GRID_COUNT,
              constraints.maxHeight / HORIZONTAL_GRID_COUNT);
          final verticalGridCount = (constraints.maxHeight / gridSize).floor();
          final horizontalGridCount = (constraints.maxWidth / gridSize).floor();
          return CustomPaint(
              size: Size(
                  horizontalGridCount * gridSize, verticalGridCount * gridSize),
              painter:
                  GridPainter(verticalGridCount, horizontalGridCount, gridSize));
        }),
      ),
    );
  }
}
