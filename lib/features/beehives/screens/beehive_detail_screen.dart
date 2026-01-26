import 'dart:io';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../models/beehive_model.dart';
import '../models/beehive_image_model.dart';
import '../../inspections/screens/add_inspection_screen.dart';
import '../../inspections/screens/inspections_list_screen.dart';

class BeehiveDetailScreen extends StatefulWidget {
  final Beehive beehive;

  const BeehiveDetailScreen({super.key, required this.beehive});

  @override
  State<BeehiveDetailScreen> createState() => _BeehiveDetailScreenState();
}

class _BeehiveDetailScreenState extends State<BeehiveDetailScreen> {
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

  // === LOCALIZED LABEL HELPERS ===

  String _getQueenTypeLabel(QueenType type, AppLocalizations l10n) {
    switch (type) {
      case QueenType.local:
        return l10n.queenTypeLocal;
      case QueenType.imported:
        return l10n.queenTypeImported;
      case QueenType.bred:
        return l10n.queenTypeBred;
      case QueenType.swarm:
        return l10n.queenTypeSwarm;
      case QueenType.purchased:
        return l10n.queenTypePurchased;
      case QueenType.unknown:
        return l10n.queenTypeUnknown;
    }
  }

  String _getQueenBreedLabel(QueenBreed breed, AppLocalizations l10n) {
    switch (breed) {
      case QueenBreed.italian:
        return l10n.queenBreedItalian;
      case QueenBreed.carniolan:
        return l10n.queenBreedCarniolan;
      case QueenBreed.buckfast:
        return l10n.queenBreedBuckfast;
      case QueenBreed.caucasian:
        return l10n.queenBreedCaucasian;
      case QueenBreed.local:
        return l10n.queenBreedLocal;
      case QueenBreed.hybrid:
        return l10n.queenBreedHybrid;
      case QueenBreed.other:
        return l10n.queenBreedOther;
    }
  }

  String _getHealthStatusLabel(HealthStatus status, AppLocalizations l10n) {
    switch (status) {
      case HealthStatus.healthy:
        return l10n.healthHealthy;
      case HealthStatus.weak:
        return l10n.healthWeak;
      case HealthStatus.sick:
        return l10n.healthSick;
      case HealthStatus.critical:
        return l10n.healthCritical;
      case HealthStatus.unknown:
        return l10n.healthUnknown;
    }
  }

  String _getMarkingColorLabel(QueenMarkingColor color, AppLocalizations l10n) {
    switch (color) {
      case QueenMarkingColor.white:
        return l10n.markingColorWhite;
      case QueenMarkingColor.yellow:
        return l10n.markingColorYellow;
      case QueenMarkingColor.red:
        return l10n.markingColorRed;
      case QueenMarkingColor.green:
        return l10n.markingColorGreen;
      case QueenMarkingColor.blue:
        return l10n.markingColorBlue;
    }
  }

  String _getImageTypeLabel(ImageType type, AppLocalizations l10n) {
    switch (type) {
      case ImageType.queen:
        return l10n.imageTypeQueen;
      case ImageType.brood:
        return l10n.imageTypeBrood;
      case ImageType.honey:
        return l10n.imageTypeHoney;
      case ImageType.frames:
        return l10n.imageTypeFrames;
      case ImageType.disease:
        return l10n.imageTypeDisease;
      case ImageType.general:
        return l10n.imageTypeGeneral;
    }
  }

