import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

var weatherFutureProvider = FutureProvider.autoDispose<Weather>((ref) {
  var weatherRepository = ref.watch(weatherRepositoryProvider);
  return weatherRepository.getWeather(city: 'London');
});

var weatherRepositoryProvider = Provider((ref) {
  return WeatherRepository();
});

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weatherAsync = ref.watch(weatherFutureProvider);

    return weatherAsync.when(data: (weather) {
      return Text(
        '${weather.cityName}: ${weather.description}',
        style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.normal,
            fontSize: 80),
      );
    }, error: (err, stack) {
      return Text('Error: $err');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}

class WeatherRepository {
  Future<Weather> getWeather({required String city}) async {
    // make API call to get weather data for the specified city
    // for example:
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=199ec058b447c6eb053013fe43ab2607'));
    if (response.statusCode == 200) {
      // parse the response and create a Weather object
      final weatherData = jsonDecode(response.body);
      return Weather.fromJson(weatherData);
    } else {
      // handle error
      throw Exception('Failed to load weather data');
    }
  }
}

class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: double.tryParse(json['main']['temp'].toString()) != null
          ? json['main']['temp']
          : double.parse(json['main']['temp']),
      description: json['weather'][0]['description'],
    );
  }
}
