import 'package:lindenmayer_systems/lindenmayer_systems.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Production Rule',
    () {
      test(
        'throws assertion error if predecessor length is greater than one',
        () {
          expect(
            () => ProductionRule(predecessor: 'AAA', successor: 'BBB'),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      test(
        'throws assertion error if predecessor length is less than one',
        () {
          expect(
            () => ProductionRule(predecessor: '', successor: 'BBB'),
            throwsA(isA<AssertionError>()),
          );
        },
      );
    },
  );
}
