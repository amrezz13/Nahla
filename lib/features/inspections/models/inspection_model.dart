// lib/features/inspections/models/inspection_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../l10n/app_localizations.dart';

// === WEATHER CONDITION ===
enum WeatherCondition { sunny, partlyCloudy, cloudy, rainy, windy, hot, cold }

extension WeatherConditionExtension on WeatherCondition {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case WeatherCondition.sunny: return l10n.weatherSunny;
      case WeatherCondition.partlyCloudy: return l10n.weatherPartlyCloudy;
      case WeatherCondition.cloudy: return l10n.weatherCloudy;
      case WeatherCondition.rainy: return l10n.weatherRainy;
      case WeatherCondition.windy: return l10n.weatherWindy;
      case WeatherCondition.hot: return l10n.weatherHot;
      case WeatherCondition.cold: return l10n.weatherCold;
    }
  }

  String get emoji {
    switch (this) {
      case WeatherCondition.sunny: return '☀️';
      case WeatherCondition.partlyCloudy: return '⛅';
      case WeatherCondition.cloudy: return '☁️';
      case WeatherCondition.rainy: return '🌧️';
      case WeatherCondition.windy: return '💨';
      case WeatherCondition.hot: return '🔥';
      case WeatherCondition.cold: return '❄️';
    }
  }
}

// === BROOD PATTERN ===
enum BroodPattern { excellent, good, spotty, poor, none }

extension BroodPatternExtension on BroodPattern {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case BroodPattern.excellent: return l10n.broodExcellent;
      case BroodPattern.good: return l10n.broodGood;
      case BroodPattern.spotty: return l10n.broodSpotty;
      case BroodPattern.poor: return l10n.broodPoor;
      case BroodPattern.none: return l10n.broodNone;
    }
  }

  String get emoji {
    switch (this) {
      case BroodPattern.excellent: return '🌟';
      case BroodPattern.good: return '✅';
      case BroodPattern.spotty: return '⚠️';
      case BroodPattern.poor: return '😟';
      case BroodPattern.none: return '❌';
    }
  }
}

// === POPULATION STRENGTH ===
enum PopulationStrength { strong, medium, weak, veryWeak }

extension PopulationStrengthExtension on PopulationStrength {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case PopulationStrength.strong: return l10n.populationStrong;
      case PopulationStrength.medium: return l10n.populationMedium;
      case PopulationStrength.weak: return l10n.populationWeak;
      case PopulationStrength.veryWeak: return l10n.populationVeryWeak;
    }
  }

  String get emoji {
    switch (this) {
      case PopulationStrength.strong: return '💪';
      case PopulationStrength.medium: return '👍';
      case PopulationStrength.weak: return '👎';
      case PopulationStrength.veryWeak: return '⚠️';
    }
  }
}

// === STORES LEVEL ===
enum StoresLevel { low, adequate, high }

extension StoresLevelExtension on StoresLevel {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case StoresLevel.low: return l10n.storesLow;
      case StoresLevel.adequate: return l10n.storesAdequate;
      case StoresLevel.high: return l10n.storesHigh;
    }
  }

  String get emoji {
    switch (this) {
      case StoresLevel.low: return '🔴';
      case StoresLevel.adequate: return '🟡';
      case StoresLevel.high: return '🟢';
    }
  }
}

// === TEMPERAMENT ===
enum Temperament { calm, nervous, aggressive }

extension TemperamentExtension on Temperament {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case Temperament.calm: return l10n.temperamentCalm;
      case Temperament.nervous: return l10n.temperamentNervous;
      case Temperament.aggressive: return l10n.temperamentAggressive;
    }
  }

  String get emoji {
    switch (this) {
      case Temperament.calm: return '😊';
      case Temperament.nervous: return '😰';
      case Temperament.aggressive: return '😠';
    }
  }
}

// === DISEASE ===
enum Disease {
  varroa,
  americanFoulbrood,
  europeanFoulbrood,
  nosema,
  chalkbrood,
  sacbrood,
  other,
}

extension DiseaseExtension on Disease {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case Disease.varroa: return l10n.diseaseVarroa;
      case Disease.americanFoulbrood: return l10n.diseaseAmericanFoulbrood;
      case Disease.europeanFoulbrood: return l10n.diseaseEuropeanFoulbrood;
      case Disease.nosema: return l10n.diseaseNosema;
      case Disease.chalkbrood: return l10n.diseaseChalkbrood;
      case Disease.sacbrood: return l10n.diseaseSacbrood;
      case Disease.other: return l10n.diseaseOther;
    }
  }
}

