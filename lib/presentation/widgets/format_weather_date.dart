import 'package:flutter/material.dart';
import 'package:weather_app/config/config.dart';

class FormatDateWidget extends StatelessWidget {
  final DateTime date;
  const FormatDateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HumanFormats.date(date),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
