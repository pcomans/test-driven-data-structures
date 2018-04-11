import "stack.dart";

abstract class ANode<T> {
  T value;
  List<ANode<T>> _children = [];

  ANode(this.value, [int numChildren = 0]) {
    _children = new List.filled(numChildren, null, growable: true);
  }

  String toString() {
    Iterable<ANode<T>> nonNullChildren = _children.where((n) => n != null);
    return (nonNullChildren.length == 0)
        ? "$value"
        : "$value: {${nonNullChildren.map((n) => n.toString()).join(", ")}}";
  }
}

class Node<T> extends ANode<T> {
  Node(T value) : super(value);
  List<Node<T>> get children => _children;
}

class BNode<T> extends ANode<T> {
  BNode(T value) : super(value, 2);

  BNode<T> get left => _children[0];
  BNode<T> get right => _children[1];
  void set left(BNode<T> node) => _children[0] = node;
  void set right(BNode<T> node) => _children[1] = node;

  List<T> inOrder() {
    Stack stack = new Stack<BNode<T>>();
    List<T> nodes = [];

    BNode<T> current = this;
    while (current != null || !stack.isEmpty()) {
      if (current != null) {
        stack.push(current);
        current = current.left;
      } else {
        BNode<T> popped = stack.pop();
        nodes.add(popped.value);
        current = popped.right;
      }
    }
    return nodes;
  }

  List<T> inOrderRec() {
    List<T> nodes = [];
    nodes.addAll(left?.inOrderRec() ?? []);
    nodes.add(value);
    nodes.addAll(right?.inOrderRec() ?? []);
    return nodes;
  }

  List<T> preOrder() {
    Stack stack = new Stack<BNode<T>>();
    List<T> nodes = [];

    stack.push(this);
    while (!stack.isEmpty()) {
      BNode<T> current = stack.pop();
      nodes.add(current.value);
      if (current.right != null) {
        stack.push(current.right);
      }
      if (current.left != null) {
        stack.push(current.left);
      }
    }
    return nodes;
  }

  List<T> postOrder() {
    Stack stack = new Stack<BNode<T>>();
    Stack reverse = new Stack<T>();

    List<T> nodes = [];

    stack.push(this);
    while (!stack.isEmpty()) {
      BNode<T> current = stack.pop();
      reverse.push(current.value);
      if (current.left != null) {
        stack.push(current.left);
      }
      if (current.right != null) {
        stack.push(current.right);
      }
    }
    while (!reverse.isEmpty()) {
      nodes.add(reverse.pop());
    }

    return nodes;
  }

  List<T> preOrderRec() {
    List<T> nodes = [];
    nodes.add(value);
    nodes.addAll(left?.preOrderRec() ?? []);
    nodes.addAll(right?.preOrderRec() ?? []);
    return nodes;
  }

  List<T> postOrderRec() {
    List<T> nodes = [];
    nodes.addAll(left?.postOrderRec() ?? []);
    nodes.addAll(right?.postOrderRec() ?? []);
    nodes.add(value);
    return nodes;
  }
}

class Trie {
  TrieNode root = new TrieNode(null);
  void insert(String word) => root.insert(word);
  bool contains(String word) => root.contains(word);
  String toString() => root.toString();
}

class TrieNode extends Node<String> {
  TrieNode(String value) : super(value);
  void insert(String word) {
    if (word == null || word == "") {
      if (!hasEndOfWordNode()) {
        children.add(new TrieEndOfWordNode());
      }
      return;
    }
    String firstLetter = word.substring(0, 1);
    TrieNode prefixChild = _getChildWithPrefix(firstLetter);

    if (prefixChild == null) {
      prefixChild = new TrieNode(firstLetter);
      children.add(prefixChild);
    }
    prefixChild.insert(word.substring(1));
  }

  bool contains(String word) {
    if (word == null || word == "") {
      return hasEndOfWordNode();
    }
    String firstLetter = word.substring(0, 1);
    TrieNode prefixChild = _getChildWithPrefix(firstLetter);

    if (prefixChild == null) {
      return false;
    }
    return prefixChild.contains(word.substring(1));
  }

  TrieNode _getChildWithPrefix(String prefix) => children.firstWhere(
        (n) => n.value == prefix,
        orElse: () => null,
      );

  bool hasEndOfWordNode() =>
      children.firstWhere(
        (n) => n is TrieEndOfWordNode,
        orElse: () => null,
      ) !=
      null;
}

class TrieEndOfWordNode extends TrieNode {
  TrieEndOfWordNode() : super(null);
}
