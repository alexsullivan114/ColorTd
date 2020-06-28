import 'dart:collection';
import 'dart:math';

import 'package:colortd/tower/tower_component.dart';
import 'package:flutter/cupertino.dart';

class EnemyMovementCoordinator {
  Map<Point, Point> vectorField = {};

  void calculateVectorField(List<TowerComponent> towers, Size gridSize, Point endPoint) {
    final enemySize = 20;
    // First make a grid out of our size
    Set<Point> grid = Set();
    for (int i = 0; i < gridSize.width; i++) {
      for (int j = 0; j < gridSize.height; j++) {
        Point point = Point(i, j);
        grid.add(point);
      }
    }
    // Now remove all of the points occupied by towers
    for (TowerComponent component in towers) {
      final rect = component.toRect();
      // Remove each point in the component from the field
      for (int i = rect.left.toInt(); i < rect.left + rect.width; i++) {
        for (int j = rect.top.toInt(); j < rect.top + rect.height; j++) {
          Point point = Point(i, j);
          grid.remove(point);
        }
      }
      // And now remove the impossible points on the top and left edges since that
      // can intersect with our creator.
      for (int i = rect.left.toInt() - enemySize; i < rect.left + rect.width; i++) {
        for (int j = 0; j < enemySize; j++) {
          Point point = Point(i, rect.top - j);
          grid.remove(point);
        }
      }
      for (int i = rect.top.toInt(); i < rect.top + rect.height; i++) {
        for (int j = 0; j < enemySize; j++) {
          Point point = Point(rect.left - j, i);
          grid.remove(point);
        }
      }
    }

    // Remove edge points that aren't possible to occupy
    // First remove points on the right edge.
    for (int i = 0; i < gridSize.height; i++) {
      for (int j = 0; j < enemySize; j++) {
        Point point = Point(gridSize.width - j, i);
        grid.remove(point);
      }
    }
    // Then remove points on the bottom edge.
    for (int i = 0; i < gridSize.width; i++) {
      for (int j = 0; j < enemySize; j++) {
        Point point = Point(i, gridSize.height - j);
        grid.remove(point);
      }
    }

    // Now calculate the vector field
    final frontier = Queue<Point>();
    frontier.add(endPoint);
    final Map<Point, Point> cameFrom = {};
    while (frontier.isNotEmpty) {
      final current = frontier.removeFirst();
      for (Point next in neighbors(current, grid)) {
        if (!cameFrom.containsKey(next)) {
          frontier.add(next);
          cameFrom[next] = current;
        }
      }
    }

    this.vectorField = cameFrom;
  }

  Set<Point> neighbors(Point point, Set<Point> grid) {
    final topLeft = Point(point.x - 1, point.y - 1);
    final topRight = Point(point.x + 1, point.y - 1);
    final top = Point(point.x, point.y - 1);
    final left = Point(point.x - 1, point.y);
    final right = Point(point.x + 1, point.y);
    final bottomLeft = Point(point.x - 1, point.y + 1);
    final bottom = Point(point.x, point.y + 1);
    final bottomRight = Point(point.x + 1, point.y + 1);

    final returnSet = Set<Point>();
    if (grid.contains(bottom)) returnSet.add(bottom);
    if (grid.contains(top)) returnSet.add(top);
    if (grid.contains(left)) returnSet.add(left);
    if (grid.contains(right)) returnSet.add(right);

    if (grid.contains(topLeft)) returnSet.add(topLeft);
    if (grid.contains(topRight)) returnSet.add(topRight);
    if (grid.contains(bottomLeft)) returnSet.add(bottomLeft);
    if (grid.contains(bottomRight)) returnSet.add(bottomRight);

    return returnSet;
  }
}

enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  TOP_RIGHT,
  TOP_LEFT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}
