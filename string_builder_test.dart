import "package:test/test.dart";
import 'string_builder.dart';

void main() {
  test("Empty StringBuilder should be the empty String", () {
    StringBuilder sb = new StringBuilder();
    expect(sb.toString(), equals(""));
  });

  test("StringBuilder should support adding codepoints", () {
    StringBuilder sb = new StringBuilder();

    expect(sb.length, equals(0));

    sb.appendChar("h".runes.first);
    sb.appendChar("e".runes.first);
    sb.appendChar("l".runes.first);
    sb.appendChar("l".runes.first);
    sb.appendChar("o".runes.first);
    expect(sb.toString(), equals("hello"));
  });

  test("StringBuilder should support adding strings", () {
    StringBuilder sb = new StringBuilder();

    sb.appendString("h");
    sb.appendString("ello");
    expect(sb.toString(), equals("hello"));
  });

  test("StringBuilder should support adding codepoints and strings", () {
    StringBuilder sb = new StringBuilder();

    sb.appendChar("h".runes.first);
    sb.appendChar("e".runes.first);
    sb.appendChar("l".runes.first);
    sb.appendChar("l".runes.first);
    sb.appendChar("o".runes.first);
    sb.appendString(", world");
    expect(sb.toString(), equals("hello, world"));
  });

  test("StringBuilder should support chaining", () {
    StringBuilder sb = new StringBuilder()
        .appendChar("h".runes.first)
        .appendChar("e".runes.first)
        .appendString("ll")
        .appendChar("o".runes.first);

    sb.appendChar(",".runes.first);
    sb.appendChar(" ".runes.first).appendString("world");
    expect(sb.toString(), equals("hello, world"));
  });

  test("StringBuilder should support unicode and report the correct length",
      () {
    StringBuilder sb = new StringBuilder();

    sb.appendChar("😀".runes.first);
    sb.appendChar("♜".runes.first);
    sb.appendString("🤡");
    sb.appendString("Þ");
    expect(sb.toString(), equals("😀♜🤡Þ"));
    expect(sb.length, equals("😀♜🤡Þ".runes.length));
  });
}
