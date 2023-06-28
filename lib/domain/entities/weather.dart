class Weather {
  int id;
  String name;
  List<WeatherElement> weather;

  Weather({
    required this.id,
    required this.name,
    required this.weather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        name: json["name"],
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
      );
}

class WeatherElement {
  int id;
  DateTime date;
  String description;
  String icon;
  double temp;
  double tempMin;
  double tempMax;

  WeatherElement({
    required this.id,
    required this.date,
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        date: json["dt"],
        description: json["description"],
        icon: json["icon"],
        temp: json["temp"],
        tempMin: json["tempMin"],
        tempMax: json["tempMax"],
      );
}
