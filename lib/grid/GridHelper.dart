import 'dart:math';
import 'dart:ui';

import '../constants.dart';

mixin GridAware {}

class GridPoint extends Point with GridAware{
  GridPoint(num x, num y) : super(x, y);
}

class GridHelpers {
  static Size size = Size(0, 0);

  static int get width => (size.width / GRID_SIZE).floor();
  static int get height => (size.height / GRID_SIZE).floor();
  static GridPoint get endPoint => GridPoint(width - 1, height - 1);

  static Rect rect(GridPoint point) {
    return Rect.fromLTWH(
        point.x * GRID_SIZE, point.y * GRID_SIZE, GRID_SIZE, GRID_SIZE);
  }

  static Rect rectFromGridRect(Rect rect) {
    final x = rect.left * GRID_SIZE;
    final y = rect.top * GRID_SIZE;
    final width = rect.width * GRID_SIZE;
    final height = rect.height * GRID_SIZE;
    return Rect.fromLTWH(x, y, width, height);
  }
}
