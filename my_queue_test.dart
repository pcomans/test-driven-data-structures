import "package:test/test.dart";
import 'my_queue.dart';

void main() {
  test("Empty queue should be empty, non empty queue should not", () {
    MyQueue<String> s = new MyQueue();
    expect(s.isEmpty(), equals(true));
    s.queue("?");
    expect(s.isEmpty(), equals(false));
  });

  test("Queue should support queuing and dequeuing", () {
    MyQueue<String> s = new MyQueue();
    expect(s.dequeue(), equals(null));
    s.queue("What's");
    expect(s.dequeue(), equals("What's"));
    s.queue("up");
    s.queue("my");
    s.queue("dudes");
    expect(s.dequeue(), equals("up"));
    expect(s.dequeue(), equals("my"));
    expect(s.dequeue(), equals("dudes"));
  });
}
