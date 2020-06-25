import 'dart:async';
import 'dart:ui';

import 'package:colortd/Positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'BoardPainter.dart';
import 'Enemy.dart';

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
    return Container(
      color: Colors.white,
      child: CustomPaint(
        size: Size.fromRadius(400),
        painter: BoardPainter(enemies)
      ),
    );
  }
}



