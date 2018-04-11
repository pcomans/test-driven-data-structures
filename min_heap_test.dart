import "package:test/test.dart";
import "min_heap.dart";

void main() {
  group("Min Heap", () {
    test("should support size and isEmpty", () {
      MinHeap<int> mh = new MinHeap<int>();
      expect(mh.size, equals(0));
      expect(mh.isEmpty(), equals(true));
    });
    test("should support insertion", () {
      MinHeap<int> mh = new MinHeap<int>();
      mh.insert(1);
      expect(mh.size, equals(1));
      expect(mh.isEmpty(), equals(false));
      mh.insert(5);
      expect(mh.size, equals(2));
      expect(mh.isEmpty(), equals(false));
    });
    test("should return the smallest element", () {
      MinHeap<int> mh = new MinHeap<int>();
      mh.insert(5);
      mh.insert(3);
      // mh.insert(2);
      // mh.insert(1);
      // mh.insert(0);
      // mh.insert(-1);
      // mh.insert(-2);
      // mh.insert(-3);
      expect(mh.extractMin(), equals(3));
    });
  });
}
