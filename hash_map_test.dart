import "package:test/test.dart";
import 'hash_map.dart';

void main() {
  test("Empty HashMap should contain 0 k-v pairs", () {
    HashMap hm = new HashMap(initialSize: 2);
    expect(hm.length, equals(0));
  });

  test("HashMap should support setting and getting elements", () {
    HashMap hm = new HashMap(initialSize: 2);
    hm.set("key", "value");
    expect(hm.length, equals(1));
    expect(hm.get("key"), equals("value"));
  });

  test("HashMap should support null values", () {
    HashMap hm = new HashMap(initialSize: 2);
    hm.set("key1", null);
    hm.set("key2", null);
    expect(hm.length, equals(2));
    expect(hm.get("key1"), equals(null));
    expect(hm.get("key2"), equals(null));
  });

  test("HashMap should support different types", () {
    HashMap<int, List<String>> hm = new HashMap(initialSize: 2);
    hm.set(1, ["hello","world"]);
    hm.set(2, ["hello","dart"]);
    expect(hm.length, equals(2));
    expect(hm.get(1), equals(["hello","world"]));
    expect(hm.get(2), equals(["hello","dart"]));
  });

  test("HashMap should replace values for existing keys", () {
    HashMap hm = new HashMap(initialSize: 2);
    hm.set("key", "value");
    hm.set("key", "eulav");
    expect(hm.length, equals(1));
    expect(hm.get("key"), equals("eulav"));
  });

  test("HashMap should handle key collisions", () {
    HashMap hm = new HashMap(initialSize: 2);
    hm.set("key1", "value1");
    hm.set("key2", "value2");
    hm.set("key3", "value3");
    expect(hm.length, equals(3));
    expect(hm.get("key1"), equals("value1"));
    expect(hm.get("key2"), equals("value2"));
    expect(hm.get("key3"), equals("value3"));
  });

  test("HashMap should support deletions", () {
    HashMap hm = new HashMap(initialSize: 2);
    hm.set("key1", "value1");
    hm.set("key2", "value2");
    hm.set("key3", "value3");
    expect(hm.length, equals(3));
    expect(hm.delete("key1"), equals("value1"));
    expect(hm.length, equals(2));
    expect(hm.delete("key2"), equals("value2"));
    expect(hm.length, equals(1));
    expect(hm.delete("key3"), equals("value3"));
    expect(hm.length, equals(0));
  });
}
