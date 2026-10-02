import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'color_picker.dart';

/// Onglet 2 : paramètres.
class SettingsTab extends StatelessWidget {
  final AppSettings settings;
  const SettingsTab({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Épaisseur de la bordure : '
              '${settings.borderWidth.toStringAsFixed(1)} px',
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              min: 0,
              max: 10,
              divisions: 20,
              value: settings.borderWidth,
              onChanged: settings.setBorderWidth,
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Couleurs aléatoires'),
              subtitle: const Text('Chaque forme a sa propre couleur'),
              value: settings.randomColors,
              onChanged: settings.setRandomColors,
            ),
            if (!settings.randomColors) ...[
              const SizedBox(height: 8),
              ColorPicker(
                label: 'Couleur des carrés',
                selected: settings.squareColor,
                onChanged: settings.setSquareColor,
              ),
              const SizedBox(height: 16),
              ColorPicker(
                label: 'Couleur des rectangles',
                selected: settings.rectangleColor,
                onChanged: settings.setRectangleColor,
              ),
            ],
          ],
        );
      },
    );
  }
}