import 'package:lindenmayer_systems/src/lindenmayer_systems/dol_system/dol_system.dart';
import 'package:lindenmayer_systems/src/production_rules/production_rules.dart';
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
      test(
        'generate',
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
}
