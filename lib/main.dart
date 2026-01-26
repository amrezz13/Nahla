// lib/main.dart

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
        title: const Text('🐝 Dev Menu'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section: App Flow
          _buildSectionHeader('📱 App Flow'),
          _buildButton(context, '🚀 Landing Screen', AppRoutes.landing),
          _buildButton(context, '📖 Onboarding', AppRoutes.onboarding),
          
          const SizedBox(height: 16),
          
          // Section: Auth
          _buildSectionHeader('🔐 Authentication'),
          _buildButton(context, '🔑 Login', AppRoutes.login),
          _buildButton(context, '📝 Sign Up', AppRoutes.signup),
          _buildButton(context, '🔒 Forgot Password', AppRoutes.forgotPassword),
          
          const SizedBox(height: 16),
          
          // Section: Main App
          _buildSectionHeader('🏠 Main App'),
          _buildButton(context, '📱 Main Screen (Bottom Nav)', AppRoutes.main, isPrimary: true),
          _buildButton(context, '🏡 Home Dashboard', AppRoutes.home),
          
          const SizedBox(height: 16),
          
          // Section: Features
          _buildSectionHeader('⚙️ Features'),
          _buildButton(context, '🌤️ Weather', AppRoutes.weather),
          _buildButton(context, '🏠 Apiaries', AppRoutes.apiaries),
          _buildButton(context, '🛒 Marketplace', AppRoutes.marketplace),
          _buildButton(context, '👤 Profile', AppRoutes.profile),
          
          const SizedBox(height: 32),
          
          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber[700]),
                    const SizedBox(width: 8),
                    Text(
                      'Dev Menu Info',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'This menu is for development only. '
                  'In production, change home: to AppRoutes.landing or AppRoutes.main',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber[800],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route, {bool isPrimary = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          backgroundColor: isPrimary ? Colors.amber[700] : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.grey[800],
          elevation: isPrimary ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isPrimary ? Colors.transparent : Colors.grey[300]!,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isPrimary ? Colors.white : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}