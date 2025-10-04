import 'package:dio/dio.dart';
import '../domin/domin.dart';

Future<WeatherModel> getdata(String cityName) async {
  try {
    final response = await Dio().get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': '49d1f0cb3d611593bf448e3996d451c1',
        'units': 'metric'
      },
    );
    print(response.data);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('خطا در API: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('خطا: $e');
  }
}