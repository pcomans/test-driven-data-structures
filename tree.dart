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
