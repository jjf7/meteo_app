import 'package:flutter/material.dart';
import 'package:weather_app/config/config.dart';

import '../providers/location_inherited_widget.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    final myLocation = MyLocationInheritedWidget.of(context);

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // reset el active de pronostico extendido
          myLocation.isActiveMoreDataNotifier.value =
              !myLocation.isActiveMoreDataNotifier.value;

          // asignar al notifier la ciudad seleccionada
          myLocation.myLocationNotifier.value = cities[value];

          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              Navigator.pop(context);
              widget.scaffoldKey.currentState?.closeDrawer();
            },
          );
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text(
                'Selecciona una ciudad para ver el pronostico del tiempo',
                style: textStyles.titleSmall),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          ...cities
              .map((city) => NavigationDrawerDestination(
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                    label: Text(city.replaceRange(0, 1, city[0].toUpperCase())),
                  ))
              .toList()
        ]);
  }
}
