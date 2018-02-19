// Implement a function that takes two strings, s and x, as arguments and finds the first occurrence of the string x in s. The function should return an integer indicating the index in s of the first occurrence of x. If there are no occurrences of x in s, return -1.

void main() {
  print(firstStrOcc("Hello", "Hello, World!")); //0
  print(firstStrOcc("Hallo", "Hello, World!")); //-1
  print(firstStrOcc("World", "Hello, World!")); //7
  print(firstStrOcc("!", "Hello, World!")); //12
  print(firstStrOcc("", "Hello, World!")); //0
  print(firstStrOcc("World", "")); //-1
  print(firstStrOcc("", "")); //0
}

/// Returns the index of the first occurrence of pattern in aString.
/// If there are no occurrences, it returns -1.
/// Operates in O(n*m)
int firstStrOcc(String pattern, String aString) {

  for (int i = 0; i <= aString.length - pattern.length; i++) {
    bool matches = true;
    for (int j = 0; j < pattern.length; j++) {
      matches = matches && (pattern[j] == aString[i + j]);
    }
    if(matches) {
      return i;
    }
  }
  
  return -1;
}
