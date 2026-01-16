import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../routes/app_routes.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _beeController;
  late AnimationController _fadeController;
  late Animation<double> _beeX;
  late Animation<double> _beeY;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // Bee flying animation
    _beeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _beeX = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _beeController, curve: Curves.easeInOut),
    );

    _beeY = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _beeController, curve: Curves.easeInOut),
    );

    // Fade in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Navigate to onboarding after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _beeController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryLight,
              AppColors.background,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Bee
                AnimatedBuilder(
                  animation: _beeController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_beeX.value, _beeY.value),
                      child: child,
                    );
                  },
                  child: const Text(
                    '🐝',
                    style: TextStyle(fontSize: 80),
                  ),
                ),

                const SizedBox(height: 30),

                // Honeycomb decoration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.hexagon,
                        color: AppColors.primary.withOpacity(0.3 + (index * 0.15)),
                        size: 24,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // App name (localized)
                Text(
                  l10n.appName,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 12),

                // Tagline (localized)
                Text(
                  l10n.welcome,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 60),

                // Loading indicator
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}