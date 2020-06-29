import 'dart:collection';
import 'dart:math';

import 'package:colortd/grid/GridHelper.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class EnemyMovementCoordinator {
  Map<GridPoint, GridPoint> vectorField = {};

  void calculateVectorField(List<TowerComponent> towers, Size gridSize, GridPoint endPoint) {
    // First make a grid out of our size
    Set<GridPoint> grid = Set();
    for (int i = 0; i < gridSize.width; i++) {
      for (int j = 0; j < gridSize.height; j++) {
        GridPoint point = GridPoint(i, j);
        grid.add(point);
      }
    }
    // Now remove all of the points occupied by towers
    for (TowerComponent component in towers) {
      final rect = component.gridRect;
      // Remove each point in the component from the field
      for (int i = rect.left.toInt(); i < rect.left + rect.width; i++) {
        for (int j = rect.top.toInt(); j < rect.top + rect.height; j++) {
          GridPoint point = GridPoint(i, j);
          grid.remove(point);
        }
      }
    }

    // Now calculate the vector field
    final frontier = Queue<GridPoint>();
    frontier.add(endPoint);
    final Map<GridPoint, GridPoint> cameFrom = {};
    while (frontier.isNotEmpty) {
      final current = frontier.removeFirst();
      for (GridPoint next in neighbors(current, grid)) {
        if (!cameFrom.containsKey(next)) {
          frontier.add(next);
          cameFrom[next] = current;
        }
      }
    }

    this.vectorField = cameFrom;
  }

  Set<GridPoint> neighbors(GridPoint point, Set<GridPoint> grid) {
    final topLeft = GridPoint(point.x - 1, point.y - 1);
    final topRight = GridPoint(point.x + 1, point.y - 1);
    final top = GridPoint(point.x, point.y - 1);
    final left = GridPoint(point.x - 1, point.y);
    final right = GridPoint(point.x + 1, point.y);
    final bottomLeft = GridPoint(point.x - 1, point.y + 1);
    final bottom = GridPoint(point.x, point.y + 1);
    final bottomRight = GridPoint(point.x + 1, point.y + 1);

    final returnSet = Set<GridPoint>();
    if (grid.contains(bottom)) returnSet.add(bottom);
    if (grid.contains(top)) returnSet.add(top);
    if (grid.contains(left)) returnSet.add(left);
    if (grid.contains(right)) returnSet.add(right);
    
    if (grid.contains(right) && grid.contains(bottom)) {
      returnSet.add(bottomRight);
    }
    if (grid.contains(left) && grid.contains(bottom)) {
      returnSet.add(bottomLeft);
    }
    if (grid.contains(left) && grid.contains(top)) {
      returnSet.add(topLeft);
    }
    if (grid.contains(right) && grid.contains(top)) {
      returnSet.add(topRight);
    }

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
