class LinkedListNode<T> {
  final T value;
  LinkedListNode next;

  LinkedListNode(this.value);

  LinkedListNode<T> append(LinkedListNode<T> nextNode) {
    next = nextNode;
    return nextNode;
  }

  String toString() {
    if (!hasNext) {
      return "$value;";
    } else {
      return "$value -> ${next.toString()}";
    }
  }

  int get length {
    if (!hasNext) {
      return 1;
    } else {
      return 1 + next.length;
    }
  }

  LinkedListNode<T> findLoopStart() {
    Map<LinkedListNode<T>, bool> occurrences = {};

    LinkedListNode<T> runner = this;
    while (runner != null) {
      if (occurrences.containsKey(runner)) {
        return runner;
      }
      occurrences[runner] = true;
      runner = runner.next;
    }
    return null; // No loop
  }

  LinkedListNode<T> findLoopStartRunner() {
    LinkedListNode<T> slowRunner = this;
    LinkedListNode<T> fastRunner = this;
    bool collided = false;
    while (fastRunner != null && !collided) {
      slowRunner = slowRunner.next;
      fastRunner = fastRunner.next?.next;
      print("R1 - s: ${slowRunner?.value}, f: ${fastRunner?.value}");
      if (slowRunner != null && slowRunner == fastRunner) {
        collided = true;
      }
    }
    if (!collided) {
      return null;
    }
    slowRunner = this; // Move slowRunner back to the head
    while (slowRunner != fastRunner) {
      print("R2 - s: ${slowRunner?.value}, f: ${fastRunner?.value}");
      slowRunner = slowRunner.next;
      fastRunner = fastRunner.next;
    }
    return slowRunner;
  }

  bool get hasNext => next != null;

  static LinkedListNode<T> mergeSort<T extends Comparable>(
      LinkedListNode<T> head) {
    if (head == null || head.length == 1) {
      return head;
    }
    SplitLinkedList<T> splitLists = LinkedListNode.split(head);

    LinkedListNode sortedA = LinkedListNode.mergeSort(splitLists.a);
    LinkedListNode sortedB = LinkedListNode.mergeSort(splitLists.b);

    return LinkedListNode.sortedMerge(sortedA, sortedB);
  }

  static LinkedListNode<T> sortedMerge<T extends Comparable>(
      LinkedListNode<T> headA, LinkedListNode<T> headB) {
    if (headA == null) {
      return headB;
    }
    if (headB == null) {
      return headA;
    }

    if (headA.value.compareTo(headB.value) < 0) {
      headA.next = sortedMerge(headA.next, headB);
      return headA;
    } else {
      headB.next = sortedMerge(headA, headB.next);
      return headB;
    }
  }

  static SplitLinkedList<T> split<T>(LinkedListNode<T> headOriginal) {
    assert(headOriginal != null);

    int lengthO = headOriginal.length;
    int lengthA = lengthO ~/ 2; //implicitely round down

    LinkedListNode headA = headOriginal;
    LinkedListNode headB = headOriginal;
    LinkedListNode workingNode = headOriginal;

    for (int i = 0; i < lengthO; i++) {
      if (i == lengthA - 1) {
        headB = workingNode.next;
        workingNode.next = null;
        headA = headOriginal;
        return new SplitLinkedList(headA, headB);
      }
      workingNode = workingNode.next;
    }
    return null;
  }
}

class SplitLinkedList<T> {
  final LinkedListNode<T> a;
  final LinkedListNode<T> b;
  SplitLinkedList(this.a, this.b);
}
