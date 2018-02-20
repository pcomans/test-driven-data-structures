// Print all positive integer solutions to the equation a^3 + b^3 = c^3 + d^3, where a, b, c and d are integers between 1 and 1000.

import 'dart:math';

void main() {
  Map<int, List<Tuple>> results = {};

  for (int a = 0; a <= 1000; a++) {
    for (int b = 0; b <= 1000; b++) {
      int result = pow(a, 3) + pow(b, 3);
      if (!results.containsKey(result)) {
        results[result] = new List<Tuple>();
      }
      results[result].add(new Tuple(a, b));
    }
  }

  results.keys.forEach((r) {
    List<Tuple> tuples = results[r];
    for (int i = 0; i < tuples.length; i++) {
      for (int j = 0; j < tuples.length; j++) {
        int a = tuples[i].a;
        int b = tuples[i].b;
        int c = tuples[j].a;
        int d = tuples[j].b;

        // Print "interesting" results only
        if (!(a == c && b == d) && !(a == d && b == c)) {
          print('$a³ + $b³ = $c³ + $d³ = $r');
        }
      }
    }
  });
}

class Tuple {
  final int a;
  final int b;

  Tuple(this.a, this.b);
  String toString() => "($a, $b)";
}
