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
    test("peekMin should return the smallest element", () {
      MinHeap<int> mh = new MinHeap<int>();
      mh.insert(5);
      mh.insert(3);
      expect(mh.peekMin(), equals(3));
      mh.insert(2);
      mh.insert(1);
      mh.insert(0);
      mh.insert(-1);
      mh.insert(-2);
      mh.insert(-3);
      expect(mh.peekMin(), equals(-3));
      mh.insert(7);
      expect(mh.peekMin(), equals(-3));
    });
    test("extractMin should return the smallest element", () {
      MinHeap<int> mh = new MinHeap<int>();
      mh.insert(5);
      mh.insert(3);
      expect(mh.extractMin(), equals(3));
      mh.insert(2);
      mh.insert(1);
      mh.insert(0);
      mh.insert(-1);
      mh.insert(-2);
      mh.insert(-3);
      expect(mh.extractMin(), equals(-3));
      mh.insert(7);
      expect(mh.extractMin(), equals(-2));
      expect(mh.extractMin(), equals(-1));
      expect(mh.extractMin(), equals(-0));
      mh.insert(6);
      expect(mh.extractMin(), equals(1));
      expect(mh.extractMin(), equals(2));
      expect(mh.extractMin(), equals(5));
      expect(mh.extractMin(), equals(6));
      expect(mh.extractMin(), equals(7));
      // I couldn't get throwsA to work.
      try {
        mh.extractMin();
        expect(true, equals(false), reason: "Should throw EmptyHeapException");
      } on EmptyHeapError catch (_) {
        expect(true, equals(true));
      }
    });
  });
}
