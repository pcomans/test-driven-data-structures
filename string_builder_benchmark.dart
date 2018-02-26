import "string_builder.dart";
import 'package:benchmark_harness/benchmark_harness.dart';

int NUM_ITEMS = 10000;

class StringBenchmark extends BenchmarkBase {
  const StringBenchmark() : super("String");

  static void main() {
    new StringBenchmark().report();
  }

  // The benchmark code.
  void run() {
    String s = "";
    for (int i = 0; i < NUM_ITEMS; i++) {
      s += new String.fromCharCode(i);
    }
    s.toString();
  }
}

class StringBufferBenchmark extends BenchmarkBase {
  const StringBufferBenchmark() : super("StringBuffer");

  static void main() {
    new StringBufferBenchmark().report();
  }

  // The benchmark code.
  void run() {
    StringBuffer s = new StringBuffer();
    for (int i = 0; i < NUM_ITEMS; i++) {
      s.writeCharCode(i);
    }
    s.toString();
  }
}

class StringBuilderBenchmark extends BenchmarkBase {
  const StringBuilderBenchmark() : super("StringBuilder");

  static void main() {
    new StringBuilderBenchmark().report();
  }

  // The benchmark code.
  void run() {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < NUM_ITEMS; i++) {
      sb.appendChar(i);
    }
    sb.toString();
  }
}

// Main function runs the benchmark.
main() {
  StringBenchmark.main();
  StringBufferBenchmark.main();
  StringBuilderBenchmark.main();
}
