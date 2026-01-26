// lib/features/profile/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  // TODO: Get from auth/database
  final String _userName = 'Ahmed Mohamed';
  final String _userEmail = 'ahmed@email.com';

  Future<void> _logout() async {
    final l10n = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      // TODO: Implement Firebase Auth logout
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Text(
                        _userName[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _userEmail,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Navigate to edit profile
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  _buildStatCard('🏠', '5', l10n.apiaries, isDark),
                  const SizedBox(width: 12),
                  _buildStatCard('🐝', '32', l10n.beehives, isDark),
                  const SizedBox(width: 12),
                  _buildStatCard('📅', '2y', l10n.memberSince, isDark),
                ],
              ),

              const SizedBox(height: 24),

              // Settings List
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildSettingsTile(
                      icon: Icons.person_outline,
                      title: l10n.editProfile,
                      onTap: () {},
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildSettingsTile(
                      icon: Icons.notifications_outlined,
                      title: l10n.notifications,
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (v) => setState(() => _notificationsEnabled = v),
                        activeColor: primaryColor,
                      ),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildSettingsTile(
                      icon: Icons.language_outlined,
                      title: l10n.language,
                      subtitle: 'English',
                      onTap: () {},
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildSettingsTile(
                      icon: Icons.help_outline,
                      title: l10n.helpSupport,
                      onTap: () {},
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildSettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.privacyPolicy,
                      onTap: () {},
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildSettingsTile(
                      icon: Icons.logout,
                      title: l10n.logout,
                      iconColor: Colors.red,
                      titleColor: Colors.red,
                      onTap: _logout,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // App Version
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
    Color? titleColor,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isDark ? Colors.grey[400] : Colors.grey[700]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? (isDark ? Colors.white : Colors.black87),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      indent: 56,
      color: isDark ? Colors.grey[800] : Colors.grey[200],
    );
  }
}