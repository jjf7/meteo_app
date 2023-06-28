import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../mappers/weather_current_mapper.dart';

const apiKey = '4c19a97be8d2bba116805f926075aa32';

class WeatherDataSourceImpl extends WeatherDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/',
    queryParameters: {
      'appid': apiKey,
    },
  ));

  @override
  Future<Weather?> getWeather(String location) async {
    try {
      final response = await dio.get('data/2.5/forecast', queryParameters: {
        'q': location,
        'lang': 'es',
        'units': 'metric',
      });

      final weather =
          WeatherCurrentMapper.weatherCurrentJsonToEntity(response.data);

      return weather;
    } on DioException catch (e) {
      print(e);
      return null;
    }
  }
}
