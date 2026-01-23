import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../l10n/app_localizations.dart';
import '../models/beehive_model.dart';
import '../models/beehive_image_model.dart';
import '../widgets/image_type_selector.dart';
import '../widgets/beehive_image_gallery.dart';

class AddBeehiveScreen extends StatefulWidget {
  final String apiaryId;
  final int nextSystemNumber;

  const AddBeehiveScreen({
    super.key,
    required this.apiaryId,
    required this.nextSystemNumber,
  });

  @override
  State<AddBeehiveScreen> createState() => _AddBeehiveScreenState();
}

class _AddBeehiveScreenState extends State<AddBeehiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Controllers
  final _hiveNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  // Form state
  int _frameCount = 10;
  bool _hasQueen = true;
  QueenType? _queenType;
  QueenBreed? _queenBreed;
  DateTime? _queenAddedDate;
  bool _isQueenMarked = false;
  QueenMarkingColor? _queenMarkingColor;
  HealthStatus _healthStatus = HealthStatus.healthy;
  List<BeehiveImage> _images = [];

  @override
  void dispose() {
    _hiveNumberController.dispose();
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addImage(String imagePath, ImageType type) {
    setState(() {
      _images.add(BeehiveImage(
        id: _uuid.v4(),
        beehiveId: '',
        imagePath: imagePath,
        type: type,
        takenAt: DateTime.now(),
      ));
    });
  }

  void _removeImage(String imageId) {
    setState(() {
      _images.removeWhere((img) => img.id == imageId);
    });
  }

  Future<void> _selectQueenAddedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _queenAddedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _queenAddedDate = picked);
    }
  }

  void _saveBeehive() {
    if (!_formKey.currentState!.validate()) return;

    final beehive = Beehive(
      id: _uuid.v4(),
      apiaryId: widget.apiaryId,
      systemNumber: widget.nextSystemNumber,
      hiveNumber: _hiveNumberController.text.trim(),
      name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
      frameCount: _frameCount,
      hasQueen: _hasQueen,
      queenType: _hasQueen ? _queenType : null,
      queenBreed: _hasQueen ? _queenBreed : null,
      queenAddedDate: _hasQueen ? _queenAddedDate : null,
      isQueenMarked: _hasQueen ? _isQueenMarked : false,
      queenMarkingColor: _hasQueen && _isQueenMarked ? _queenMarkingColor : null,
      healthStatus: _healthStatus,
      images: _images,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Navigator.pop(context, beehive);
  }

  // === LOCALIZED LABEL HELPERS ===
  
  String _getQueenTypeLabel(QueenType type, AppLocalizations l10n) {
    switch (type) {
      case QueenType.local: return l10n.queenTypeLocal;
      case QueenType.imported: return l10n.queenTypeImported;
      case QueenType.bred: return l10n.queenTypeBred;
      case QueenType.swarm: return l10n.queenTypeSwarm;
      case QueenType.purchased: return l10n.queenTypePurchased;
      case QueenType.unknown: return l10n.queenTypeUnknown;
    }
  }

  String _getQueenBreedLabel(QueenBreed breed, AppLocalizations l10n) {
    switch (breed) {
      case QueenBreed.italian: return l10n.queenBreedItalian;
      case QueenBreed.carniolan: return l10n.queenBreedCarniolan;
      case QueenBreed.buckfast: return l10n.queenBreedBuckfast;
      case QueenBreed.caucasian: return l10n.queenBreedCaucasian;
      case QueenBreed.local: return l10n.queenBreedLocal;
      case QueenBreed.hybrid: return l10n.queenBreedHybrid;
      case QueenBreed.other: return l10n.queenBreedOther;
    }
  }

  String _getHealthStatusLabel(HealthStatus status, AppLocalizations l10n) {
    switch (status) {
      case HealthStatus.healthy: return l10n.healthHealthy;
      case HealthStatus.weak: return l10n.healthWeak;
      case HealthStatus.sick: return l10n.healthSick;
      case HealthStatus.critical: return l10n.healthCritical;
      case HealthStatus.unknown: return l10n.healthUnknown;
    }
  }

  String _getMarkingColorLabel(QueenMarkingColor color, AppLocalizations l10n) {
    switch (color) {
      case QueenMarkingColor.white: return l10n.markingColorWhite;
      case QueenMarkingColor.yellow: return l10n.markingColorYellow;
      case QueenMarkingColor.red: return l10n.markingColorRed;
      case QueenMarkingColor.green: return l10n.markingColorGreen;
      case QueenMarkingColor.blue: return l10n.markingColorBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(l10n.addBeehive),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // === IDENTIFICATION SECTION ===
            _SectionCard(
              title: l10n.identification,
              icon: Icons.tag,
              children: [
                // System number (read-only)
                _InfoRow(
                  label: l10n.systemNumber,
                  value: '#${widget.nextSystemNumber.toString().padLeft(3, '0')}',
                  subtitle: l10n.autoGenerated,
                ),
                const SizedBox(height: 16),

                // Hive number
                TextFormField(
                  controller: _hiveNumberController,
                  decoration: InputDecoration(
                    labelText: '${l10n.hiveNumber} *',
                    hintText: l10n.hiveNumberHint,
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.pleaseEnterHiveNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Name (optional)
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.nameOptional,
                    hintText: l10n.nameHint,
                    prefixIcon: const Icon(Icons.label_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === HIVE INFO SECTION ===
            _SectionCard(
              title: l10n.hiveInfo,
              icon: Icons.grid_view_rounded,
              children: [
                // Frame count
                Row(
                  children: [
                    const Icon(Icons.view_column_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text('${l10n.frames}:', style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    IconButton(
                      onPressed: _frameCount > 1
                          ? () => setState(() => _frameCount--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$_frameCount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _frameCount < 20
                          ? () => setState(() => _frameCount++)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Health status
                DropdownButtonFormField<HealthStatus>(
                  value: _healthStatus,
                  decoration: InputDecoration(
                    labelText: l10n.healthStatus,
                    prefixIcon: const Icon(Icons.favorite_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: HealthStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Row(
                        children: [
                          Text(status.emoji),
                          const SizedBox(width: 8),
                          Text(_getHealthStatusLabel(status, l10n)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _healthStatus = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === QUEEN SECTION ===
            _SectionCard(
              title: l10n.queenInfo,
              icon: Icons.star,
              iconColor: Colors.amber,
              children: [
                // Has queen switch
                SwitchListTile(
                  title: Text(l10n.hasQueen),
                  subtitle: Text(_hasQueen ? l10n.queenPresent : l10n.noQueen),
                  secondary: Text(_hasQueen ? '👑' : '❌', style: const TextStyle(fontSize: 24)),
                  value: _hasQueen,
                  onChanged: (value) => setState(() => _hasQueen = value),
                  contentPadding: EdgeInsets.zero,
                ),

                if (_hasQueen) ...[
                  const Divider(height: 24),

                  // Queen Type
                  DropdownButtonFormField<QueenType>(
                    value: _queenType,
                    decoration: InputDecoration(
                      labelText: l10n.queenOrigin,
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: QueenType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getQueenTypeLabel(type, l10n)),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _queenType = value),
                  ),
                  const SizedBox(height: 16),

                  // Queen Breed
                  DropdownButtonFormField<QueenBreed>(
                    value: _queenBreed,
                    decoration: InputDecoration(
                      labelText: l10n.queenBreed,
                      prefixIcon: const Icon(Icons.pets),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: QueenBreed.values.map((breed) {
                      return DropdownMenuItem(
                        value: breed,
                        child: Text(_getQueenBreedLabel(breed, l10n)),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _queenBreed = value),
                  ),
                  const SizedBox(height: 16),

                  // Queen Added Date
                  InkWell(
                    onTap: _selectQueenAddedDate,
                    borderRadius: BorderRadius.circular(12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: l10n.queenAddedDate,
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _queenAddedDate != null
                            ? '${_queenAddedDate!.day}/${_queenAddedDate!.month}/${_queenAddedDate!.year}'
                            : l10n.selectDate,
                        style: TextStyle(
                          color: _queenAddedDate != null ? null : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Queen Marked
                  SwitchListTile(
                    title: Text(l10n.queenMarked),
                    value: _isQueenMarked,
                    onChanged: (value) => setState(() => _isQueenMarked = value),
                    contentPadding: EdgeInsets.zero,
                  ),

                  // Marking Color
                  if (_isQueenMarked) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.markingColor,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: QueenMarkingColor.values.map((color) {
                        final isSelected = _queenMarkingColor == color;
                        return ChoiceChip(
                          label: Text(_getMarkingColorLabel(color, l10n).split(' ')[0]),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() => _queenMarkingColor = selected ? color : null);
                          },
                          avatar: CircleAvatar(
                            backgroundColor: Color(
                              int.parse(color.colorCode.replaceFirst('#', '0xFF')),
                            ),
                            radius: 10,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ],
            ),
            const SizedBox(height: 16),

            // === PHOTOS SECTION ===
            _SectionCard(
              title: l10n.photos,
              icon: Icons.photo_library_outlined,
              children: [
                BeehiveImageGallery(
                  images: _images,
                  onImageAdded: _addImage,
                  onImageRemoved: _removeImage,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === NOTES SECTION ===
            _SectionCard(
              title: l10n.notes,
              icon: Icons.notes,
              children: [
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.addNotesHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // === SAVE BUTTON ===
            ElevatedButton(
              onPressed: _saveBeehive,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save),
                  const SizedBox(width: 8),
                  Text(
                    l10n.saveBeehive,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;

  const _InfoRow({
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            if (subtitle != null)
              Text(subtitle!, style: TextStyle(color: Colors.grey[400], fontSize: 10)),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber[700]!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber[700]),
          ),
        ),
      ],
    );
  }
}