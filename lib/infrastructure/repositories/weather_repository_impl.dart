import 'package:weather_app/domain/domain.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<Weather?> getWeather(String location) {
    return dataSource.getWeather(location);
  }
}
