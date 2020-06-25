import 'dart:ui';

import 'package:colortd/Enemy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Positionable.dart';

class BoardPainter extends CustomPainter {
  final List<Positionable<Enemy>> _enemies;

  BoardPainter(this._enemies);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.points;
    final points =
        _enemies.map((e) => Offset(e.x.toDouble(), e.y.toDouble())).toList();
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 40
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
