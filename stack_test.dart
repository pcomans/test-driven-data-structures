import "package:test/test.dart";
import 'stack.dart';

void main() {
  test("Empty stack should be empty, non empty stack should not", () {
    Stack<String> s = new Stack();
    expect(s.isEmpty(), equals(true));
    s.push("?");
    expect(s.isEmpty(), equals(false));
  });
  test("Stack should support pushing, peeking and popping", () {
    Stack<int> s = new Stack();
    s.push(1);
    expect(s.peek(), equals(1));
    expect(s.pop(), equals(1));
    expect(s.peek(), equals(null));
    expect(s.pop(), equals(null));

    s.push(1);
    s.push(2);
    s.push(3);
    s.push(4);
    s.push(1);
    expect(s.pop(), equals(1));
    expect(s.pop(), equals(4));
    expect(s.pop(), equals(3));
    expect(s.pop(), equals(2));
    expect(s.pop(), equals(1));
  });
}
