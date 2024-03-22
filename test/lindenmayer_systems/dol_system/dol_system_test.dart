import 'package:lindenmayer_systems/lindenmayer_systems.dart';
import 'package:test/test.dart';

void main() {
  group(
    'DolSystem',
    () {
      test(
        '''throws AssertionError if production rules have predecessor symbols
        that are not in alphabet''',
        () {
          expect(
            () => DolSystem(
              alphabet: ['A', 'B'],
              axiom: 'ABA',
              productionRuleSet: {
                ProductionRule(
                  predecessor: 'C',
                  successor: 'ABB',
                ),
              },
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      test(
        '''throws AssertionError if production rules have successor symbols
        that are not in alphabet''',
        () {
          expect(
            () => DolSystem(
              alphabet: ['A', 'B'],
              axiom: 'ABA',
              productionRuleSet: {
                ProductionRule(
                  predecessor: 'A',
                  successor: 'CA',
                ),
              },
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      test(
        '''throws AssertionError if there are production rules with the same
        predecessor''',
        () {
          expect(
            () => DolSystem(
              alphabet: ['A', 'B'],
              axiom: 'ABA',
              productionRuleSet: {
                ProductionRule(
                  predecessor: 'A',
                  successor: 'AB',
                ),
                ProductionRule(
                  predecessor: 'A',
                  successor: 'BB',
                ),
              },
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      group(
        'generate',
        () {
          test(
            'throws AssertionError if iterations is negative',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              expect(
                () => test.generate(-1),
                throwsA(isA<AssertionError>()),
              );
            },
          );
          test(
            'returns axiom if iterations is zero',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              final result = test.generate(0);

              expect(result, 'AB');
            },
          );

          test(
            'returns generated sentence if iterations is greater than zero',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              final result = test.generate(1);

              expect(result, 'ABBA');
            },
          );
        },
      );

      group(
        'generateAsStream',
        () {
          test(
            'throws AssertionError if iterations is negative',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              final result = test.generateAsStream(-1);

              expectLater(
                result,
                emitsError(
                  isA<AssertionError>(),
                ),
              );
            },
          );
          test(
            'emits axiom if iterations is zero',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              final result = test.generateAsStream(0);

              expect(
                result,
                emitsInOrder(
                  const [
                    ('AB', 0),
                  ],
                ),
              );
            },
          );
          test(
            'emits each iteration\'s generated sentence',
            () {
              final test = DolSystem(
                alphabet: ['A', 'B'],
                axiom: 'AB',
                productionRuleSet: {
                  ProductionRule(predecessor: 'A', successor: 'AB'),
                  ProductionRule(predecessor: 'B', successor: 'BA'),
                },
              );

              final result = test.generateAsStream(2);

              expect(
                result,
                emitsInOrder(
                  const [
                    ('ABBA', 1),
                    ('ABBABAAB', 2),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
