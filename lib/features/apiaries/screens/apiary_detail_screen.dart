import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../models/apiary_model.dart';
import '../../beehives/screens/add_beehive_screen.dart';
import '../../beehives/models/beehive_model.dart';
import '../../beehives/screens/beehive_detail_screen.dart';

class ApiaryDetailScreen extends StatefulWidget {
  final Apiary apiary;

  const ApiaryDetailScreen({super.key, required this.apiary});

  @override
  State<ApiaryDetailScreen> createState() => _ApiaryDetailScreenState();
}

class _ApiaryDetailScreenState extends State<ApiaryDetailScreen> {
  List<Beehive> _beehives = [];

  // Get next system number for new beehive
  int get _nextSystemNumber {
    if (_beehives.isEmpty) return 1;
    return _beehives.map((b) => b.systemNumber).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> _openInMaps(BuildContext context) async {
    if (!widget.apiary.hasLocation) return;

    final lat = widget.apiary.latitude!;
    final lon = widget.apiary.longitude!;
    final label = Uri.encodeComponent(widget.apiary.name);

    final geoUri = Uri.parse('geo:$lat,$lon?q=$lat,$lon($label)');
    final googleMapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    final appleMapsUri = Uri.parse('https://maps.apple.com/?q=$lat,$lon');

    try {
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri);
      } else if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(appleMapsUri)) {
        await launchUrl(appleMapsUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleMapsUri, mode: LaunchMode.inAppWebView);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Could not open maps');
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _navigateToAddBeehive() async {
    final result = await Navigator.push<Beehive>(
      context,
      MaterialPageRoute(
        builder: (context) => AddBeehiveScreen(
          apiaryId: widget.apiary.id,
          nextSystemNumber: _nextSystemNumber,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _beehives.add(result);
      });
      // TODO: Save to database
      if (mounted) {
        _showSnackBar(context, 'Beehive added successfully!');
      }
    }
  }

Future<void> _navigateToBeehiveDetail(Beehive beehive) async {
  final result = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (context) => BeehiveDetailScreen(beehive: beehive),
    ),
  );

  // Handle deletion
  if (result == 'deleted') {
    setState(() {
      _beehives.removeWhere((b) => b.id == beehive.id);
    });
    if (mounted) {
      _showSnackBar(context, 'Beehive deleted');
    }
  }
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
              title: Text(widget.apiary.name),
              background: widget.apiary.hasImage
                  ? Image.file(
                      File(widget.apiary.imageUrl!),
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
                  // Location card
                  if (widget.apiary.hasLocation)
                    _buildLocationCard(context, l10n),
                  const SizedBox(height: 12),

                  // Hives card
                  _buildInfoCard(
                    icon: '🐝',
                    title: l10n.hives,
                    value: '${_beehives.length}',
                  ),
                  const SizedBox(height: 12),

                  // Created date card
                  _buildInfoCard(
                    icon: '📅',
                    title: l10n.createdAt,
                    value: _formatDate(widget.apiary.createdAt),
                  ),

                  if (widget.apiary.notes != null && widget.apiary.notes!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: '📝',
                      title: l10n.notes,
                      value: widget.apiary.notes!,
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Beehives section header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.beehives,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      if (_beehives.isNotEmpty)
                        TextButton.icon(
                          onPressed: _navigateToAddBeehive,
                          icon: const Icon(Icons.add),
                          label: Text(l10n.addHive),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Beehives list or empty state
                  if (_beehives.isEmpty)
                    _buildEmptyBeehivesState(l10n)
                  else
                    _buildBeehivesList(l10n),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBeehivesState(AppLocalizations l10n) {
    return Container(
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
            onPressed: _navigateToAddBeehive,
            icon: const Icon(Icons.add),
            label: Text(l10n.addHive),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeehivesList(AppLocalizations l10n) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _beehives.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final beehive = _beehives[index];
        return _buildBeehiveCard(beehive, l10n);
      },
    );
  }

Widget _buildBeehiveCard(Beehive beehive, AppLocalizations l10n) {
  return GestureDetector(
    onTap: () => _navigateToBeehiveDetail(beehive),
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
          // System number badge
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '#${beehive.systemNumber.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      beehive.name ?? l10n.hiveNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${beehive.hiveNumber})',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Queen status
                    Text(
                      beehive.hasQueen ? '👑' : '❌',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    // Health status
                    Text(
                      beehive.healthStatus.emoji,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    // Frames
                    Text(
                      '${beehive.frameCount} ${l10n.frames}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow
          Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
          ),
        ],
      ),
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
                    widget.apiary.locationString,
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