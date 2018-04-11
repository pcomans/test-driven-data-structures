import "tree.dart";
import "dart:math";

class MinHeap<T extends Comparable> {
  int _nodeCount = 0;
  int get size => _nodeCount;
  bool isEmpty() => size == 0;
  BNode<T> root;

  void insert(T elem) {
    _nodeCount++;
    if (root == null) {
      root = new BNode(elem);
    } else {
      // Get the 1-based index of the new node in binary
      String binIdx = (_nodeCount).toRadixString(2);

      // Discard the most significant bit and use the remaining bits
      // as a path to the position of the new node in the binary tree.
      // See: https://stackoverflow.com/questions/19720438/pointer-based-binary-heap-implementation
      Iterable<int> binPath =
          binIdx.substring(1).split("").map<int>((s) => int.parse(s, radix: 2));

      BNode<T> current = root;
      List<BNode> pathToNode = new List(log(_nodeCount).ceil());
      for (int i = 0; i < binPath.length - 1; i++) {
        pathToNode[i] = current;

        if (binPath.elementAt(i) == 0) {
          current = current.left;
        } else {
          current = current.right;
        }
      }
      pathToNode[binPath.length - 1] = current;

      BNode<T> newNode = new BNode(elem);
      if (binPath.elementAt(binPath.length - 1) == 0) {
        current.left = newNode;
      } else {
        current.right = newNode;
      }

      // Bubble up the new node
      BNode<T> traversalNode = newNode;
      for (int i = 0; i < binPath.length; i++) {
        BNode<T> nodeToCompare = pathToNode[(binPath.length - 1) - i];
        print("${nodeToCompare.value}<${traversalNode.value}?");
        if (nodeToCompare.value.compareTo(traversalNode.value) > 0) {
          T temp = nodeToCompare.value;
          nodeToCompare.value = traversalNode.value;
          traversalNode.value = temp;
          traversalNode = nodeToCompare;
        }
      }
    }
  }

  T extractMin() {
    return root.value;
  }
}
