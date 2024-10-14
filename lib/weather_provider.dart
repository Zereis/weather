import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_model.dart';  
import 'package:shared_preferences/shared_preferences.dart'; 

final weatherProvider = FutureProvider.family<Weather, String>((ref, cityName) async {
  const apiKey = 'f97ef50d255f411a64f802719315b8aa'; 

  // Try to load cached weather data
  final prefs = await SharedPreferences.getInstance();
  final cachedWeatherJson = prefs.getString(cityName);
  if (cachedWeatherJson != null) {
    return Weather.fromJson(jsonDecode(cachedWeatherJson));
  }

  // If no cached data, fetch from API
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final weather = Weather.fromJson(json);

    // Cache the fetched weather data
    await prefs.setString(cityName, jsonEncode(weather.toJson())); // Save to cache
    return weather;
  } else {
    throw Exception('Failed to load weather data');
  }
});
