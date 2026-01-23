// lib/features/inspections/screens/inspection_detail_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../models/inspection_model.dart';

class InspectionDetailScreen extends StatefulWidget {
  final Inspection inspection;
  final String beehiveName;

  const InspectionDetailScreen({
    super.key,
    required this.inspection,
    required this.beehiveName,
  });

  @override
  State<InspectionDetailScreen> createState() => _InspectionDetailScreenState();
}

class _InspectionDetailScreenState extends State<InspectionDetailScreen> {
  late PageController _imagePageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteInspection),
        content: Text(l10n.deleteInspectionConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, 'deleted');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(
          images: widget.inspection.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final inspection = widget.inspection;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(l10n.inspectionDetails),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit screen
            },
            tooltip: l10n.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context, l10n),
            tooltip: l10n.delete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === HEADER CARD ===
          _buildHeaderCard(context, inspection, l10n, primaryColor),
          const SizedBox(height: 16),

          // === QUICK SUMMARY ===
          if (inspection.quickSummary.isNotEmpty) ...[
            _buildQuickSummaryCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === COLONY STATUS ===
          _buildColonyStatusCard(context, inspection, l10n),
          const SizedBox(height: 16),

          // === POPULATION ===
          if (inspection.populationStrength != null ||
              inspection.framesOfBees != null ||
              inspection.framesOfBrood != null) ...[
            _buildPopulationCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === FOOD STORES ===
          if (inspection.honeyStores != null ||
              inspection.pollenStores != null ||
              inspection.needsFeeding) ...[
            _buildFoodStoresCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === HEALTH ===
          if (inspection.temperament != null ||
              inspection.diseasesObserved.isNotEmpty ||
              inspection.pestsObserved.isNotEmpty) ...[
            _buildHealthCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === ACTIONS TAKEN ===
          if (inspection.actionsTaken.isNotEmpty) ...[
            _buildActionsCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === PHOTOS ===
          if (inspection.images.isNotEmpty) ...[
            _buildPhotosCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          // === NOTES ===
          if (inspection.notes != null && inspection.notes!.isNotEmpty) ...[
            _buildNotesCard(context, inspection, l10n),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
    Color primaryColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🐝', style: TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.beehiveName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      l10n.inspection,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _HeaderInfoItem(
                icon: Icons.calendar_today,
                label: _formatDate(inspection.inspectionDate),
              ),
              const SizedBox(width: 16),
              _HeaderInfoItem(
                icon: Icons.access_time,
                label: _formatTime(inspection.inspectionDate),
              ),
              if (inspection.weather != null) ...[
                const SizedBox(width: 16),
                _HeaderInfoItem(
                  icon: null,
                  emoji: inspection.weather!.emoji,
                  label: inspection.weather!.label,
                ),
              ],
            ],
          ),
          if (inspection.temperature != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                _HeaderInfoItem(
                  icon: Icons.thermostat,
                  label: '${inspection.temperature!.toStringAsFixed(1)}°C',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickSummaryCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (inspection.queenSeen) _QuickItem(emoji: '👑', label: l10n.queenSeen),
          if (inspection.eggsSeen) _QuickItem(emoji: '🥚', label: l10n.eggsSeen),
          if (inspection.larvaeSeen) _QuickItem(emoji: '🐛', label: l10n.larvaeSeen),
          if (inspection.hasHealthIssues) _QuickItem(emoji: '⚠️', label: l10n.issues),
          if (inspection.needsFeeding) _QuickItem(emoji: '🍽️', label: l10n.needsFeeding),
        ],
      ),
    );
  }

  Widget _buildColonyStatusCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: l10n.colonyStatus,
      icon: Icons.hive,
      iconColor: Colors.amber,
      children: [
        _StatusRow(
          emoji: '👑',
          label: l10n.queenSeen,
          value: inspection.queenSeen,
        ),
        _StatusRow(
          emoji: '👑',
          label: l10n.queenCellsSeen,
          value: inspection.queenCellsSeen,
          warning: inspection.queenCellsSeen,
        ),
        _StatusRow(
          emoji: '🥚',
          label: l10n.eggsSeen,
          value: inspection.eggsSeen,
        ),
        _StatusRow(
          emoji: '🐛',
          label: l10n.larvaeSeen,
          value: inspection.larvaeSeen,
        ),
        if (inspection.broodPattern != null) ...[
          const Divider(height: 24),
          _InfoRow(
            emoji: '🔲',
            label: l10n.broodPattern,
            value: '${inspection.broodPattern!.emoji} ${inspection.broodPattern!.label}',
          ),
        ],
      ],
    );
  }

  Widget _buildPopulationCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: l10n.population,
      icon: Icons.groups,
      children: [
        if (inspection.populationStrength != null)
          _InfoRow(
            emoji: inspection.populationStrength!.emoji,
            label: l10n.populationStrength,
            value: inspection.populationStrength!.label,
          ),
        if (inspection.framesOfBees != null) ...[
          const SizedBox(height: 12),
          _InfoRow(
            emoji: '🖼️',
            label: l10n.framesOfBees,
            value: '${inspection.framesOfBees}',
          ),
        ],
        if (inspection.framesOfBrood != null) ...[
          const SizedBox(height: 12),
          _InfoRow(
            emoji: '🐛',
            label: l10n.framesOfBrood,
            value: '${inspection.framesOfBrood}',
          ),
        ],
      ],
    );
  }

  Widget _buildFoodStoresCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: l10n.foodStores,
      icon: Icons.inventory_2,
      iconColor: Colors.orange,
      children: [
        if (inspection.honeyStores != null)
          _InfoRow(
            emoji: '🍯',
            label: l10n.honeyStores,
            value: '${inspection.honeyStores!.emoji} ${inspection.honeyStores!.label}',
            valueColor: inspection.honeyStores == StoresLevel.low ? Colors.red : null,
          ),
        if (inspection.pollenStores != null) ...[
          const SizedBox(height: 12),
          _InfoRow(
            emoji: '🌼',
            label: l10n.pollenStores,
            value: '${inspection.pollenStores!.emoji} ${inspection.pollenStores!.label}',
            valueColor: inspection.pollenStores == StoresLevel.low ? Colors.red : null,
          ),
        ],
        if (inspection.needsFeeding) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Text('🍽️', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Text(
                  l10n.needsFeedingAlert,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHealthCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: l10n.health,
      icon: Icons.health_and_safety,
      iconColor: inspection.hasHealthIssues ? Colors.red : Colors.green,
      children: [
        if (inspection.temperament != null)
          _InfoRow(
            emoji: inspection.temperament!.emoji,
            label: l10n.temperament,
            value: inspection.temperament!.label,
          ),
        if (inspection.diseasesObserved.isNotEmpty) ...[
          const Divider(height: 24),
          Text(
            l10n.diseasesObserved,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: inspection.diseasesObserved.map((disease) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  disease.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        if (inspection.pestsObserved.isNotEmpty) ...[
          const Divider(height: 24),
          Text(
            l10n.pestsObserved,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: inspection.pestsObserved.map((pest) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(pest.emoji, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      pest.label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildActionsCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: l10n.actionsTaken,
      icon: Icons.construction,
      iconColor: Colors.blue,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: inspection.actionsTaken.map((action) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(action.emoji, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    action.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        if (inspection.actionNotes != null && inspection.actionNotes!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            inspection.actionNotes!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPhotosCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    return _SectionCard(
      title: '${l10n.photos} (${inspection.images.length})',
      icon: Icons.photo_library,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: inspection.images.length,
          itemBuilder: (context, index) {
            final image = inspection.images[index];
            return GestureDetector(
              onTap: () => _showFullScreenImage(context, index),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(image.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        image.type.emoji,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNotesCard(
    BuildContext context,
    Inspection inspection,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _SectionCard(
      title: l10n.notes,
      icon: Icons.notes,
      children: [
        Text(
          inspection.notes!,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// === HELPER WIDGETS ===

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    this.iconColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor ?? Colors.amber[700]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _HeaderInfoItem extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;

  const _HeaderInfoItem({
    this.icon,
    this.emoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(icon, size: 16, color: Colors.white70)
        else if (emoji != null)
          Text(emoji!, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class _QuickItem extends StatelessWidget {
  final String emoji;
  final String label;

  const _QuickItem({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String emoji;
  final String label;
  final bool value;
  final bool warning;

  const _StatusRow({
    required this.emoji,
    required this.label,
    required this.value,
    this.warning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: value
                  ? (warning ? Colors.orange : Colors.green).withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value ? '✓' : '✗',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: value
                    ? (warning ? Colors.orange : Colors.green)
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.emoji,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

// === FULL SCREEN IMAGE VIEWER ===

class _FullScreenImageViewer extends StatefulWidget {
  final List<InspectionImage> images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = widget.images[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentImage.type.emoji),
            const SizedBox(width: 8),
            Text(currentImage.type.label),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_currentIndex + 1}/${widget.images.length}',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: Image.file(
                File(widget.images[index].imagePath),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.images[_currentIndex].note != null
          ? Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Text(
                  widget.images[_currentIndex].note!,
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : null,
    );
  }
}