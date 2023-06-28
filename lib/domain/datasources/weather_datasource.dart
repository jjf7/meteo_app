import '../entities/weather.dart';

abstract class WeatherDataSource {
  Future<Weather?> getWeather(String location);
}
