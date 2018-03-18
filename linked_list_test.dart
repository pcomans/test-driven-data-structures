import "package:test/test.dart";
import 'linked_list.dart';

void main() {
  test("Node should return their value", () {
    LinkedListNode<int> node = new LinkedListNode(1);
    expect(node.value, equals(1));
  });

  test("Nodes should have a next attribute", () {
    LinkedListNode<int> node = new LinkedListNode(1);
    node.append(new LinkedListNode(2)).append(new LinkedListNode(3));
    expect(node.value, equals(1));
    expect(node.next.value, equals(2));
    expect(node.next.next.value, equals(3));
  });

  test("node.toString should print all nodes until the tail", () {
    LinkedListNode<int> node = new LinkedListNode(1);
    node.append(new LinkedListNode(2)).append(new LinkedListNode(3));
    expect(node.toString(), equals("1 -> 2 -> 3;"));
    expect(node.next.toString(), equals("2 -> 3;"));
    expect(node.next.next.toString(), equals("3;"));
  });

  test("node.length should return the size of the ll until the tail", () {
    LinkedListNode<int> node = new LinkedListNode(5);
    node.append(new LinkedListNode(2)).append(new LinkedListNode(1));

    expect(node.length, equals(3));
    expect(node.next.length, equals(2));
    expect(node.next.next.length, equals(1));
  });

  test("node.sort should order all nodes until the tail", () {
    expect(LinkedListNode.mergeSort(null), equals(null));
    LinkedListNode<int> node = new LinkedListNode(5);
    LinkedListNode sortedNode = LinkedListNode.mergeSort(node);
    expect(sortedNode.toString(), equals("5;"));

    node.append(new LinkedListNode(2)).append(new LinkedListNode(1));
    sortedNode = LinkedListNode.mergeSort(node);

    expect(sortedNode.toString(), equals("1 -> 2 -> 5;"));
  });

  test("split should split a list into parts of equal length +/- 1", () {
    LinkedListNode<int> node = new LinkedListNode(5);
    node.append(new LinkedListNode(2)).append(new LinkedListNode(1));
    SplitLinkedList<int> heads = LinkedListNode.split(node);

    expect(heads.a.toString(), equals("5;"));
    expect(heads.b.toString(), equals("2 -> 1;"));

    node = new LinkedListNode(5);
    node.append(new LinkedListNode(2));
    heads = LinkedListNode.split(node);
    expect(heads.a.toString(), equals("5;"));
    expect(heads.b.toString(), equals("2;"));
  });

  test("sortedMerge should merge two lists while maintaining sort order", () {
    expect(
        LinkedListNode
            .sortedMerge(new LinkedListNode(5), new LinkedListNode(1))
            .toString(),
        equals("1 -> 5;"));
    LinkedListNode<int> node = new LinkedListNode(1);
    node.append(new LinkedListNode(2)).append(new LinkedListNode(5));

    expect(LinkedListNode.sortedMerge(new LinkedListNode(3), node).toString(),
        equals("1 -> 2 -> 3 -> 5;"));
  });

  test("findLoopStart should find loops in the list", () {
    LinkedListNode<String> cNode = new LinkedListNode("C");
    LinkedListNode<String> node = new LinkedListNode("A");
    node
        .append(new LinkedListNode("B"))
        .append(cNode)
        .append(new LinkedListNode("D"))
        .append(new LinkedListNode("E"))
        .append(cNode);

    LinkedListNode duplicate = new LinkedListNode("value");
    duplicate.next = new LinkedListNode("value");

    expect(node.findLoopStart(), equals(cNode));
    expect(node.findLoopStartRunner(), equals(cNode));
    expect(new LinkedListNode("value").findLoopStart(), equals(null));
    expect(new LinkedListNode("value").findLoopStartRunner(), equals(null));
    expect(new LinkedListNode(duplicate).findLoopStart(), equals(null));
    expect(new LinkedListNode(duplicate).findLoopStartRunner(), equals(null));
  });
}
