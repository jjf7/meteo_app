import 'package:flutter/material.dart';
import 'package:weather_app/presentation/blocs/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';

import '../providers/providers.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc =
        WeatherBloc(WeatherInheritedWidget.of(context).repository);

    final myLocationInheritedWidget =
        MyLocationInheritedWidget.of(context).myLocationNotifier;

    return ValueListenableBuilder(
      valueListenable: myLocationInheritedWidget,
      builder: (BuildContext context, location, Widget? _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FutureBuilder(
            future: weatherBloc.getMeteo(location),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final data = snapshot.data;
                return ViewMainCurrentWeather(
                  icon: data!.weather[0].icon,
                  name: data.weather[0].description,
                  city: data.name,
                  temp: data.weather[0].temp,
                  date: data.weather[0].date,
                );
              } else {
                return const Center(
                    child: Text('No hay datos para la busqueda actual 😢',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800)));
              }
            },
          ),
        );
      },
    );
  }
}