// === PEST ===
enum Pest {
  smallHiveBeetle,
  waxMoth,
  ants,
  wasps,
  mice,
  other,
}

extension PestExtension on Pest {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case Pest.smallHiveBeetle: return l10n.pestSmallHiveBeetle;
      case Pest.waxMoth: return l10n.pestWaxMoth;
      case Pest.ants: return l10n.pestAnts;
      case Pest.wasps: return l10n.pestWasps;
      case Pest.mice: return l10n.pestMice;
      case Pest.other: return l10n.pestOther;
    }
  }

  String get emoji {
    switch (this) {
      case Pest.smallHiveBeetle: return '🪲';
      case Pest.waxMoth: return '🦋';
      case Pest.ants: return '🐜';
      case Pest.wasps: return '🐝';
      case Pest.mice: return '🐭';
      case Pest.other: return '🐛';
    }
  }
}

// === ACTION TAKEN ===
enum ActionTaken {
  addedFrames,
  removedFrames,
  fedSugarSyrup,
  fedPollen,
  treatedVarroa,
  treatedDisease,
  requeened,
  splitHive,
  combinedHives,
  addedSuper,
  removedSuper,
  harvestedHoney,
  markedQueen,
  clippedQueen,
  other,
}

extension ActionTakenExtension on ActionTaken {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case ActionTaken.addedFrames: return l10n.actionAddedFrames;
      case ActionTaken.removedFrames: return l10n.actionRemovedFrames;
      case ActionTaken.fedSugarSyrup: return l10n.actionFedSugarSyrup;
      case ActionTaken.fedPollen: return l10n.actionFedPollen;
      case ActionTaken.treatedVarroa: return l10n.actionTreatedVarroa;
      case ActionTaken.treatedDisease: return l10n.actionTreatedDisease;
      case ActionTaken.requeened: return l10n.actionRequeened;
      case ActionTaken.splitHive: return l10n.actionSplitHive;
      case ActionTaken.combinedHives: return l10n.actionCombinedHives;
      case ActionTaken.addedSuper: return l10n.actionAddedSuper;
      case ActionTaken.removedSuper: return l10n.actionRemovedSuper;
      case ActionTaken.harvestedHoney: return l10n.actionHarvestedHoney;
      case ActionTaken.markedQueen: return l10n.actionMarkedQueen;
      case ActionTaken.clippedQueen: return l10n.actionClippedQueen;
      case ActionTaken.other: return l10n.actionOther;
    }
  }

  String get emoji {
    switch (this) {
      case ActionTaken.addedFrames: return '➕';
      case ActionTaken.removedFrames: return '➖';
      case ActionTaken.fedSugarSyrup: return '🍯';
      case ActionTaken.fedPollen: return '🌼';
      case ActionTaken.treatedVarroa: return '💊';
      case ActionTaken.treatedDisease: return '💉';
      case ActionTaken.requeened: return '👑';
      case ActionTaken.splitHive: return '✂️';
      case ActionTaken.combinedHives: return '🤝';
      case ActionTaken.addedSuper: return '📦';
      case ActionTaken.removedSuper: return '📤';
      case ActionTaken.harvestedHoney: return '🍯';
      case ActionTaken.markedQueen: return '🏷️';
      case ActionTaken.clippedQueen: return '✂️';
      case ActionTaken.other: return '📝';
    }
  }
}

// === INSPECTION IMAGE TYPE ===
enum InspectionImageType {
  queen,
  brood,
  eggs,
  larvae,
  honey,
  pollen,
  disease,
  pest,
  general,
}

extension InspectionImageTypeExtension on InspectionImageType {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case InspectionImageType.queen: return l10n.imageTypeQueen;
      case InspectionImageType.brood: return l10n.imageTypeBrood;
      case InspectionImageType.eggs: return l10n.imageTypeEggs;
      case InspectionImageType.larvae: return l10n.imageTypeLarvae;
      case InspectionImageType.honey: return l10n.imageTypeHoney;
      case InspectionImageType.pollen: return l10n.imageTypePollen;
      case InspectionImageType.disease: return l10n.imageTypeDisease;
      case InspectionImageType.pest: return l10n.imageTypePest;
      case InspectionImageType.general: return l10n.imageTypeGeneral;
    }
  }

  String get emoji {
    switch (this) {
      case InspectionImageType.queen: return '👑';
      case InspectionImageType.brood: return '🐝';
      case InspectionImageType.eggs: return '🥚';
      case InspectionImageType.larvae: return '🐛';
      case InspectionImageType.honey: return '🍯';
      case InspectionImageType.pollen: return '🌼';
      case InspectionImageType.disease: return '🦠';
      case InspectionImageType.pest: return '🐜';
      case InspectionImageType.general: return '📷';
    }
  }
}

