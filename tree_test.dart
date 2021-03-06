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
      // Recursive
      expect(n.inOrderRec(), equals([7, 3, 8]));
      expect(n.preOrderRec(), equals([3, 7, 8]));
      expect(n.postOrderRec(), equals([7, 8, 3]));
      // Iterative
      expect(n.inOrder(), equals([7, 3, 8]));
      expect(n.preOrder(), equals([3, 7, 8]));
      expect(n.postOrder(), equals([7, 8, 3]));

      n.left.left = new BNode(1);
      n.left.right = new BNode(2);

      // Recursive
      expect(n.inOrderRec(), equals([1, 7, 2, 3, 8]));
      expect(n.preOrderRec(), equals([3, 7, 1, 2, 8]));
      expect(n.postOrderRec(), equals([1, 2, 7, 8, 3]));
      // Iterative
      expect(n.inOrder(), equals([1, 7, 2, 3, 8]));
      expect(n.preOrder(), equals([3, 7, 1, 2, 8]));
      expect(n.postOrder(), equals([1, 2, 7, 8, 3]));
    });
  });
  group("Trie", () {
    test("should store words", () {
      Trie trie = new Trie();
      String word1 = "the";
      expect(trie.toString(), equals("null"));

      expect(trie.contains(word1), equals(false));
      trie.insert(word1);
      expect(trie.toString(), equals("null: {t: {h: {e: {null}}}}"));
      expect(trie.contains(word1), equals(true));

      trie.insert(word1);
      expect(trie.toString(), equals("null: {t: {h: {e: {null}}}}"));

      String word2 = "a";
      expect(trie.contains(word2), equals(false));
      trie.insert(word2);
      expect(trie.toString(), equals("null: {t: {h: {e: {null}}}, a: {null}}"));
      expect(trie.contains(word2), equals(true));

      String word3 = "there";
      expect(trie.contains(word3), equals(false));
      trie.insert(word3);
      expect(trie.toString(),
          equals("null: {t: {h: {e: {null, r: {e: {null}}}}}, a: {null}}"));
      expect(trie.contains(word3), equals(true));
      expect(trie.contains("ther"), equals(false));

      List<String> words = [
        "answer",
        "any",
        "by",
        "bye",
        "their",
      ];

      words.forEach((w) => trie.insert(w));
      words.forEach((w) => expect(trie.contains(w), equals(true)));
      print(trie);
    });
  });
}
