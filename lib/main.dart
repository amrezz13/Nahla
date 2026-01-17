import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeeKeeper',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],

      home: const DevMenu(),
      onGenerateRoute: (settings) {
        final routes = AppRoutes.routes;
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder);
        }
        return null;
      },
    );
  }
}

// Temporary dev menu for testing widgets
class DevMenu extends StatelessWidget {
  const DevMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Menu'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildButton(context, 'Landing Screen', AppRoutes.landing),
          _buildButton(context, 'Onboarding', AppRoutes.onboarding),
          _buildButton(context, 'Weather', AppRoutes.weather),
          _buildButton(context, 'Apiaries', AppRoutes.apiaries),

          // Add more buttons as you build widgets:
          // _buildButton(context, 'Login', AppRoutes.login),
          // _buildButton(context, 'Register', AppRoutes.register),
          // _buildButton(context, 'Home', AppRoutes.home),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}