// === INSPECTION IMAGE MODEL ===
class InspectionImage {
  final String id;
  final String inspectionId;
  final String imageUrl;
  final String storagePath;
  final InspectionImageType type;
  final DateTime takenAt;
  final String? note;

  InspectionImage({
    required this.id,
    required this.inspectionId,
    required this.imageUrl,
    required this.storagePath,
    required this.type,
    required this.takenAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'inspectionId': inspectionId,
      'imageUrl': imageUrl,
      'storagePath': storagePath,
      'type': type.index,
      'takenAt': Timestamp.fromDate(takenAt),
      'note': note,
    };
  }

  factory InspectionImage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InspectionImage(
      id: doc.id,
      inspectionId: data['inspectionId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      storagePath: data['storagePath'] ?? '',
      type: InspectionImageType.values[data['type'] ?? 8],
      takenAt: (data['takenAt'] as Timestamp).toDate(),
      note: data['note'],
    );
  }

  InspectionImage copyWith({
    String? id,
    String? inspectionId,
    String? imageUrl,
    String? storagePath,
    InspectionImageType? type,
    DateTime? takenAt,
    String? note,
  }) {
    return InspectionImage(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      imageUrl: imageUrl ?? this.imageUrl,
      storagePath: storagePath ?? this.storagePath,
      type: type ?? this.type,
      takenAt: takenAt ?? this.takenAt,
      note: note ?? this.note,
    );
  }
}

// === INSPECTION MODEL ===
class Inspection {
  final String id;
  final String beehiveId;
  final String apiaryId;
  final String userId;

  final DateTime inspectionDate;
  final WeatherCondition? weather;
  final double? temperature;
  final String? inspectorName;

  final bool queenSeen;
  final bool queenCellsSeen;
  final bool eggsSeen;
  final bool larvaeSeen;
  final BroodPattern? broodPattern;

  final PopulationStrength? populationStrength;
  final int? framesOfBees;
  final int? framesOfBrood;

  final StoresLevel? honeyStores;
  final StoresLevel? pollenStores;
  final bool needsFeeding;

  final Temperament? temperament;
  final List<Disease> diseasesObserved;
  final List<Pest> pestsObserved;

  final List<ActionTaken> actionsTaken;
  final String? actionNotes;

