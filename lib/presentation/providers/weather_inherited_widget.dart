import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class WeatherInheritedWidget extends InheritedWidget {
  final WeatherRepository repository;

  const WeatherInheritedWidget(
      {super.key, required this.repository, required super.child});

  static WeatherInheritedWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType()!;

  @override
  bool updateShouldNotify(covariant WeatherInheritedWidget oldWidget) => false;
}
