import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'counter_card.dart';
import 'divisible_box.dart';

/// Onglet 1 : compteur + rectangle divisible.
class DrawingTab extends StatefulWidget {
  final AppSettings settings;
  const DrawingTab({super.key, required this.settings});

  @override
  State<DrawingTab> createState() => _DrawingTabState();
}

class _DrawingTabState extends State<DrawingTab>
    with AutomaticKeepAliveClientMixin {
  // Garde le dessin en vie quand on change d'onglet
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ListenableBuilder(
            listenable: widget.settings,
            builder: (context, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   CounterCard(
                    label: 'Total',
                    value: widget.settings.totalCount,
                    icon: Icons.category,
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              // Largeur = 2 x hauteur : la 1re division donne 2 vrais carrés
              child: AspectRatio(
                aspectRatio: 2,
                child: DivisibleBox(
                  isRectangle: true,
                  depth: 0,
                  maxDepth: 6,
                  settings: widget.settings,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}