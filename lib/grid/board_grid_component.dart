import 'dart:math';

import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BoardGridComponent extends PositionComponent with Resizable{

  @override
  void render(Canvas c) {
    final horizontalGridCount = GridHelpers.width;
    final verticalGridCount = GridHelpers.height;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    for (int i = 0; i < horizontalGridCount; i++) {
      for (int j = 0; j < verticalGridCount; j++) {
        final gridSize = GridHelpers.gridSize.toDouble();
        final gridCell =
        Rect.fromLTWH(i * gridSize, j * gridSize, gridSize, gridSize);
        c.drawRect(gridCell, paint);
      }
    }
  }
}
