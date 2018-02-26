import "package:test/test.dart";
import 'interview_questions_1.dart';

void main() {
  test("isUnique", () {
    expect(isUnique("abc"), equals(true));
    expect(isUnique("aabc"), equals(false));
    expect(isUnique("abcabc"), equals(false));
    expect(isUnique("cba"), equals(true));
  });

  test("checkPermutation", () {
    expect(checkPermutation("abc", "bca"), equals(true));
    expect(checkPermutation("", ""), equals(true));
    expect(checkPermutation("abc", ""), equals(false));
    expect(checkPermutation("abc", "ab"), equals(false));
    expect(checkPermutation("abc", "bcaa"), equals(false));
    expect(checkPermutation("rail safety", "fairy tales"), equals(true));
  });

  test("urlify", () {
    expect(urlify("abc", 3), equals("abc"));
    expect(urlify("   ", 1), equals("%20"));
    expect(urlify("J D  ", 3), equals("J%20D"));
    expect(urlify("A big hippo    ", 11), equals("A%20big%20hippo"));
    expect(urlify("hello  world    ", 12), equals("hello%20%20world"));
  });
}
