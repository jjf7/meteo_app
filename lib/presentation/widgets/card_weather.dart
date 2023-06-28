import 'package:flutter/material.dart';
import 'package:weather_app/config/config.dart';
import 'package:weather_app/domain/entities/weather.dart';

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
          FutureBuilder(
            future: HumanFormats.date(weather.date),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          Text(
            weather.description
                .replaceRange(0, 1, weather.description[0].toUpperCase()),
          ),
          Image.network(weather.icon),
          Text("Temp.Min ${weather.tempMin.toString()}°"),
          const SizedBox(
            height: 10,
          ),
          Text("Temp.Max ${weather.tempMax.toString()}°"),
        ],
      ),
    );
  }
}
