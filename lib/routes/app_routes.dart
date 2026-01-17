import 'package:flutter/material.dart';
import '../features/landing/landing.dart';
import '../features/landing/onboarding_screen.dart';
import '../features/weather/screens/weather_screen.dart';
import '../features/apiaries/screens/apiaries_screen.dart';

// import other screens...

class AppRoutes {
  static const String landing = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
    static const String weather = '/weather';
      static const String apiaries = '/apiaries';


  static Map<String, WidgetBuilder> get routes {
    return {
      landing: (context) => const LandingScreen(),
      onboarding: (context) => const OnboardingScreen(),
      weather: (context) => const WeatherScreen(),
            apiaries: (context) => const ApiariesScreen(),

      // register: (context) => const RegisterScreen(),
      // home: (context) => const HomeScreen(),
    };
  }
}