  void _showDeleteConfirmation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteBeehive),
        content: Text(l10n.deleteBeehiveConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, 'deleted'); // Return to previous screen
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
          images: widget.beehive.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final beehive = widget.beehive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // === APP BAR WITH IMAGE ===
          SliverAppBar(
            expandedHeight: beehive.images.isNotEmpty ? 300 : 200,
            pinned: true,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                beehive.name ?? '${l10n.hive} #${beehive.systemNumber}',
                style: const TextStyle(
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
              background: beehive.images.isNotEmpty
                  ? _buildImageGallery(context)
                  : _buildPlaceholderHeader(primaryColor),
            ),
          ),

          // === CONTENT ===
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === IDENTIFICATION CARD ===
                  _buildSectionCard(
                    context: context,
                    title: l10n.identification,
                    icon: Icons.tag,
                    children: [
                      _buildInfoRow(
                        icon: '🔢',
                        label: l10n.systemNumber,
                        value:
                            '#${beehive.systemNumber.toString().padLeft(3, '0')}',
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        icon: '🏷️',
                        label: l10n.hiveNumber,
                        value: beehive.hiveNumber,
                      ),
                      if (beehive.name != null) ...[
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: '📝',
                          label: l10n.name,
                          value: beehive.name!,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  // === HIVE INFO CARD ===
                  _buildSectionCard(
                    context: context,
                    title: l10n.hiveInfo,
                    icon: Icons.grid_view_rounded,
                    children: [
                      _buildInfoRow(
                        icon: '🖼️',
                        label: l10n.frames,
                        value: '${beehive.frameCount}',
                      ),
                      const SizedBox(height: 12),
                      _buildHealthStatusRow(beehive.healthStatus, l10n),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // === QUEEN INFO CARD ===
                  _buildQueenInfoCard(context, beehive, l10n, primaryColor),
                  const SizedBox(height: 16),

                  // === PHOTOS SECTION ===
                  if (beehive.images.isNotEmpty) ...[
                    _buildPhotosSection(context, beehive, l10n),
                    const SizedBox(height: 16),
                  ],

                  // === NOTES CARD ===
                  if (beehive.notes != null && beehive.notes!.isNotEmpty)
                    _buildSectionCard(
                      context: context,
                      title: l10n.notes,
                      icon: Icons.notes,
                      children: [
                        Text(
                          beehive.notes!,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[300] : Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // === DATES CARD ===
                  _buildSectionCard(
                    context: context,
                    title: l10n.dates,
                    icon: Icons.calendar_today,
                    children: [
                      _buildInfoRow(
                        icon: '📅',
                        label: l10n.createdAt,
                        value: _formatDate(beehive.createdAt),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        icon: '🔄',
                        label: l10n.updatedAt,
                        value: _formatDate(beehive.updatedAt),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // === ACTION BUTTONS ===
                  _buildActionButtons(context, l10n, primaryColor),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    final beehive = widget.beehive;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Image PageView
        PageView.builder(
          controller: _imagePageController,
          itemCount: beehive.images.length,
          onPageChanged: (index) {
            setState(() => _currentImageIndex = index);
          },
          itemBuilder: (context, index) {
            final image = beehive.images[index];
            return GestureDetector(
              onTap: () => _showFullScreenImage(context, index),
              child: Image.file(File(image.imageUrl), fit: BoxFit.cover),
            );
          },
        ),

        // Image type badge
        if (beehive.images.isNotEmpty)
          Positioned(
            bottom: 60,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    beehive.images[_currentImageIndex].type.emoji,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getImageTypeLabel(
                      beehive.images[_currentImageIndex].type,
                      AppLocalizations.of(context)!,
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

        // Page indicator
        if (beehive.images.length > 1)
          Positioned(
            bottom: 60,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${beehive.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

        // Gradient overlay for title
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderHeader(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
        ),
      ),
      child: const Center(child: Text('🐝', style: TextStyle(fontSize: 80))),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    Color? iconColor,
    required List<Widget> children,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Container(
      width: double.infinity,
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
              Icon(icon, size: 20, color: iconColor ?? primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String label,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildHealthStatusRow(HealthStatus status, AppLocalizations l10n) {
    Color statusColor;
    switch (status) {
      case HealthStatus.healthy:
        statusColor = Colors.green;
        break;
      case HealthStatus.weak:
        statusColor = Colors.orange;
        break;
      case HealthStatus.sick:
        statusColor = Colors.red;
        break;
      case HealthStatus.critical:
        statusColor = Colors.red[900]!;
        break;
      case HealthStatus.unknown:
        statusColor = Colors.grey;
        break;
    }

    return Row(
      children: [
        Text(status.emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            l10n.healthStatus,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]
                  : Colors.grey[600],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withOpacity(0.3)),
          ),
          child: Text(
            _getHealthStatusLabel(status, l10n),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQueenInfoCard(
    BuildContext context,
    Beehive beehive,
    AppLocalizations l10n,
    Color primaryColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
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
              Icon(Icons.star, size: 20, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                l10n.queenInfo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Queen status banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: beehive.hasQueen
                  ? Colors.amber.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: beehive.hasQueen
                    ? Colors.amber.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  beehive.hasQueen ? '👑' : '❌',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  beehive.hasQueen ? l10n.queenPresent : l10n.noQueen,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: beehive.hasQueen
                        ? Colors.amber[800]
                        : Colors.red[700],
                  ),
                ),
              ],
            ),
          ),

          // Queen details (if has queen)
          if (beehive.hasQueen) ...[
            const SizedBox(height: 16),

            if (beehive.queenType != null)
              _buildInfoRow(
                icon: '📍',
                label: l10n.queenOrigin,
                value: _getQueenTypeLabel(beehive.queenType!, l10n),
              ),

            if (beehive.queenBreed != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: '🐝',
                label: l10n.queenBreed,
                value: _getQueenBreedLabel(beehive.queenBreed!, l10n),
              ),
            ],

            if (beehive.queenAddedDate != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: '📅',
                label: l10n.queenAddedDate,
                value: _formatDate(beehive.queenAddedDate!),
              ),
            ],

            const SizedBox(height: 12),

            // Queen marking info
            Row(
              children: [
                const Text('🏷️', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.queenMarked,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                if (beehive.isQueenMarked && beehive.queenMarkingColor != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(
                          beehive.queenMarkingColor!.colorCode.replaceFirst(
                            '#',
                            '0xFF',
                          ),
                        ),
                      ).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(
                          int.parse(
                            beehive.queenMarkingColor!.colorCode.replaceFirst(
                              '#',
                              '0xFF',
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(
                                beehive.queenMarkingColor!.colorCode
                                    .replaceFirst('#', '0xFF'),
                              ),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getMarkingColorLabel(
                            beehive.queenMarkingColor!,
                            l10n,
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    beehive.isQueenMarked ? l10n.yes : l10n.no,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPhotosSection(
    BuildContext context,
    Beehive beehive,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Container(
      width: double.infinity,
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
              Icon(Icons.photo_library, size: 20, color: primaryColor),
              const SizedBox(width: 8),
              Text(
                '${l10n.photos} (${beehive.images.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Photo grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: beehive.images.length,
            itemBuilder: (context, index) {
              final image = beehive.images[index];
              return GestureDetector(
                onTap: () => _showFullScreenImage(context, index),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Type badge
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
      ),
    );
  }

Widget _buildActionButtons(
  BuildContext context,
  AppLocalizations l10n,
  Color primaryColor,
) {
  return Column(
    children: [
      // Add Inspection button
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddInspectionScreen(
                  beehiveId: widget.beehive.id,
                  beehiveName: widget.beehive.name ?? '${l10n.hive} #${widget.beehive.systemNumber}',
               
                 apiaryId: widget.beehive.apiaryId, 
                ),
              ),
            );
          },
          icon: const Icon(Icons.assignment_add),
          label: Text(l10n.addInspection),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),

      // View Inspections button
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InspectionsListScreen(
                  beehiveId: widget.beehive.id,
                  beehiveName: widget.beehive.name ?? '${l10n.hive} #${widget.beehive.systemNumber}',
               
                 apiaryId: widget.beehive.apiaryId,  
                ),
              ),
            );
          },
          icon: const Icon(Icons.history),
          label: Text(l10n.viewInspections),
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ],
  );
}
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// === FULL SCREEN IMAGE VIEWER ===

class _FullScreenImageViewer extends StatefulWidget {
  final List<BeehiveImage> images;
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

  String _getImageTypeLabel(ImageType type, AppLocalizations l10n) {
    switch (type) {
      case ImageType.queen:
        return l10n.imageTypeQueen;
      case ImageType.brood:
        return l10n.imageTypeBrood;
      case ImageType.honey:
        return l10n.imageTypeHoney;
      case ImageType.frames:
        return l10n.imageTypeFrames;
      case ImageType.disease:
        return l10n.imageTypeDisease;
      case ImageType.general:
        return l10n.imageTypeGeneral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            Text(_getImageTypeLabel(currentImage.type, l10n)),
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
                File(widget.images[index].imageUrl),
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
