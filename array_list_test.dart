import "package:test/test.dart";
import 'array_list.dart';

void main() {
  test("Empty ArrayList should contain 0 elements", () {
    ArrayList arr = new ArrayList();
    expect(arr.length, equals(0));
  });

  test("ArrayList should support adding and retrieving elements", () {
    ArrayList arr = new ArrayList<String>();
    arr.add("Hello");
    expect(arr.length, equals(1));
    expect(arr[0], "Hello");
  });

  test("ArrayList should support adding many elements", () {
    ArrayList arr = new ArrayList<int>();

    for (int i = 0; i < 1000; i++) {
      arr.add(i);
    }

    expect(arr.length, equals(1000));
    expect(arr[0], 0);
    expect(arr[999], 999);
  });

  test("ArrayList should implement Iterable", () {
    ArrayList arr = new ArrayList<int>();

    for (int i = 0; i < 1000; i++) {
      arr.add(i);
    }

    expect(arr.first, equals(0));
    expect(arr.last, equals(999));
    expect(arr.reduce((value, element) => value + element), equals(499500));
  });

  test("ArrayList should support deletion", () {
    ArrayList arr = new ArrayList<String>();
    expect(arr.length, equals(0));
    arr.add("😛");
    arr.add("😅");
    arr.remove(0);
    expect(arr.length, equals(1));
    expect(arr[0], equals("😅"));
  });

  test("ArrayList should auto shrink after deletion", () {
    ArrayList arr = new ArrayList<int>();
    for (int i = 0; i < 1000; i++) {
      arr.add(i);
    }

    expect(arr.first, equals(0));
    expect(arr.last, equals(999));

    for (int i = 0; i < 998; i++) {
      arr.remove(0);
    }
    expect(arr.first, equals(998));
    expect(arr.last, equals(999));
  });
}
