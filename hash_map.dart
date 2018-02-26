class Entry<K, V> {
  final K key;
  final V value;
  Entry(this.key, this.value);

  String toString() => "($key, $value)";
}

class HashMap<K, V> {
  List<List<Entry<K, V>>> _buckets;
  int _numEntries = 0;
  double fillRate;

  HashMap({int initialSize = 8, this.fillRate = 0.66}) {
    _buckets = new List.generate(
      initialSize,
      (_) => new List<Entry<K, V>>(),
      growable: false,
    );
  }

  bool _set(K key, V value, List<List<Entry<K, V>>> buckets) {
    List bucket = buckets[_getHashCode(key, buckets.length)];
    Entry existing = bucket.firstWhere((e) => e.key == key, orElse: () => null);

    bool hasExisting = existing != null;
    if (hasExisting) {
      bucket.remove(existing);
    }
    bucket.add(new Entry(key, value));
    return hasExisting;
  }

  void set(K key, V value) {
    if (_numEntries > _buckets.length * fillRate) {
      List<List<Entry<K, V>>> newBuckets = new List.generate(
        _buckets.length * 2,
        (_) => new List<Entry<K, V>>(),
        growable: false,
      );

      _buckets.forEach((bucket) {
        bucket.forEach((e) {
          _set(e.key, e.value, newBuckets);
        });
      });
      _buckets = newBuckets;
    }

    bool existing = _set(key, value, _buckets);
    if (!existing) {
      _numEntries++;
    }
  }

  V get(K key) {
    List bucket = _buckets[_getHashCode(key, _buckets.length)];
    Entry e = bucket.firstWhere((e) => e.key == key);

    return e.value;
  }

  V delete(K key) {
    List bucket = _buckets[_getHashCode(key, _buckets.length)];
    Entry e = bucket.firstWhere((e) => e.key == key, orElse: () => null);

    if (e != null) {
      bucket.remove(e);
      _numEntries--;
      return e.value;
    } else {
      throw new Exception("Could not find $key");
    }
  }

  int _getHashCode(K key, int numBuckets) => key.hashCode % numBuckets;

  int get length => _numEntries;
}
