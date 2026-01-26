// lib/routes/app_routes.dart

import 'package:flutter/material.dart';

// Landing & Onboarding
import '../features/landing/landing.dart';
import '../features/landing/onboarding_screen.dart';

// Auth
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';

// Main App
import '../features/main/screens/main_screen.dart';
import '../features/home/screens/home_screen.dart';

// Features
import '../features/weather/screens/weather_screen.dart';
import '../features/apiaries/screens/apiaries_screen.dart';
import '../features/marketplace/screens/marketplace_screen.dart';
import '../features/profile/screens/profile_screen.dart';

class AppRoutes {
  // Landing & Onboarding
  static const String landing = '/';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main App (with bottom navigation)
  static const String main = '/main';
  static const String home = '/home';

  // Features
  static const String weather = '/weather';
  static const String apiaries = '/apiaries';
  static const String marketplace = '/marketplace';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      // Landing & Onboarding
      landing: (context) => const LandingScreen(),
      onboarding: (context) => const OnboardingScreen(),

      // Auth
      login: (context) => const LoginScreen(),
      signup: (context) => const SignupScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),

      // Main App
      main: (context) => const MainScreen(),
      home: (context) => const HomeScreen(),

      // Features
      weather: (context) => const WeatherScreen(),
      apiaries: (context) => const ApiariesScreen(),
      marketplace: (context) => const MarketplaceScreen(),
      profile: (context) => const ProfileScreen(),
    };
  }
}