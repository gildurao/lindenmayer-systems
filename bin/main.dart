import 'package:lindenmayer_systems/src/lindenmayer_systems/dol_system/dol_system.dart';
import 'package:lindenmayer_systems/src/production_rules/production_rule.dart';

void main() {
  final test = DolSystem(
    alphabet: ['A', 'B'],
    axiom: 'AB',
    productionRuleSet: {
      ProductionRule(predecessor: 'A', successor: 'AB'),
      ProductionRule(predecessor: 'B', successor: 'BA'),
    },
  );

  final result = test.generate(1);

  // Expected result is ABBA
  print(result);
}
