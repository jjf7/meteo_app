import 'package:flutter/material.dart';

import 'package:weather_app/infrastructure/repositories/weather_repository_impl.dart';
import 'package:weather_app/presentation/shared/shared.dart';
import '../../infrastructure/datasources/weather_datasource_impl.dart';
import '../providers/providers.dart';
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
                SingleChildScrollView(child: Expanded(child: CurrentWeather())),
                Expanded(child: ExtendDataWeather()),
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
