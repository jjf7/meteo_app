import 'package:flutter/material.dart';
import 'package:weather_app/config/config.dart';

class ViewMainCurrentWeather extends StatelessWidget {
  final String icon;
  final String name;
  final String city;
  final double temp;
  final DateTime date;

  const ViewMainCurrentWeather({
    super.key,
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
