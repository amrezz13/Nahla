import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../models/apiary_model.dart';

class ApiaryDetailScreen extends StatelessWidget {
  final Apiary apiary;

  const ApiaryDetailScreen({super.key, required this.apiary});

  Future<void> _openInMaps(BuildContext context) async {
    if (!apiary.hasLocation) return;

    final lat = apiary.latitude!;
    final lon = apiary.longitude!;
    final name = Uri.encodeComponent(apiary.name);

    // This URL works for both Google Maps and Apple Maps
    final url = 'geo:$lat,$lon?q=$lat,$lon($name)';
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

    try {
      // Try geo: URL first (opens default map app)
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } 
      // Fallback to Google Maps web
      else if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        _showSnackBar(context, 'Could not open maps');
      }
    } catch (e) {
      _showSnackBar(context, 'Error opening maps');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(apiary.name),
              background: apiary.hasImage
                  ? Image.file(
                      File(apiary.imagePath!),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.primary,
                      child: const Center(
                        child: Text('🏠', style: TextStyle(fontSize: 80)),
                      ),
                    ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location card (clickable - opens maps app)
                  if (apiary.hasLocation)
                    _buildLocationCard(context, l10n),
                  const SizedBox(height: 12),

                  // Hives card
                  _buildInfoCard(
                    icon: '🐝',
                    title: l10n.hives,
                    value: '${apiary.hiveCount}',
                  ),
                  const SizedBox(height: 12),

                  // Created date card
                  _buildInfoCard(
                    icon: '📅',
                    title: l10n.createdAt,
                    value: _formatDate(apiary.createdAt),
                  ),

                  if (apiary.notes != null && apiary.notes!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: '📝',
                      title: l10n.notes,
                      value: apiary.notes!,
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Beehives section
                  Text(
                    l10n.beehives,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text('🐝', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          l10n.noHives,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Add hive
                          },
                          icon: const Icon(Icons.add),
                          label: Text(l10n.addHive),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => _openInMaps(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text('📍', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    apiary.locationString,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.tapToOpenMaps,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}