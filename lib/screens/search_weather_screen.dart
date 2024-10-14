import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'weather_screen.dart'; 

final cityNameProvider = StateProvider<String>((ref) => '');

class SearchWeatherScreen extends ConsumerWidget {
  const SearchWeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityName = ref.watch(cityNameProvider);
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter city name'),
              onSubmitted: (value) {
                ref.read(cityNameProvider.notifier).state = value; // Update the city name
              },
            ),
            const SizedBox(height: 16),
            // Display the WeatherScreen if cityName is not empty
            if (cityName.isNotEmpty) 
              Expanded(child: WeatherScreen(cityName: cityName)),  // Use WeatherScreen widget here
            if (cityName.isEmpty) 
              const Expanded(
                child: Center(child: Text('Please enter a city name to see the weather.')),
              ),
          ],
        ),
      ),
    );
  }
}
