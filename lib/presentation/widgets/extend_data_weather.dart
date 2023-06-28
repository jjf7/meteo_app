import 'package:flutter/material.dart';
import 'package:weather_app/presentation/blocs/weather_bloc.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class ExtendDataWeather extends StatelessWidget {
  const ExtendDataWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final isActiveMoreDataNotifier =
        MyLocationInheritedWidget.of(context).isActiveMoreDataNotifier;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: isActiveMoreDataNotifier,
          builder: (context, isActive, child) {
            return Column(
              children: [
                !isActive
                    ? FilledButton.tonal(
                        onPressed: () {
                          isActiveMoreDataNotifier.value =
                              !isActiveMoreDataNotifier.value;
                        },
                        child: const Text('Pronóstico extendido'),
                      )
                    : const _ListOfWeatherExtends(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListOfWeatherExtends extends StatelessWidget {
  const _ListOfWeatherExtends();

  @override
  Widget build(BuildContext context) {
    final weatherBloc =
        WeatherBloc(WeatherInheritedWidget.of(context).repository);

    final myLocationInheritedWidget =
        MyLocationInheritedWidget.of(context).myLocationNotifier;

    return ValueListenableBuilder(
      valueListenable: myLocationInheritedWidget,
      builder: (BuildContext context, location, Widget? _) {
        return FutureBuilder(
          future: weatherBloc.getMeteo(location),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListExtendWeather(
                list: data!.weather,
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
