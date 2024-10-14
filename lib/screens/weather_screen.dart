import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../weather_provider.dart'; 
import '../weather_model.dart'; 

class WeatherScreen extends ConsumerWidget {
  final String cityName;

  const WeatherScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherProvider(cityName));  // Listen to the weather provider

    return weatherAsyncValue.when(
      data: (weather) => WeatherDisplay(weather: weather),  // Display weather if data is available
      loading: () => const Center(child: CircularProgressIndicator()),  // Show loading spinner
      error: (error, stack) => Center(child: Text('Error: $error')),  // Show error message
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Temperature: ${weather.temperature.toStringAsFixed(1)}°C'),
        Text('Weather: ${weather.description}'),
        Text('Wind Speed: ${weather.windSpeed} m/s'),
        Text('Humidity: ${weather.humidity}%'),
      ],
    );
  }
}
