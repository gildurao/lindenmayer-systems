# lindenmayer_systems

A Dart library to handle generative grammars known as L-Systems (Lindenmayer Systems).

## What are L-Systems (Lindenmayer Systems)?

Lindenmayer Systems (L-Systems) were initially proposed by [Aristid Lindenmayer](https://en.wikipedia.org/wiki/Aristid_Lindenmayer) as a way to
mathematically model plant development. At their core, L-Systems are parallel generative
grammars. L-Systems then vary according to the type of production rules they employ. The
simplest type of L-Systems, which are deterministic and context free, or DOL-systems, can be
formally defined as follows:

*“Let V denote an alphabet, V∗ the set of all words over V, and V+ the set of all nonempty
words over V.* 

*A string OL-system is an ordered triplet G = {V, ω, P} where V is the alphabet of the system, ω ∈ V + is a nonempty word called the axiom and P ⊂ V × V ∗ is a finite set of
productions.* 

*A production (a, χ) ∈ P is written as a → χ. The letter a and the word χ are called the predecessor and the successor of this production, respectively. It is assumed that for any letter a ∈ V, there is at least one-word χ ∈ V ∗ such that a → χ. If no production is explicitly specified for a given predecessor a ∈ V, the identity production a → a is assumed to belong to the set of productions P. An OL-system is deterministic (noted DOL-system) if and only if for each a ∈ V there is exactly one χ ∈ V ∗ such that a → χ.” p.40 [1]*


To showcase this definition, a DOL-system is presented below:

Alphabet V is comprised of the letters {a,b}.

Let the production rules be:

a → ab

b → a


If we consider our axiom as b, then we get the following first five iterations:

• Iteration 0: “b”

• Iteration 1: “a”

• Iteration 2: “ab”

• Iteration 3: “aba”

• Iteration 4: “abaab”

• Iteration 5: “abaababa”

If we take the length of each production string, we can verify the existence of the Fibonacci Sequence. Due to their origins, L-Systems were rapidly translated to a graphical interpretation, using what is known as turtle graphics, based on the LOGO programming language [2]. The procedure for this is to map letters of the L-System’s alphabet to graphical movements that will be executed by the turtle, consequently altering its state, once all iterations are ran. The state of the turtle is represented by the triplet (x,y,α), where (x,y) represents the turtle’s Cartesian coordinates and α denotes the turtle’s heading, i.e., the direction in which it is heading. Typically, the following symbols are used in alphabets [1], [2]:

• F, move the turtle forward by a length of d and draw a line between (x,y) and (x’,y’).
12

• f, move the turtle forward by a length of d without drawing a line.

• +, turn the turtle left by angle +δ.

• -, turn the turtle right by angle -δ.

• [, save the turtle’s current state.

• ], pop the turtle’s current state.

Even with simple production rules, one can obtain rather interesting and visually appealing drawings resembling plants or leaves. It is also possible to draw fractal shapes. See some examples below:

![Bush](https://raw.githubusercontent.com/gildurao/lindenmayer-systems/main/readme_assets/bush.png)
![DragonCurveFractal](https://raw.githubusercontent.com/gildurao/lindenmayer-systems/main/readme_assets/dragon_curve.png)
![SierpinskiTriangle](https://raw.githubusercontent.com/gildurao/lindenmayer-systems/main/readme_assets/sierpinski_triangle.png)

(These images were generated with Flutter!)

You can also apply a musical interpretation instead of a graphical one to L-Systems.

Listen to some examples below:

https://soundcloud.com/user-62526899/sets/l-music-polyphonic-interpretation-on-l-systems-using-2-symbols

https://soundcloud.com/user-62526899/sets/l-music-polyphonic-interpretations-on-l-systems

https://soundcloud.com/user-62526899/sets/l-music-scale-based

https://soundcloud.com/user-62526899/sets/l-music-random-interpretations-of-l-systems

## Usage

### D0L-Systems

```dart
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
      // Prints (ABBA, 1) and ('ABBABAAB', 2)
      print,
    );
}
```

## Library Roadmap

[X] - Support D0L-Systems

[] - Support Dil-Systems

[] - Support Stochastic L-Systems

[] - Support Table L-Systems

## References

[1] - P. Prusinkiewicz and A. Lindenmayer, The Algorithmic Beauty of Plants. New York:
Springer Verlag, 1990. Available at: http://algorithmicbotany.org/papers/#abop

[2] - P. Prusinkiewicz, “Graphical applications of L-systems,” in Proceedings of Graphics
Interface ’86 / Vision Interface ’86, 1986, pp. 247–253.