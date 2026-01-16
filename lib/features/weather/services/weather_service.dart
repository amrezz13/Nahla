import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Default location: Warsaw, Poland
  static const double defaultLatitude = 52.2297;
  static const double defaultLongitude = 21.0122;

  Future<WeatherData?> getWeather({double? latitude, double? longitude}) async {
    // Use default if not provided
    final lat = latitude ?? defaultLatitude;
    final lon = longitude ?? defaultLongitude;

    try {
      final url = Uri.parse(
        '$baseUrl?latitude=$lat&longitude=$lon'
        '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,wind_direction_10m'
        '&hourly=temperature_2m,weather_code'
        '&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max,sunrise,sunset'
        '&timezone=auto'
        '&forecast_days=7',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Weather error: $e');
      return null;
    }
  }
}

class WeatherData {
  final CurrentWeather current;
  final List<DailyWeather> daily;
  final List<HourlyWeather> hourly;

  WeatherData({
    required this.current,
    required this.daily,
    required this.hourly,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // Current weather
    final current = CurrentWeather(
      temperature: json['current']['temperature_2m']?.toDouble() ?? 0,
      humidity: json['current']['relative_humidity_2m']?.toInt() ?? 0,
      windSpeed: json['current']['wind_speed_10m']?.toDouble() ?? 0,
      windDirection: json['current']['wind_direction_10m']?.toInt() ?? 0,
      weatherCode: json['current']['weather_code']?.toInt() ?? 0,
    );

    // Daily weather
    List<DailyWeather> daily = [];
    final dailyData = json['daily'];
    for (int i = 0; i < (dailyData['time'] as List).length; i++) {
      daily.add(DailyWeather(
        date: DateTime.parse(dailyData['time'][i]),
        maxTemp: dailyData['temperature_2m_max'][i]?.toDouble() ?? 0,
        minTemp: dailyData['temperature_2m_min'][i]?.toDouble() ?? 0,
        weatherCode: dailyData['weather_code'][i]?.toInt() ?? 0,
        precipitationChance: dailyData['precipitation_probability_max'][i]?.toInt() ?? 0,
        sunrise: dailyData['sunrise'][i] ?? '',
        sunset: dailyData['sunset'][i] ?? '',
      ));
    }

    // Hourly weather (next 24 hours)
    List<HourlyWeather> hourly = [];
    final hourlyData = json['hourly'];
    final now = DateTime.now();
    for (int i = 0; i < 24; i++) {
      final time = DateTime.parse(hourlyData['time'][i]);
      if (time.isAfter(now.subtract(const Duration(hours: 1)))) {
        hourly.add(HourlyWeather(
          time: time,
          temperature: hourlyData['temperature_2m'][i]?.toDouble() ?? 0,
          weatherCode: hourlyData['weather_code'][i]?.toInt() ?? 0,
        ));
      }
      if (hourly.length >= 12) break;
    }

    return WeatherData(current: current, daily: daily, hourly: hourly);
  }
}

class CurrentWeather {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final int weatherCode;

  CurrentWeather({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
  });
}

class DailyWeather {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;
  final int precipitationChance;
  final String sunrise;
  final String sunset;

  DailyWeather({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCode,
    required this.precipitationChance,
    required this.sunrise,
    required this.sunset,
  });
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}