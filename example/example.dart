import 'package:lindenmayer_systems/src/lindenmayer_systems/dol_system/dol_system.dart';
import 'package:lindenmayer_systems/src/production_rules/production_rule.dart';

void main() {
  /// [DolSystem] Examples

  final testDolSystem = DolSystem(
    alphabet: ['A', 'B'],
    axiom: 'AB',
    productionRuleSet: {
      ProductionRule(predecessor: 'A', successor: 'AB'),
      ProductionRule(predecessor: 'B', successor: 'BA'),
    },
  );

  // Expected result is ABBA
  print(testDolSystem.generate(1));

  testDolSystem.generateAsStream(2)
    ..listen(
      // Should print (ABBA, 1) and ('ABBABAAB', 2)
      print,
    );
}
