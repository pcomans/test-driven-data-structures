import "tree.dart";
import "dart:math";

class MinHeap<T extends Comparable> {
  int _nodeCount = 0;
  int get size => _nodeCount;
  bool isEmpty() => size == 0;
  BNode<T> root;

  _getPathToNode(int nodeIdx) {
    // Get the 1-based index of the new node in binary
    String binIdx = (nodeIdx).toRadixString(2);

    // Discard the most significant bit and use the remaining bits
    // as a path to the position of the new node in the binary tree.
    // See: https://stackoverflow.com/questions/19720438/pointer-based-binary-heap-implementation
    return binIdx
        .substring(1)
        .split("")
        .map<int>((s) => int.parse(s, radix: 2));
  }

  /// Get a list of all nodes on the binary path, including the first and last one.
  _getNodesOnPath(List<int> binPath) {
    BNode<T> current = root;
    List<BNode> pathToNode = new List(binPath.length + 1);
    for (int i = 0; i < binPath.length; i++) {
      pathToNode[i] = current;

      if (binPath.elementAt(i) == 0) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    pathToNode[binPath.length] = current;
    return pathToNode;
  }

  void insert(T elem) {
    _nodeCount++;
    if (root == null) {
      root = new BNode(elem);
    } else {
      Iterable<int> binPath = _getPathToNode(_nodeCount);
      List<BNode> pathToNewNode = _getNodesOnPath(binPath.toList());

      // The last element on the path is null, since the new node doesn't exist yet.
      BNode<T> newNode = new BNode(elem);
      if (binPath.elementAt(binPath.length - 1) == 0) {
        pathToNewNode[binPath.length - 1].left = newNode;
      } else {
        pathToNewNode[binPath.length - 1].right = newNode;
      }

      // Bubble up the new node, we already have the path to the root
      BNode<T> traversalNode = newNode;
      for (int i = 0; i < binPath.length; i++) {
        BNode<T> nodeToCompare = pathToNewNode[(binPath.length - 1) - i];
        if (nodeToCompare.value.compareTo(traversalNode.value) > 0) {
          T temp = nodeToCompare.value;
          nodeToCompare.value = traversalNode.value;
          traversalNode.value = temp;
          traversalNode = nodeToCompare;
        }
      }
    }
  }

  T peekMin() => root.value;

  T extractMin() {
    T returnValue = peekMin();
    // get the rightmost element in the tree
    Iterable<int> binPath = _getPathToNode(_nodeCount);
    print(binPath);
    return null;
  }
}
