import '../lindenmayer_systems/dol_system/dol_system.dart';
import '../production_rules/production_rule.dart';

/// {@template LindenmayerSystem}
///
/// An abstract representation of a Lindenmayer System, or L-System.
///
/// An L-System is a formal grammar, described by the following
/// triplet:
///
/// G = {V, ω, P}
///
/// Where V is the system's alphabet, ω is the system's axiom and P is the
/// system's production rule set.
///
/// In other words, an L-System is composed of three things:
///
/// - A list of [String] representing the system's [alphabet].
/// - A [String] representing the system's starting point, or the [axiom].
/// - A set of [ProductionRule].
///
/// Because some Lindenmayer System types behave differently when it comes to
/// rules (see [DolSystem] as an example), they are not present in this
/// abstraction.
///
///{@endtemplate}
abstract class LindenmayerSystem {
  /// {@macro LindenmayerSystem}
  LindenmayerSystem({
    required this.axiom,
    required this.alphabet,
  }) {
    for (var i = 0; i < axiom.length; i++) {
      final symbolToCompare = axiom[i];
      assert(
        alphabet.contains(symbolToCompare),
        '''Axiom can only have symbols from alphabet. 
        $symbolToCompare was not found in $alphabet''',
      );
    }
  }

  ///
  /// The L-System's axiom. Has to be made up of symbols in [alphabet].
  ///
  final String axiom;

  ///
  /// The L-System's alphabet.
  ///
  final List<String> alphabet;

  /// {@template generate}
  ///
  /// How the L-System will generate its string output for a number of
  /// [iterations].
  ///
  /// {@endtemplate}
  String generate(int iterations);

  ///
  /// {@macro generate}
  ///
  /// Returns each iteration's value via [Stream] in a (String,int) record
  /// with the iteration's sentence and number respectively.
  ///
  Stream<(String sentence, int iteration)> generateAsStream(int iterations);
}
