// Implement a function that takes two strings, s and x, as arguments and finds the first occurrence of the string x in s. The function should return an integer indicating the index in s of the first occurrence of x. If there are no occurrences of x in s, return -1.

void main() {
  print(firstStrOccFast("Hello", "Hello, World!")); //0
  print(firstStrOccFast("Hallo", "Hello, World!")); //-1
  print(firstStrOccFast("World", "Hello, World!")); //7
  print(firstStrOccFast("!", "Hello, World!")); //12
  print(firstStrOccFast("", "Hello, World!")); //0
  print(firstStrOccFast("World", "")); //-1
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
    if (matches) {
      return i;
    }
  }

  return -1;
}

int firstStrOccFast(String pattern, String aString) {
  int pLength = pattern.length;
  List<int> zString = getZString("$pattern\$$aString");
  print(zString);
  for (int i = 0; i < zString.length; i++) {
    if(zString[i] == pLength) {
      return i - (pLength + 1);
    }
  }
  return -1;
}

// https://courses.csail.mit.edu/6.006/spring11/lectures/lec18-extra.pdf
// https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/zalg.pdf
// http://codeforces.com/blog/entry/3107
List<int> getZString(String s) {
  int n = s.length;

  int l = -1;
  int r = -1;

  List<int> z = new List.filled(n, null);

  for (int i = 1; i < n; i++) {
    if (i > r) {
      // Explicitly compute Zk by comparing with prefix.
      l = r = i;
      while (r < n && s[r - l] == s[r]) {
        r++;
      }
      r--; // we shouldn't have incremented r in the last iteration
      z[i] = (r + 1) - l; //Get the length of the prefix
    } else {
      // the current [L, R] extends at least to i
      int k = i - l;
      if (z[k] < r - i + 1) {
        z[i] = z[k];
      } else {
        l = i;
        while (r < n && s[r - l] == s[r]) {
          r++;
        }
        r--; // we shouldn't have incremented r in the last iteration
        z[i] = (r + 1) - l; //Get the length of the prefix
      }
    }
  }
  return z;
}
