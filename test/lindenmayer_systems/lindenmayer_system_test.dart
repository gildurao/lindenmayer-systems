import 'package:lindenmayer_systems/lindenmayer_systems.dart';
import 'package:test/test.dart';

class TestLindenmayerSystem extends LindenmayerSystem {
  TestLindenmayerSystem({
    required super.axiom,
    required super.alphabet,
  });

  @override
  String generate(int iterations) {
    return '';
  }

  @override
  Stream<(String, int)> generateAsStream(int iterations) {
    return Stream.value(('', 0));
  }
}

void main() {
  group(
    'LindenmayerSystem',
    () {
      test(
        'throws AssertionError if axiom has symbols not in the alphabet',
        () {
          expect(
            () => TestLindenmayerSystem(axiom: 'C', alphabet: ['A', 'B']),
            throwsA(isA<AssertionError>()),
          );
        },
      );
    },
  );
}
