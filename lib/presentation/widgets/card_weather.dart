import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';

class CardWeather extends StatelessWidget {
  final WeatherElement weather;
  final int index;
  final List<WeatherElement> list;
  const CardWeather(
      {super.key,
      required this.weather,
      required this.index,
      required this.list});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[index * 3 % list.length].withOpacity(0.7),
      child: Column(
        children: [
          FormatDateWidget(date: weather.date),
          Text(
            weather.description
                .replaceRange(0, 1, weather.description[0].toUpperCase()),
            style: const TextStyle(color: Colors.white),
          ),
          Image.network(weather.icon),
          Text("Temp.Min ${weather.tempMin.toString()}°",
              style: const TextStyle(color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          Text("Temp.Max ${weather.tempMax.toString()}°",
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
