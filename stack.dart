import "linked_list.dart";

class Stack<T> {
  LinkedListNode<T> top;
  void push(T value) {
    LinkedListNode newTop = new LinkedListNode(value);
    if (top != null) {
      newTop.next = top;
    }
    top = newTop;
  }
  T pop() {
    LinkedListNode<T> popped = top;
    top = top?.next;
    return popped?.value;
  }
  T peek() => top?.value;
  bool isEmpty() => top == null;
}
