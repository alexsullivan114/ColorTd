class Positionable<T> {
  final T value;
  final int x;
  final int y;

  Positionable(this.value, this.x, this.y);

  Positionable<T> dx(int quantity) {
    return Positionable(this.value, this.x + quantity, this.y);
  }

  Positionable<T> dy(int quantity) {
    return Positionable(this.value, this.x, this.y + quantity);
  }
}