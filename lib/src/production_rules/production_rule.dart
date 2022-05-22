///{@template ProductionRule}
///
/// A class representing an L-System's production rule.
///
/// A [ProductionRule] consists of a [predecessor] and a [successor].
/// If [predecessor] is found when we are rewriting an L-System's string,
/// we replace it by its [successor].
///
/// An example follows:
///
/// Assume we have an axiom "AAB" and a production rule that states that
/// predecessor "A" turns into successor "AB". By following this logic,
/// axiom "AAB" will turn into "ABABB" on the first iteration of the
/// L-System's output generation.
///
///{@endtemplate}
class ProductionRule {
  /// {@macro ProductionRule}
  ProductionRule({
    required this.predecessor,
    required this.successor,
  }) : assert(
          predecessor.length == 1,
          'predecessor length must be 1',
        );

  ///
  /// The production rule's predecessor. This represents a symbol we will
  /// try to find when generating an L-System's output.
  ///
  final String predecessor;

  ///
  /// The production rule's successor. This represents a sequence of symbols
  /// that will replace [predecessor] if the latter is found when generating
  /// an L-System's output.
  ///
  final String successor;
}
