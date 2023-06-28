import 'package:flutter/material.dart';
import 'package:weather_app/config/helpers/human_formats.dart';

import 'package:weather_app/infrastructure/repositories/weather_repository_impl.dart';
import 'package:weather_app/presentation/providers/weather_inherited_widget.dart';

import '../../domain/entities/weather.dart';
import '../../infrastructure/datasources/weather_datasource_impl.dart';

import '../blocs/weather_bloc.dart';
import '../providers/location_inherited_widget.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  final _myLocationNotifier = ValueNotifier('Caracas');
  final _isActiveMoreDataNotifier = ValueNotifier(false);

  void openSearch(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onClose: () => onClose(context),
            onSearch: () => onSearch(context),
          );
        });
  }

  void onClose(BuildContext context) {
    Navigator.pop(context);
  }

  void onSearch(BuildContext context) {
    _myLocationNotifier.value = controller.text;
    _isActiveMoreDataNotifier.value = !_isActiveMoreDataNotifier.value;
    controller.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return WeatherInheritedWidget(
      repository: WeatherRepositoryImpl(WeatherDataSourceImpl()),
      child: MyLocationInheritedWidget(
        myLocationNotifier: _myLocationNotifier,
        isActiveMoreDataNotifier: _isActiveMoreDataNotifier,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Meteo App by Jose Fuentes'),
              centerTitle: true,
            ),
            body: const Column(
              children: [
                SingleChildScrollView(
                    child: Expanded(child: _CurrentWeather())),
                Expanded(child: _ExtendDataWeather()),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => openSearch(context),
              child: const Icon(Icons.search_rounded),
            ),
            drawer: SideMenu(scaffoldKey: scaffoldKey),
          ),
        ),
      ),
    );
  }
}

class _ExtendDataWeather extends StatelessWidget {
  const _ExtendDataWeather();

  @override
  Widget build(BuildContext context) {
    final isActiveMoreDataNotifier =
        MyLocationInheritedWidget.of(context).isActiveMoreDataNotifier;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
              return _ViewExtendWeather(
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

class _ViewExtendWeather extends StatelessWidget {
  final List<WeatherElement> list;
  const _ViewExtendWeather({required this.list});

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
            child: Card(
              color: Colors.primaries[index * 3 % list.length].withOpacity(0.7),
              child: Column(
                children: [
                  FutureBuilder(
                    future: HumanFormats.date(weather.date),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                    weather.description.replaceRange(
                        0, 1, weather.description[0].toUpperCase()),
                  ),
                  Image.network(weather.icon),
                  Text("Temp.Min ${weather.tempMin.toString()}°"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Temp.Max ${weather.tempMax.toString()}°"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CurrentWeather extends StatelessWidget {
  const _CurrentWeather();

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
                return _ViewMainCurrentWeather(
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

class _ViewMainCurrentWeather extends StatelessWidget {
  final String icon;
  final String name;
  final String city;
  final double temp;
  final DateTime date;

  const _ViewMainCurrentWeather({
    required this.icon,
    required this.name,
    required this.city,
    required this.temp,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: HumanFormats.date(date),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            Image.network(
              icon,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            Text(
              name.replaceRange(0, 1, name[0].toUpperCase()),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$temp°",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
