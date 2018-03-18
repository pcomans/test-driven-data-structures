import "stack.dart";

class MyQueue<T> {
  Stack<T> stack = new Stack();
  void queue(T value) => stack.push(value);
  T dequeue() {
    // Stack is FIFO, reverse it to return the last element
    Stack<T> reverse = new Stack();
    while (!stack.isEmpty()) {
      reverse.push(stack.pop());
    }
    T last = reverse.pop();

    // Return stack to original shape, minus last element
    while (!reverse.isEmpty()) {
      stack.push(reverse.pop());
    }
    return last;
  }
  bool isEmpty() => stack.isEmpty();
}