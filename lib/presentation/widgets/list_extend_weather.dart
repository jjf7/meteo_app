import 'package:flutter/material.dart';
import 'package:weather_app/domain/domain.dart';

import 'widgets.dart';

class ListExtendWeather extends StatelessWidget {
  final List<WeatherElement> list;
  const ListExtendWeather({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length - 1,
        itemBuilder: (context, index) {
          final weather = list[index + 1];
          return SizedBox(
            height: 100,
            width: 160,
            child: CardWeather(
              index: index,
              list: list,
              weather: weather,
            ),
          );
        },
      ),
    );
  }
}
