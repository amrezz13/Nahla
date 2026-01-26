
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../../../l10n/app_localizations.dart';
import '../models/inspection_model.dart';

class AddInspectionScreen extends StatefulWidget {
  final String beehiveId;
  final String beehiveName;
    final String apiaryId;  


  const AddInspectionScreen({
    super.key,
    required this.beehiveId,
    required this.beehiveName,
        required this.apiaryId,  

  });

  @override
  State<AddInspectionScreen> createState() => _AddInspectionScreenState();
}

class _AddInspectionScreenState extends State<AddInspectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();
  final _imagePicker = ImagePicker();

  // Controllers
  final _temperatureController = TextEditingController();
  final _inspectorNameController = TextEditingController();
  final _framesOfBeesController = TextEditingController();
  final _framesOfBroodController = TextEditingController();
  final _actionNotesController = TextEditingController();
  final _notesController = TextEditingController();

  // Form state - Basic Info
  DateTime _inspectionDate = DateTime.now();
  TimeOfDay _inspectionTime = TimeOfDay.now();
  WeatherCondition? _weather;

  // Colony Status
  bool _queenSeen = false;
  bool _queenCellsSeen = false;
  bool _eggsSeen = false;
  bool _larvaeSeen = false;
  BroodPattern? _broodPattern;

  // Population
  PopulationStrength? _populationStrength;

  // Food Stores
  StoresLevel? _honeyStores;
  StoresLevel? _pollenStores;
  bool _needsFeeding = false;

  // Health
  Temperament? _temperament;
  List<Disease> _diseasesObserved = [];
  List<Pest> _pestsObserved = [];

  // Actions
  List<ActionTaken> _actionsTaken = [];

  // Images
  List<InspectionImage> _images = [];

  @override
  void dispose() {
    _temperatureController.dispose();
    _inspectorNameController.dispose();
    _framesOfBeesController.dispose();
    _framesOfBroodController.dispose();
    _actionNotesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _inspectionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _inspectionDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _inspectionTime,
    );
    if (picked != null) {
      setState(() => _inspectionTime = picked);
    }
  }

  Future<void> _addImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile == null) return;

    // Show type selector
    final type = await _showImageTypeSelector();
    if (type == null) return;

