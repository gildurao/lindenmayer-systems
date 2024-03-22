import '../../production_rules/production_rule.dart';
import '../lindenmayer_system.dart';

/// {@template DolSystem}
///
/// A class representing a Deterministic Context-free L-System, or DOL-System.
///
/// DOL-Systems can be considered the simplest Lindenmayer Systems because of
/// their deterministic and context-free nature, meaning that the production
/// rules of the system are applied as is, i.e., the output of the L-System
/// will always be the same.
///
/// The rules found in [productionRuleSet] must have predecessors and succesors
/// made up of symbols found in the [DolSystem]'s [alphabet]. There cannot
/// also be mutliple [ProductionRule] instances with the same predecessor.
///
/// {@endtemplate}
class DolSystem extends LindenmayerSystem {
  /// {@macro DolSystem}
  DolSystem({
    required List<String> alphabet,
    required String axiom,
    required this.productionRuleSet,
  }) : super(
          axiom: axiom,
          alphabet: alphabet,
        ) {
    final predecessorList = <String>[];
    for (final productionRule in productionRuleSet) {
      assert(
        alphabet.contains(productionRule.predecessor),
        ''' Production rule predecessors have to be symbols from alphabet.
        ${productionRule.predecessor} was not found in $alphabet.
        ''',
      );
      for (var i = 0; i < productionRule.successor.length; i++) {
        final symbolToCompare = productionRule.successor[i];
        assert(
          alphabet.contains(symbolToCompare),
          '''Production rule successors can only have symbols from alphabet. 
        $symbolToCompare was not found in $alphabet''',
        );
      }
      predecessorList.add(productionRule.predecessor);
    }
    final predecessorListAsSet = predecessorList.toSet();
    assert(
      predecessorList.length == predecessorListAsSet.length,
      ''' Production rules with the same predecessor were found.
      Production rules must have unique predecessors.
      ''',
    );
  }

  ///
  /// The set of production rules for [DolSystem].
  /// These dictate how the system's output is generated at [generate].
  ///
  final Set<ProductionRule> productionRuleSet;

  @override
  String generate(
    int iterations,
  ) {
    assert(
      !iterations.isNegative,
      'iterations must be equal to or greater than zero',
    );
    if (iterations == 0) {
      return axiom;
    }

    var sentence = axiom;

    while (iterations != 0) {
      var nextGeneration = StringBuffer();
      for (var i = 0; i < sentence.length; i++) {
        final currentSymbol = sentence[i];
        var replace = currentSymbol;
        for (final productionRule in productionRuleSet) {
          final predecessor = productionRule.predecessor;
          if (predecessor == currentSymbol) {
            replace = productionRule.successor;
            break;
          }
        }
        nextGeneration.write(replace);
      }
      sentence = nextGeneration.toString();
      iterations--;
    }

    return sentence;
  }

  @override
  Stream<(String sentence, int iteration)> generateAsStream(
    int iterations,
  ) async* {
    if (iterations.isNegative) {
      yield* Stream.error(
        AssertionError(
          'iterations must be equal to or greater than zero',
        ),
      );
      return;
    }
    if (iterations == 0) {
      yield (axiom, 0);
      return;
    }

    var sentence = axiom;
    final totalAmountOfIterations = iterations;

    while (iterations != 0) {
      var nextGeneration = StringBuffer();
      for (var i = 0; i < sentence.length; i++) {
        final currentSymbol = sentence[i];
        var replace = currentSymbol;
        for (final productionRule in productionRuleSet) {
          final predecessor = productionRule.predecessor;
          if (predecessor == currentSymbol) {
            replace = productionRule.successor;
            break;
          }
        }
        nextGeneration.write(replace);
      }
      sentence = nextGeneration.toString();
      iterations--;
      yield (sentence, totalAmountOfIterations - iterations);
    }
  }
}
