class StringBuilder {
  List<int> _characters = new List(4);
  int _length = 0;

  StringBuilder appendChar(int char) {
    if (_length == _characters.length) {
      List<int> _newChars = new List(_characters.length * 2);
      _newChars.setAll(0, _characters);
      _characters = _newChars;
    }

    _characters[_length] = char;
    _length++;
    return this;
  }

  StringBuilder appendString(String chars) {
    chars.runes.forEach((int c) => appendChar(c));
    return this;
  }

  String toString() => new String.fromCharCodes(_characters.take(_length));
  int get length => _length;
}
