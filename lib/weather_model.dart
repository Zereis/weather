class Weather {
  final String description;
  final double temperature;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherDescription = json['weather'][0]['description'];
    final temp = json['main']['temp'];
    final wind = json['wind']['speed'];
    final humidity = json['main']['humidity'];
    return Weather(
      description: weatherDescription,
      temperature: temp - 273.15,  // Convert from Kelvin to Celsius
      windSpeed: wind,
      humidity: humidity,
    );
  }

  // Add this method to convert Weather to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'temperature': temperature,
      'windSpeed': windSpeed,
      'humidity': humidity,
    };
  }
}
