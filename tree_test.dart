import "package:test/test.dart";
import "tree.dart";

void main() {
  group("Tree", () {
    test("Should store values", () {
      Node n = new Node<int>(3);
      expect(n.value, equals(3));
      n.children.add(new Node(7));
      n.children.add(new Node(8));
      expect(n.children.first.value, equals(7));
      expect(n.children.last.value, equals(8));
    });
    test("Should support printing", () {
      Node n = new Node<int>(3);
      expect(n.toString(), equals("3"));
      n.children.add(new Node(7));
      n.children.add(new Node(8));
      expect(n.toString(), equals("3: {7, 8}"));

      n.children.first.children.add(new Node(1));
      n.children.first.children.add(new Node(2));
      expect(n.toString(), equals("3: {7: {1, 2}, 8}"));
    });
  });
  group("Binary tree", () {
    test("Should store values", () {
      BNode n = new BNode<int>(3);
      expect(n.value, equals(3));
      n.left = new BNode(7);
      n.right = new BNode(8);
      expect(n.left.value, equals(7));
      expect(n.right.value, equals(8));
      n.left = new BNode(42);
      expect(n.value, equals(3));
      expect(n.left.value, equals(42));
      expect(n.right.value, equals(8));
    });
    test("Should support printing", () {
      BNode n = new BNode<int>(3);
      expect(n.toString(), equals("3"));
      n.left = new BNode(7);
      n.right = new BNode(8);
      expect(n.toString(), equals("3: {7, 8}"));

      n.left.left = new BNode(1);
      n.left.right = new BNode(2);
      expect(n.toString(), equals("3: {7: {1, 2}, 8}"));
    });
    test("Should support traversal", () {
      BNode n = new BNode<int>(3);
      n.left = new BNode(7);
      n.right = new BNode(8);
      expect(n.inOrder(), equals([7, 3, 8]));
      expect(n.preOrder(), equals([3, 7, 8]));
      expect(n.postOrder(), equals([7, 8, 3]));

      n.left.left = new BNode(1);
      n.left.right = new BNode(2);

      expect(n.inOrder(), equals([1, 7, 2, 3, 8]));
      expect(n.preOrder(), equals([3, 7, 1, 2, 8]));
      expect(n.postOrder(), equals([1, 2, 7, 8, 3]));
    });
  });
}
