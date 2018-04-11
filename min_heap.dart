import "tree.dart";

class MinHeap<T extends Comparable> {
  int _nodeCount = 0;
  int get size => _nodeCount;
  bool isEmpty() => size == 0;
  BNode<T> root;

  List<int> _getPathToNode(int nodeIdx) {
    // Get the 1-based index of the new node in binary
    String binIdx = (nodeIdx).toRadixString(2);

    // Discard the most significant bit and use the remaining bits
    // as a path to the position of the new node in the binary tree.
    // See: https://stackoverflow.com/questions/19720438/pointer-based-binary-heap-implementation
    return binIdx
        .substring(1)
        .split("")
        .map<int>((s) => int.parse(s, radix: 2))
        .toList();
  }

  /// Get a list of all nodes on the binary path, including the first and last one.
  List<BNode<T>> _getNodesOnPath(List<int> binPath) {
    BNode<T> current = root;
    List<BNode<T>> pathToNode = new List(binPath.length + 1);
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
      List<int> binPath = _getPathToNode(_nodeCount);
      List<BNode> pathToNewNode = _getNodesOnPath(binPath);

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
    if (_nodeCount == 0) {
      throw new EmptyHeapError();
    }

    T returnValue = peekMin();
    if (_nodeCount > 1)  {
      // Get the rightmost element in the tree
      List<int> binPath = _getPathToNode(_nodeCount);
      List<BNode<T>> nodesOnPath = _getNodesOnPath(binPath);
      BNode<T> rightmostNode = nodesOnPath.last;

      root.value = rightmostNode.value;
      // delete the old rightmost node by removing the reference to it
      if (binPath.last == 0) {
        nodesOnPath[binPath.length - 1].left = null;
      } else {
        nodesOnPath[binPath.length - 1].right = null;
      }

      // Bubble down the root element to restore min heap ordering
      BNode<T> traversalNode = root;
      while (traversalNode != null) {
        BNode<T> left = traversalNode.left;
        BNode<T> right = traversalNode.right;

        BNode<T> smallestChild;
        if (left != null && right != null) {
          if (left.value.compareTo(right.value) < 0) {
            smallestChild = left;
          } else {
            smallestChild = right;
          }
        } else if (left != null) {
          smallestChild = left;
        } else if (right != null) {
          smallestChild = right;
        } else {
          //we reached a leaf.
          break;
        }

        if (smallestChild.value.compareTo(traversalNode.value) < 0) {
          // Bubble value down
          T temp = smallestChild.value;
          smallestChild.value = traversalNode.value;
          traversalNode.value = temp;
          // Continue our walk down the tree
          traversalNode = smallestChild;
        } else {
          // Min heap ordering is already fulfilled
          break;
        }
      }
    } else {
      root = null;
    }

    _nodeCount--;
    return returnValue;
  }
}

class EmptyHeapError extends Error {
  @override
  String toString() => "Heap is empty";
}