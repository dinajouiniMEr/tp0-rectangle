import 'package:flutter/material.dart';

/// Réglages et compteurs partagés par toute l'application.
class AppSettings extends ChangeNotifier {
  double borderWidth = 1.5;
  bool randomColors = true;
  Color squareColor = Colors.blue;
  Color rectangleColor = Colors.orange;

  // Au départ : 1 grand rectangle, 0 carré
  int squareCount = 0;
  int rectangleCount = 1;
  // Nombre total de formes (carrés + rectangles)
  int get totalCount => squareCount + rectangleCount;

  void setBorderWidth(double value) {
    borderWidth = value;
    notifyListeners();
  }

  void setRandomColors(bool value) {
    randomColors = value;
    notifyListeners();
  }

  void setSquareColor(Color color) {
    squareColor = color;
    notifyListeners();
  }

  void setRectangleColor(Color color) {
    rectangleColor = color;
    notifyListeners();
  }

  /// Appelé à chaque division : une forme disparaît, deux apparaissent.
  void onDivide({required bool wasRectangle}) {
    if (wasRectangle) {
      rectangleCount -= 1;
      squareCount += 2;
    } else {
      squareCount -= 1;
      rectangleCount += 2;
    }
    notifyListeners();
  }
}