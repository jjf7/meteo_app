import '../../domain/domain.dart';

const urlIcon = 'https://openweathermap.org/img/wn/';

class WeatherCurrentMapper {
  static Weather weatherCurrentJsonToEntity(Map<String, dynamic> json) {
    final id = json['city']['id'];
    final city = json['city']['name'];
    final weatherList = <WeatherElement>[];

    final listJson = json['list'];

    for (var i = 0; i < listJson.length; i += 8) {
      final id = listJson[i]['weather'][0]['id'];
      final date =
          DateTime.fromMillisecondsSinceEpoch(listJson[i]['dt'] * 1000);
      final icon = listJson[i]['weather'][0]['icon'];
      final description = listJson[i]['weather'][0]['description'];
      final temp = listJson[i]['main']['temp'];
      final tempMin = listJson[i]['main']['temp_min'];
      final tempMax = listJson[i]['main']['temp_max'];

      weatherList.add(WeatherElement(
        id: id,
        date: date,
        description: description,
        icon: "$urlIcon$icon@2x.png",
        temp: temp.toDouble(),
        tempMin: tempMin.toDouble(),
        tempMax: tempMax.toDouble(),
      ));
    }

    return Weather(
      id: id,
      name: city,
      weather: weatherList,
    );
  }
}
