import 'dart:math';
import 'package:flutter/material.dart';
import '../models/app_settings.dart';

/// Boîte qui se divise au clic.
class DivisibleBox extends StatefulWidget {
  final bool isRectangle;
  final int depth;
  final int maxDepth;
  final AppSettings settings;

  const DivisibleBox({
    super.key,
    required this.isRectangle,
    required this.depth,
    required this.maxDepth,
    required this.settings,
  });

  @override
  State<DivisibleBox> createState() => _DivisibleBoxState();
}

class _DivisibleBoxState extends State<DivisibleBox> {
  static final Random _random = Random();

  bool _divided = false;

  // Couleur aléatoire tirée une seule fois pour cette forme
  late final Color _randomColor = HSVColor.fromAHSV(
    1,
    _random.nextDouble() * 360,
    0.5 + _random.nextDouble() * 0.4,
    0.8 + _random.nextDouble() * 0.2,
  ).toColor();

  @override
  Widget build(BuildContext context) {
    if (_divided) {
      final childIsRectangle = !widget.isRectangle;

      final children = List.generate(
        2,
        (_) => Expanded(
          child: DivisibleBox(
            isRectangle: childIsRectangle,
            depth: widget.depth + 1,
            maxDepth: widget.maxDepth,
            settings: widget.settings,
          ),
        ),
      );

      // Rectangle -> division verticale (côte à côte)
      // Carré     -> division horizontale (l'un au-dessus de l'autre)
      return widget.isRectangle
          ? Row(children: children)
          : Column(children: children);
    }

    final bool canDivide = widget.depth < widget.maxDepth;

    return ListenableBuilder(
      listenable: widget.settings,
      builder: (context, _) {
        final s = widget.settings;
        final Color color = s.randomColors
            ? _randomColor
            : (widget.isRectangle ? s.rectangleColor : s.squareColor);

        return GestureDetector(
          onTap: canDivide
              ? () {
                  s.onDivide(wasRectangle: widget.isRectangle);
                  setState(() => _divided = true);
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: s.borderWidth > 0
                  ? Border.all(color: const Color.fromARGB(221, 254, 251, 251), width: s.borderWidth)
                  : null,
            ),
          ),
        );
      },
    );
  }
}