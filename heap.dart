import 'dart:math';

void main() {
  BinMaxHeap bmh = new BinMaxHeap();
  bmh.insert(1);
  bmh.insert(2);
  bmh.insert(3);
  bmh.insert(4);
  bmh.insert(5);
  bmh.insert(6);

  print(bmh.extract());
  print(bmh.extract());
  print(bmh.extract());
  print(bmh.extract());
  print(bmh.extract());
  print(bmh.extract());

  bmh.insert(1);
  bmh.insert(2);
  bmh.insert(3);
  bmh.insert(4);
  bmh.insert(5);
  bmh.insert(6);
}

class BinMaxHeap {
  final List<int> elems = new List();

  void insert(int e) {
    elems.add(e);
    _siftUp(elems.length - 1);
    print(elems);
  }

  int extract() {
    int val = elems[0];
    int lastElem = elems.removeLast();

    if (elems.length > 0) {
      elems[0] = lastElem;
      _siftDown(0);
      print(elems);
    }
    return val;
  }

  void _siftDown(int nodeIdx) {
    if (_lChildIdx(nodeIdx) >= elems.length) {
      return;
    }

    int maxChildIdx = _maxChildIdx(nodeIdx);

    if (elems[maxChildIdx] > elems[nodeIdx]) {
      _swap(nodeIdx, maxChildIdx);
      _siftDown(maxChildIdx);
    }
  }

  void _siftUp(int nodeIdx) {
    if (nodeIdx == 0) {
      return;
    }

    int parentIdx = _parentIdx(nodeIdx);
    int node = elems[nodeIdx];
    int parent = elems[parentIdx];

    if (parent < node) {
      _swap(nodeIdx, parentIdx);

      _siftUp(parentIdx);
    }
  }

  int _parentIdx(int idx) => ((idx - 1) / 2).floor();
  int _lChildIdx(int idx) => idx * 2 + 1;
  int _rChildIdx(int idx) => idx * 2 + 2;

  void _swap(int aIdx, int bIdx) {
    int aVal = elems[aIdx];
    int bVal = elems[bIdx];

    elems[aIdx] = bVal;
    elems[bIdx] = aVal;
  }

  int _maxChildIdx(int idx) {
    if (_rChildIdx(idx) >= elems.length) {
      return _lChildIdx(idx);
    } else {
      if (elems[_lChildIdx(idx)] > elems[_rChildIdx(idx)]) {
        return _lChildIdx(idx);
      } else {
        return _rChildIdx(idx);
      }
    }
  }
}

class HeapType {
  Function comparator;
}