  final List<InspectionImage> images;
  final String? notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  Inspection({
    required this.id,
    required this.beehiveId,
    required this.apiaryId,
    required this.userId,
    required this.inspectionDate,
    this.weather,
    this.temperature,
    this.inspectorName,
    this.queenSeen = false,
    this.queenCellsSeen = false,
    this.eggsSeen = false,
    this.larvaeSeen = false,
    this.broodPattern,
    this.populationStrength,
    this.framesOfBees,
    this.framesOfBrood,
    this.honeyStores,
    this.pollenStores,
    this.needsFeeding = false,
    this.temperament,
    this.diseasesObserved = const [],
    this.pestsObserved = const [],
    this.actionsTaken = const [],
    this.actionNotes,
    this.images = const [],
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Helper getters
  bool get hasHealthIssues => diseasesObserved.isNotEmpty || pestsObserved.isNotEmpty;
  bool get hasActions => actionsTaken.isNotEmpty;
  bool get hasImages => images.isNotEmpty;

  String get quickSummary {
    List<String> items = [];
    if (queenSeen) items.add('👑');
    if (eggsSeen) items.add('🥚');
    if (larvaeSeen) items.add('🐛');
    if (hasHealthIssues) items.add('⚠️');
    if (needsFeeding) items.add('🍯');
    return items.join(' ');
  }

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'beehiveId': beehiveId,
      'apiaryId': apiaryId,
      'userId': userId,
      'inspectionDate': Timestamp.fromDate(inspectionDate),
      'weather': weather?.index,
      'temperature': temperature,
      'inspectorName': inspectorName,
      'queenSeen': queenSeen,
      'queenCellsSeen': queenCellsSeen,
      'eggsSeen': eggsSeen,
      'larvaeSeen': larvaeSeen,
      'broodPattern': broodPattern?.index,
      'populationStrength': populationStrength?.index,
      'framesOfBees': framesOfBees,
      'framesOfBrood': framesOfBrood,
      'honeyStores': honeyStores?.index,
      'pollenStores': pollenStores?.index,
      'needsFeeding': needsFeeding,
      'temperament': temperament?.index,
      'diseasesObserved': diseasesObserved.map((d) => d.index).toList(),
      'pestsObserved': pestsObserved.map((p) => p.index).toList(),
      'actionsTaken': actionsTaken.map((a) => a.index).toList(),
      'actionNotes': actionNotes,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create from Firestore document
  factory Inspection.fromDocument(DocumentSnapshot doc, {List<InspectionImage>? images}) {
    final data = doc.data() as Map<String, dynamic>;
    return Inspection(
      id: doc.id,
      beehiveId: data['beehiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      userId: data['userId'] ?? '',
      inspectionDate: (data['inspectionDate'] as Timestamp).toDate(),
      weather: data['weather'] != null ? WeatherCondition.values[data['weather']] : null,
      temperature: data['temperature']?.toDouble(),
      inspectorName: data['inspectorName'],
      queenSeen: data['queenSeen'] ?? false,
      queenCellsSeen: data['queenCellsSeen'] ?? false,
      eggsSeen: data['eggsSeen'] ?? false,
      larvaeSeen: data['larvaeSeen'] ?? false,
      broodPattern: data['broodPattern'] != null
          ? BroodPattern.values[data['broodPattern']]
          : null,
      populationStrength: data['populationStrength'] != null
          ? PopulationStrength.values[data['populationStrength']]
          : null,
      framesOfBees: data['framesOfBees'],
      framesOfBrood: data['framesOfBrood'],
      honeyStores: data['honeyStores'] != null
          ? StoresLevel.values[data['honeyStores']]
          : null,
      pollenStores: data['pollenStores'] != null
          ? StoresLevel.values[data['pollenStores']]
          : null,
      needsFeeding: data['needsFeeding'] ?? false,
      temperament: data['temperament'] != null
          ? Temperament.values[data['temperament']]
          : null,
      diseasesObserved: (data['diseasesObserved'] as List<dynamic>?)
              ?.map((e) => Disease.values[e as int])
              .toList() ??
          [],
      pestsObserved: (data['pestsObserved'] as List<dynamic>?)
              ?.map((e) => Pest.values[e as int])
              .toList() ??
          [],
      actionsTaken: (data['actionsTaken'] as List<dynamic>?)
              ?.map((e) => ActionTaken.values[e as int])
              .toList() ??
          [],
      actionNotes: data['actionNotes'],
      images: images ?? [],
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Copy with
  Inspection copyWith({
    String? id,
    String? beehiveId,
    String? apiaryId,
    String? userId,
    DateTime? inspectionDate,
    WeatherCondition? weather,
    double? temperature,
    String? inspectorName,
    bool? queenSeen,
    bool? queenCellsSeen,
    bool? eggsSeen,
    bool? larvaeSeen,
    BroodPattern? broodPattern,
    PopulationStrength? populationStrength,
    int? framesOfBees,
    int? framesOfBrood,
    StoresLevel? honeyStores,
    StoresLevel? pollenStores,
    bool? needsFeeding,
    Temperament? temperament,
    List<Disease>? diseasesObserved,
    List<Pest>? pestsObserved,
    List<ActionTaken>? actionsTaken,
    String? actionNotes,
    List<InspectionImage>? images,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Inspection(
      id: id ?? this.id,
      beehiveId: beehiveId ?? this.beehiveId,
      apiaryId: apiaryId ?? this.apiaryId,
      userId: userId ?? this.userId,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      weather: weather ?? this.weather,
      temperature: temperature ?? this.temperature,
      inspectorName: inspectorName ?? this.inspectorName,
      queenSeen: queenSeen ?? this.queenSeen,
      queenCellsSeen: queenCellsSeen ?? this.queenCellsSeen,
      eggsSeen: eggsSeen ?? this.eggsSeen,
      larvaeSeen: larvaeSeen ?? this.larvaeSeen,
      broodPattern: broodPattern ?? this.broodPattern,
      populationStrength: populationStrength ?? this.populationStrength,
      framesOfBees: framesOfBees ?? this.framesOfBees,
      framesOfBrood: framesOfBrood ?? this.framesOfBrood,
      honeyStores: honeyStores ?? this.honeyStores,
      pollenStores: pollenStores ?? this.pollenStores,
      needsFeeding: needsFeeding ?? this.needsFeeding,
      temperament: temperament ?? this.temperament,
      diseasesObserved: diseasesObserved ?? this.diseasesObserved,
      pestsObserved: pestsObserved ?? this.pestsObserved,
      actionsTaken: actionsTaken ?? this.actionsTaken,
      actionNotes: actionNotes ?? this.actionNotes,
      images: images ?? this.images,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'Inspection(id: $id, beehiveId: $beehiveId, date: $inspectionDate)';

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Inspection && other.id == id);

  @override
  int get hashCode => id.hashCode;
}