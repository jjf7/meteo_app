import 'package:flutter/material.dart';

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

          myLocation.isActiveMoreDataNotifier.value =
              !myLocation.isActiveMoreDataNotifier.value;
          switch (value) {
            case 0:
              myLocation.myLocationNotifier.value = 'caracas';
            case 1:
              myLocation.myLocationNotifier.value = 'madrid';
            case 2:
              myLocation.myLocationNotifier.value = 'bogota';
            case 3:
              myLocation.myLocationNotifier.value = 'lisboa';
            case 4:
              myLocation.myLocationNotifier.value = 'ciudad de panama';
            case 5:
              myLocation.myLocationNotifier.value = 'ciudad de mexico';
            case 6:
              myLocation.myLocationNotifier.value = 'buenos aires';
            case 7:
              myLocation.myLocationNotifier.value = 'maturin';
            case 8:
              myLocation.myLocationNotifier.value = 'miami';
            case 9:
              myLocation.myLocationNotifier.value = 'new york';
            case 10:
              myLocation.myLocationNotifier.value = 'california';
          }

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
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Caracas'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Madrid'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Bogota'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Lisboa'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Ciudad de Panama'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Ciudad de Mexico'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Buenos Aires'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Maturin'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Miami'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('New York'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('California'),
          ),
        ]);
  }
}
