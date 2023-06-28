import 'package:weather_app/domain/domain.dart';

class WeatherBloc {
  final WeatherRepository repository;

  WeatherBloc(this.repository);

  Future<Weather?> getMeteo(String location) {
    return repository.getWeather(location);
  }
}
