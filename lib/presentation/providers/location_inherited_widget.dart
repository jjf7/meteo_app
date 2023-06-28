import 'package:flutter/material.dart';

class MyLocationInheritedWidget extends InheritedWidget {
  final ValueNotifier<String> myLocationNotifier;

  final ValueNotifier<bool> isActiveMoreDataNotifier;

  const MyLocationInheritedWidget({
    super.key,
    required this.myLocationNotifier,
    required this.isActiveMoreDataNotifier,
    required super.child,
  });

  static MyLocationInheritedWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<MyLocationInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
