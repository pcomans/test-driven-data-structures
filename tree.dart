abstract class ANode<T> {
  final T value;
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
    List<T> nodes = [];
    nodes.addAll(left?.inOrder() ?? []);
    nodes.add(value);
    nodes.addAll(right?.inOrder() ?? []);
    return nodes;
  }

  List<T> preOrder() {
    List<T> nodes = [];
    nodes.add(value);
    nodes.addAll(left?.preOrder() ?? []);
    nodes.addAll(right?.preOrder() ?? []);
    return nodes;
  }

  List<T> postOrder() {
    List<T> nodes = [];
    nodes.addAll(left?.postOrder() ?? []);
    nodes.addAll(right?.postOrder() ?? []);
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
