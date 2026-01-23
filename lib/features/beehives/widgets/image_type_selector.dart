import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../models/beehive_image_model.dart';

class ImageTypeSelector extends StatelessWidget {
  final Function(ImageType) onSelected;

  const ImageTypeSelector({
    super.key,
    required this.onSelected,
  });

  static Future<ImageType?> show(BuildContext context) {
    return showModalBottomSheet<ImageType>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ImageTypeSelector(
        onSelected: (type) => Navigator.pop(context, type),
      ),
    );
  }

  String _getImageTypeLabel(ImageType type, AppLocalizations l10n) {
    switch (type) {
      case ImageType.queen: return l10n.imageTypeQueen;
      case ImageType.brood: return l10n.imageTypeBrood;
      case ImageType.honey: return l10n.imageTypeHoney;
      case ImageType.frames: return l10n.imageTypeFrames;
      case ImageType.disease: return l10n.imageTypeDisease;
      case ImageType.general: return l10n.imageTypeGeneral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            l10n.selectImageType,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.whatDoesPhotoShow,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // Image type grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              physics: const NeverScrollableScrollPhysics(),
              children: ImageType.values.map((type) {
                return _ImageTypeCard(
                  type: type,
                  label: _getImageTypeLabel(type, l10n),
                  onTap: () => onSelected(type),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _ImageTypeCard extends StatelessWidget {
  final ImageType type;
  final String label;
  final VoidCallback onTap;

  const _ImageTypeCard({
    required this.type,
    required this.label,
    required this.onTap,
  });

  Color _getTypeColor() {
    switch (type) {
      case ImageType.queen: return const Color(0xFFFFB300);
      case ImageType.brood: return const Color(0xFF8D6E63);
      case ImageType.honey: return const Color(0xFFFFA000);
      case ImageType.frames: return const Color(0xFF5C6BC0);
      case ImageType.disease: return const Color(0xFFE53935);
      case ImageType.general: return const Color(0xFF78909C);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type.emoji,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}