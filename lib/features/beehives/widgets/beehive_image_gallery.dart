import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../l10n/app_localizations.dart';
import '../models/beehive_image_model.dart';
import 'image_type_selector.dart';

class BeehiveImageGallery extends StatelessWidget {
  final List<BeehiveImage> images;
  final Function(String imagePath, ImageType type) onImageAdded;
  final Function(String imageId) onImageRemoved;
  final bool editable;

  const BeehiveImageGallery({
    super.key,
    required this.images,
    required this.onImageAdded,
    required this.onImageRemoved,
    this.editable = true,
  });

  Future<void> _pickImage(BuildContext context) async {
    final source = await _showImageSourceDialog(context);
    if (source == null) return;

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (pickedFile == null) return;
    if (!context.mounted) return;

    final imageType = await ImageTypeSelector.show(context);
    if (imageType == null) return;

    onImageAdded(pickedFile.path, imageType);
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.addPhoto,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _SourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: l10n.camera,
                  color: const Color(0xFFFFB300),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                _SourceOption(
                  icon: Icons.photo_library_rounded,
                  label: l10n.gallery,
                  color: const Color(0xFF5C6BC0),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
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

    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Add button
          if (editable)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _AddImageButton(
                label: l10n.add,
                onTap: () => _pickImage(context),
              ),
            ),

          // Existing images
          ...images.map((image) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ImageTile(
              image: image,
              typeLabel: _getImageTypeLabel(image.type, l10n),
              editable: editable,
              onRemove: () => onImageRemoved(image.id),
            ),
          )),
        ],
      ),
    );
  }
}

// === SOURCE OPTION BUTTON ===
class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === ADD IMAGE BUTTON ===
class _AddImageButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AddImageButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 32,
              color: isDark ? Colors.white60 : Colors.black45,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white60 : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === IMAGE TILE ===
class _ImageTile extends StatelessWidget {
  final BeehiveImage image;
  final String typeLabel;
  final bool editable;
  final VoidCallback onRemove;

  const _ImageTile({
    required this.image,
    required this.typeLabel,
    required this.editable,
    required this.onRemove,
  });

  Color _getTypeColor() {
    switch (image.type) {
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

    return Stack(
      children: [
        // Image container
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(image.imageUrl),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ),

        // Type badge (bottom left)
        Positioned(
          bottom: 6,
          left: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(image.type.emoji, style: const TextStyle(fontSize: 10)),
                const SizedBox(width: 3),
                Text(
                  typeLabel,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Remove button (top right)
        if (editable)
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}