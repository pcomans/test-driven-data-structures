/// Determine if a string has all unique characters.
bool isUnique(String s) {
  List<int> runes = _getSortedRuneList(s);

  int oldRune = -1;
  for (int i = 0; i < runes.length; i++) {
    if (runes[i] == oldRune) {
      return false;
    }
    oldRune = runes[i];
  }
  return true;
}

/// decide if one String is a permutation of the other.
bool checkPermutation(String s1, String s2) {
  List<int> runes1 = _getSortedRuneList(s1);
  List<int> runes2 = _getSortedRuneList(s2);

  if (runes1.length != runes2.length) {
    return false;
  }

  for (int i = 0; i < runes1.length; i++) {
    if (runes1[i] != runes2[i]) {
      return false;
    }
  }

  return true;
}

/// Write a method to replace all spaces in a string with '%20  You may assume that the string has suf cient space at the end to hold the additional characters,and that you are given the "true" length of the string.
String urlify(String s, int length) {
  List<int> runes = s.runes.toList(growable: false);
  Runes replacement = "%20".runes;
  int spaceRune = " ".runes.first;

  int targetLength = length;

  for (int i = 0; i < targetLength; i++) {
    if (runes[i] == spaceRune) {
      for (int j = targetLength - 1; j > i; j--) {
        runes[j + 2] = runes[j];
      }
      runes[i] = replacement.elementAt(0);
      runes[i + 1] = replacement.elementAt(1);
      runes[i + 2] = replacement.elementAt(2);

      targetLength += 2;
    }
  }
  return new String.fromCharCodes(runes);
}

List<int> _getSortedRuneList(String s) => s.runes.toList()..sort();

bool isPalindromePermutation(String s) {
  List<int> runes = s.toLowerCase().runes.toList(growable: false)..sort();
  int spaceRune = " ".runes.first;

  int previousRune = -1;
  int cardinality = 0;
  int unevenCardinalities = 0;

  // A palindrome is a string where at most one character has a cardinality that's not divisible by 2.
  for (int i = 0; i < runes.length; i++) {
    int currentRune = runes[i];
    if (currentRune == spaceRune) {
      continue;
    }

    if (currentRune != previousRune) {
      if (cardinality % 2 != 0) {
        unevenCardinalities++;
      }
      cardinality = 1; // We've already seen a new character
      previousRune = currentRune;
    } else {
      cardinality += 1;
    }
  }

  if (cardinality % 2 != 0) {
    unevenCardinalities++;
  }

  return (unevenCardinalities <= 1);
}

void main() {
  isPalindromePermutation("Tact Coa");
}