setState(() {
  _images.add(InspectionImage(
    id: _uuid.v4(),
    inspectionId: '',
    imageUrl: pickedFile.path,      // Local path for preview
    storagePath: pickedFile.path,   // Same path for now
    type: type,
    takenAt: DateTime.now(),
  ));
});
  }

  Future<InspectionImageType?> _showImageTypeSelector() async {
      final l10n = AppLocalizations.of(context)!; 

    return showModalBottomSheet<InspectionImageType>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Image Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: InspectionImageType.values.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ActionChip(
                    avatar: Text(type.emoji),
                    label: Text(type.getLabel(l10n)),
                    onPressed: () => Navigator.pop(context, type),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _removeImage(String imageId) {
    setState(() {
      _images.removeWhere((img) => img.id == imageId);
    });
  }

  void _saveInspection() {
    if (!_formKey.currentState!.validate()) return;

    final inspectionDateTime = DateTime(
      _inspectionDate.year,
      _inspectionDate.month,
      _inspectionDate.day,
      _inspectionTime.hour,
      _inspectionTime.minute,
    );

    final inspection = Inspection(
      id: _uuid.v4(),
      beehiveId: widget.beehiveId,
       apiaryId: widget.apiaryId,  
  userId: '',              
      inspectionDate: inspectionDateTime,
      weather: _weather,
      temperature: _temperatureController.text.isNotEmpty
          ? double.tryParse(_temperatureController.text)
          : null,
      inspectorName: _inspectorNameController.text.trim().isEmpty
          ? null
          : _inspectorNameController.text.trim(),
      queenSeen: _queenSeen,
      queenCellsSeen: _queenCellsSeen,
      eggsSeen: _eggsSeen,
      larvaeSeen: _larvaeSeen,
      broodPattern: _broodPattern,
      populationStrength: _populationStrength,
      framesOfBees: _framesOfBeesController.text.isNotEmpty
          ? int.tryParse(_framesOfBeesController.text)
          : null,
      framesOfBrood: _framesOfBroodController.text.isNotEmpty
          ? int.tryParse(_framesOfBroodController.text)
          : null,
      honeyStores: _honeyStores,
      pollenStores: _pollenStores,
      needsFeeding: _needsFeeding,
      temperament: _temperament,
      diseasesObserved: _diseasesObserved,
      pestsObserved: _pestsObserved,
      actionsTaken: _actionsTaken,
      actionNotes: _actionNotesController.text.trim().isEmpty
          ? null
          : _actionNotesController.text.trim(),
      images: _images,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Navigator.pop(context, inspection);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.amber[700]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(l10n.addInspection),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Beehive indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Text('🐝', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.inspectingHive,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        Text(
                          widget.beehiveName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // === BASIC INFO SECTION ===
            _SectionCard(
              title: l10n.basicInfo,
              icon: Icons.info_outline,
              children: [
                // Date & Time row
                Row(
                  children: [
                    Expanded(
                      child: _DateTimeField(
                        label: l10n.date,
                        value: '${_inspectionDate.day}/${_inspectionDate.month}/${_inspectionDate.year}',
                        icon: Icons.calendar_today,
                        onTap: _selectDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DateTimeField(
                        label: l10n.time,
                        value: _inspectionTime.format(context),
                        icon: Icons.access_time,
                        onTap: _selectTime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Weather
                Text(
                  l10n.weather,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: WeatherCondition.values.map((weather) {
                    final isSelected = _weather == weather;
                    return ChoiceChip(
                      label: Text('${weather.emoji} ${weather.getLabel(l10n)}'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _weather = selected ? weather : null);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Temperature
                TextFormField(
                  controller: _temperatureController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.temperature,
                    hintText: '25',
                    suffixText: '°C',
                    prefixIcon: const Icon(Icons.thermostat),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === COLONY STATUS SECTION ===
            _SectionCard(
              title: l10n.colonyStatus,
              icon: Icons.hive,
              iconColor: Colors.amber,
              children: [
                // Quick toggles
                _ToggleRow(
                  emoji: '👑',
                  label: l10n.queenSeen,
                  value: _queenSeen,
                  onChanged: (v) => setState(() => _queenSeen = v),
                ),
                _ToggleRow(
                  emoji: '👑',
                  label: l10n.queenCellsSeen,
                  value: _queenCellsSeen,
                  onChanged: (v) => setState(() => _queenCellsSeen = v),
                  warning: true,
                ),
                _ToggleRow(
                  emoji: '🥚',
                  label: l10n.eggsSeen,
                  value: _eggsSeen,
                  onChanged: (v) => setState(() => _eggsSeen = v),
                ),
                _ToggleRow(
                  emoji: '🐛',
                  label: l10n.larvaeSeen,
                  value: _larvaeSeen,
                  onChanged: (v) => setState(() => _larvaeSeen = v),
                ),
                const Divider(height: 24),

                // Brood pattern
                Text(
                  l10n.broodPattern,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: BroodPattern.values.map((pattern) {
                    final isSelected = _broodPattern == pattern;
                    return ChoiceChip(
                      label: Text('${pattern.emoji} ${pattern.getLabel(l10n)}'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _broodPattern = selected ? pattern : null);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === POPULATION SECTION ===
            _SectionCard(
              title: l10n.population,
              icon: Icons.groups,
              children: [
                // Population strength
                Text(
                  l10n.populationStrength,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: PopulationStrength.values.map((strength) {
                    final isSelected = _populationStrength == strength;
                    return ChoiceChip(
                      label: Text('${strength.emoji} ${strength.getLabel(l10n)}'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _populationStrength = selected ? strength : null);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Frames
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _framesOfBeesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.framesOfBees,
                          prefixIcon: const Icon(Icons.view_column),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _framesOfBroodController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.framesOfBrood,
                          prefixIcon: const Icon(Icons.child_care),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === FOOD STORES SECTION ===
            _SectionCard(
              title: l10n.foodStores,
              icon: Icons.inventory_2,
              iconColor: Colors.orange,
              children: [
                // Honey stores
                _StoresSelector(
                  label: l10n.honeyStores,
                  emoji: '🍯',
                  value: _honeyStores,
                  onChanged: (v) => setState(() => _honeyStores = v),
                ),
                const SizedBox(height: 12),

                // Pollen stores
                _StoresSelector(
                  label: l10n.pollenStores,
                  emoji: '🌼',
                  value: _pollenStores,
                  onChanged: (v) => setState(() => _pollenStores = v),
                ),
                const SizedBox(height: 12),

                // Needs feeding
                _ToggleRow(
                  emoji: '🍽️',
                  label: l10n.needsFeeding,
                  value: _needsFeeding,
                  onChanged: (v) => setState(() => _needsFeeding = v),
                  warning: _needsFeeding,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === HEALTH SECTION ===
            _SectionCard(
              title: l10n.health,
              icon: Icons.health_and_safety,
              iconColor: Colors.red,
              children: [
                // Temperament
                Text(
                  l10n.temperament,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: Temperament.values.map((temp) {
                    final isSelected = _temperament == temp;
                    return ChoiceChip(
                      label: Text('${temp.emoji} ${temp.getLabel(l10n)}'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _temperament = selected ? temp : null);
                      },
                    );
                  }).toList(),
                ),
                const Divider(height: 24),

                // Diseases
                Text(
                  l10n.diseasesObserved,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: Disease.values.map((disease) {
                    final isSelected = _diseasesObserved.contains(disease);
                    return FilterChip(
                      label: Text(disease.getLabel(l10n)),
                      selected: isSelected,
                      selectedColor: Colors.red.withOpacity(0.2),
                      checkmarkColor: Colors.red,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _diseasesObserved.add(disease);
                          } else {
                            _diseasesObserved.remove(disease);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const Divider(height: 24),

                // Pests
                Text(
                  l10n.pestsObserved,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: Pest.values.map((pest) {
                    final isSelected = _pestsObserved.contains(pest);
                    return FilterChip(
                      label: Text('${pest.emoji} ${pest.getLabel(l10n)}'),
                      selected: isSelected,
                      selectedColor: Colors.orange.withOpacity(0.2),
                      checkmarkColor: Colors.orange,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _pestsObserved.add(pest);
                          } else {
                            _pestsObserved.remove(pest);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // === ACTIONS SECTION ===
            _SectionCard(
              title: l10n.actionsTaken,
              icon: Icons.construction,
              iconColor: Colors.blue,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ActionTaken.values.map((action) {
                    final isSelected = _actionsTaken.contains(action);
                    return FilterChip(
                      label: Text('${action.emoji} ${action.getLabel(l10n)}'),
                      selected: isSelected,
                      selectedColor: Colors.blue.withOpacity(0.2),
                      checkmarkColor: Colors.blue,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _actionsTaken.add(action);
                          } else {
                            _actionsTaken.remove(action);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                if (_actionsTaken.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _actionNotesController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: l10n.actionNotes,
                      hintText: l10n.actionNotesHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // === PHOTOS SECTION ===
            _SectionCard(
              title: l10n.photos,
              icon: Icons.photo_library,
              children: [
                if (_images.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.noPhotosYet,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(image.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removeImage(image.id),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
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
                      );
                    },
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _addImage,
                    icon: const Icon(Icons.add_a_photo),
                    label: Text(l10n.addPhoto),
                  ),
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
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: l10n.inspectionNotesHint,
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
              onPressed: _saveInspection,
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
                    l10n.saveInspection,
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

class _DateTimeField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _DateTimeField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(value),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String emoji;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool warning;

  const _ToggleRow({
    required this.emoji,
    required this.label,
    required this.value,
    required this.onChanged,
    this.warning = false,
  });

  @override
  Widget build(BuildContext context) {
      final l10n = AppLocalizations.of(context)!;  

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: warning && value ? Colors.orange[700] : null,
                fontWeight: warning && value ? FontWeight.w600 : null,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: warning ? Colors.orange : Colors.amber[700],
          ),
        ],
      ),
    );
  }
}

class _StoresSelector extends StatelessWidget {
  final String label;
  final String emoji;
  final StoresLevel? value;
  final ValueChanged<StoresLevel?> onChanged;

  const _StoresSelector({
    required this.label,
    required this.emoji,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
        ToggleButtons(
          isSelected: StoresLevel.values.map((l) => l == value).toList(),
          onPressed: (index) {
            final newValue = StoresLevel.values[index];
            onChanged(value == newValue ? null : newValue);
          },
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.white,
          fillColor: value == StoresLevel.low
              ? Colors.red
              : value == StoresLevel.adequate
                  ? Colors.orange
                  : Colors.green,
          children: StoresLevel.values.map((level) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(level.emoji),
            );
          }).toList(),
        ),
      ],
    );
  }
}