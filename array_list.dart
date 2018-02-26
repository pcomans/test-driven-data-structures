import 'dart:collection';

class ArrayList<T> extends Object with IterableMixin<T> {
  int _size = 0;
  List<T> _elements = new List(2);

  int get length => _size;
  void add(T e) {
    if (_elements.length == _size) {
      _resize();
    }

    _elements[_size] = e;
    _size++;
  }

  void remove(int index) {
    for (int i = index + 1; i < _size; i++) {
      _elements[i - 1] = _elements[i];
    }
    _size--;

    if (_size == _elements.length / 4) {
      _resize();
    }
  }

  void _resize() {
    List<T> newElements = new List(_size * 2);
    for (int i = 0; i < _size; i++) {
      newElements[i] = _elements[i];
    }

    _elements = newElements;
    print("Resized list to size ${_elements.length}");
  }

  T operator [](int index) => _elements[index];

  Iterator get iterator {
    return new ArrayListIterator<T>(this);
  }
}

class ArrayListIterator<T> extends Iterator<T> {
  final ArrayList arrayList;
  int position = -1;

  ArrayListIterator(this.arrayList);
  bool moveNext() {
    if (position < arrayList.length - 1) {
      position++;
      return true;
    }
    return false;
  }

  T get current {
    return arrayList[position];
  }
}
