import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../constants.dart';
import 'grid_painter.dart';

class BoardGrid extends StatelessWidget {
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
          final paintWidth = horizontalGridCount * gridSize;
          final paintHeight = verticalGridCount * gridSize;
          return CustomPaint(
              size: Size(paintWidth, paintHeight),
              painter: GridPainter(
                  verticalGridCount, horizontalGridCount, gridSize));
        }),
      ),
    );
  }
}
