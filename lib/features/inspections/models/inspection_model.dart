// lib/features/inspections/models/inspection_model.dart

enum WeatherCondition { sunny, partlyCloudy, cloudy, rainy, windy, hot, cold }

extension WeatherConditionExtension on WeatherCondition {
  String get label {
    switch (this) {
      case WeatherCondition.sunny: return 'Sunny';
      case WeatherCondition.partlyCloudy: return 'Partly Cloudy';
      case WeatherCondition.cloudy: return 'Cloudy';
      case WeatherCondition.rainy: return 'Rainy';
      case WeatherCondition.windy: return 'Windy';
      case WeatherCondition.hot: return 'Hot';
      case WeatherCondition.cold: return 'Cold';
    }
  }

  String get labelAr {
    switch (this) {
      case WeatherCondition.sunny: return 'مشمس';
      case WeatherCondition.partlyCloudy: return 'غائم جزئياً';
      case WeatherCondition.cloudy: return 'غائم';
      case WeatherCondition.rainy: return 'ماطر';
      case WeatherCondition.windy: return 'عاصف';
      case WeatherCondition.hot: return 'حار';
      case WeatherCondition.cold: return 'بارد';
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

enum BroodPattern { excellent, good, spotty, poor, none }

extension BroodPatternExtension on BroodPattern {
  String get label {
    switch (this) {
      case BroodPattern.excellent: return 'Excellent';
      case BroodPattern.good: return 'Good';
      case BroodPattern.spotty: return 'Spotty';
      case BroodPattern.poor: return 'Poor';
      case BroodPattern.none: return 'None';
    }
  }

  String get labelAr {
    switch (this) {
      case BroodPattern.excellent: return 'ممتاز';
      case BroodPattern.good: return 'جيد';
      case BroodPattern.spotty: return 'متقطع';
      case BroodPattern.poor: return 'ضعيف';
      case BroodPattern.none: return 'لا يوجد';
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

enum PopulationStrength { strong, medium, weak, veryWeak }

extension PopulationStrengthExtension on PopulationStrength {
  String get label {
    switch (this) {
      case PopulationStrength.strong: return 'Strong';
      case PopulationStrength.medium: return 'Medium';
      case PopulationStrength.weak: return 'Weak';
      case PopulationStrength.veryWeak: return 'Very Weak';
    }
  }

  String get labelAr {
    switch (this) {
      case PopulationStrength.strong: return 'قوي';
      case PopulationStrength.medium: return 'متوسط';
      case PopulationStrength.weak: return 'ضعيف';
      case PopulationStrength.veryWeak: return 'ضعيف جداً';
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

enum StoresLevel { low, adequate, high }

extension StoresLevelExtension on StoresLevel {
  String get label {
    switch (this) {
      case StoresLevel.low: return 'Low';
      case StoresLevel.adequate: return 'Adequate';
      case StoresLevel.high: return 'High';
    }
  }

  String get labelAr {
    switch (this) {
      case StoresLevel.low: return 'منخفض';
      case StoresLevel.adequate: return 'كافٍ';
      case StoresLevel.high: return 'مرتفع';
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

enum Temperament { calm, nervous, aggressive }

extension TemperamentExtension on Temperament {
  String get label {
    switch (this) {
      case Temperament.calm: return 'Calm';
      case Temperament.nervous: return 'Nervous';
      case Temperament.aggressive: return 'Aggressive';
    }
  }

  String get labelAr {
    switch (this) {
      case Temperament.calm: return 'هادئ';
      case Temperament.nervous: return 'عصبي';
      case Temperament.aggressive: return 'عدواني';
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
  String get label {
    switch (this) {
      case Disease.varroa: return 'Varroa Mites';
      case Disease.americanFoulbrood: return 'American Foulbrood';
      case Disease.europeanFoulbrood: return 'European Foulbrood';
      case Disease.nosema: return 'Nosema';
      case Disease.chalkbrood: return 'Chalkbrood';
      case Disease.sacbrood: return 'Sacbrood';
      case Disease.other: return 'Other';
    }
  }

  String get labelAr {
    switch (this) {
      case Disease.varroa: return 'حلم الفاروا';
      case Disease.americanFoulbrood: return 'تعفن الحضنة الأمريكي';
      case Disease.europeanFoulbrood: return 'تعفن الحضنة الأوروبي';
      case Disease.nosema: return 'النوزيما';
      case Disease.chalkbrood: return 'الحضنة الطباشيرية';
      case Disease.sacbrood: return 'الحضنة الكيسية';
      case Disease.other: return 'أخرى';
    }
  }
}

enum Pest {
  smallHiveBeetle,
  waxMoth,
  ants,
  wasps,
  mice,
  other,
}

extension PestExtension on Pest {
  String get label {
    switch (this) {
      case Pest.smallHiveBeetle: return 'Small Hive Beetle';
      case Pest.waxMoth: return 'Wax Moth';
      case Pest.ants: return 'Ants';
      case Pest.wasps: return 'Wasps';
      case Pest.mice: return 'Mice';
      case Pest.other: return 'Other';
    }
  }

  String get labelAr {
    switch (this) {
      case Pest.smallHiveBeetle: return 'خنفساء الخلية الصغيرة';
      case Pest.waxMoth: return 'عثة الشمع';
      case Pest.ants: return 'نمل';
      case Pest.wasps: return 'دبابير';
      case Pest.mice: return 'فئران';
      case Pest.other: return 'أخرى';
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
  String get label {
    switch (this) {
      case ActionTaken.addedFrames: return 'Added Frames';
      case ActionTaken.removedFrames: return 'Removed Frames';
      case ActionTaken.fedSugarSyrup: return 'Fed Sugar Syrup';
      case ActionTaken.fedPollen: return 'Fed Pollen';
      case ActionTaken.treatedVarroa: return 'Treated for Varroa';
      case ActionTaken.treatedDisease: return 'Treated for Disease';
      case ActionTaken.requeened: return 'Requeened';
      case ActionTaken.splitHive: return 'Split Hive';
      case ActionTaken.combinedHives: return 'Combined Hives';
      case ActionTaken.addedSuper: return 'Added Super';
      case ActionTaken.removedSuper: return 'Removed Super';
      case ActionTaken.harvestedHoney: return 'Harvested Honey';
      case ActionTaken.markedQueen: return 'Marked Queen';
      case ActionTaken.clippedQueen: return 'Clipped Queen';
      case ActionTaken.other: return 'Other';
    }
  }

  String get labelAr {
    switch (this) {
      case ActionTaken.addedFrames: return 'إضافة إطارات';
      case ActionTaken.removedFrames: return 'إزالة إطارات';
      case ActionTaken.fedSugarSyrup: return 'تغذية بالشراب';
      case ActionTaken.fedPollen: return 'تغذية بحبوب اللقاح';
      case ActionTaken.treatedVarroa: return 'علاج الفاروا';
      case ActionTaken.treatedDisease: return 'علاج مرض';
      case ActionTaken.requeened: return 'تبديل الملكة';
      case ActionTaken.splitHive: return 'تقسيم الخلية';
      case ActionTaken.combinedHives: return 'دمج الخلايا';
      case ActionTaken.addedSuper: return 'إضافة عاسلة';
      case ActionTaken.removedSuper: return 'إزالة عاسلة';
      case ActionTaken.harvestedHoney: return 'قطف العسل';
      case ActionTaken.markedQueen: return 'وسم الملكة';
      case ActionTaken.clippedQueen: return 'قص جناح الملكة';
      case ActionTaken.other: return 'أخرى';
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
  String get label {
    switch (this) {
      case InspectionImageType.queen: return 'Queen';
      case InspectionImageType.brood: return 'Brood';
      case InspectionImageType.eggs: return 'Eggs';
      case InspectionImageType.larvae: return 'Larvae';
      case InspectionImageType.honey: return 'Honey';
      case InspectionImageType.pollen: return 'Pollen';
      case InspectionImageType.disease: return 'Disease';
      case InspectionImageType.pest: return 'Pest';
      case InspectionImageType.general: return 'General';
    }
  }

  String get labelAr {
    switch (this) {
      case InspectionImageType.queen: return 'الملكة';
      case InspectionImageType.brood: return 'الحضنة';
      case InspectionImageType.eggs: return 'البيض';
      case InspectionImageType.larvae: return 'اليرقات';
      case InspectionImageType.honey: return 'العسل';
      case InspectionImageType.pollen: return 'حبوب اللقاح';
      case InspectionImageType.disease: return 'مرض';
      case InspectionImageType.pest: return 'آفة';
      case InspectionImageType.general: return 'عام';
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

class InspectionImage {
  final String id;
  final String inspectionId;
  final String imagePath;
  final InspectionImageType type;
  final DateTime takenAt;
  final String? note;

  InspectionImage({
    required this.id,
    required this.inspectionId,
    required this.imagePath,
    required this.type,
    required this.takenAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inspectionId': inspectionId,
      'imagePath': imagePath,
      'type': type.index,
      'takenAt': takenAt.toIso8601String(),
      'note': note,
    };
  }

  factory InspectionImage.fromMap(Map<String, dynamic> map) {
    return InspectionImage(
      id: map['id'],
      inspectionId: map['inspectionId'],
      imagePath: map['imagePath'],
      type: InspectionImageType.values[map['type']],
      takenAt: DateTime.parse(map['takenAt']),
      note: map['note'],
    );
  }
}

class Inspection {
  final String id;
  final String beehiveId;
  
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'beehiveId': beehiveId,
      'inspectionDate': inspectionDate.toIso8601String(),
      'weather': weather?.index,
      'temperature': temperature,
      'inspectorName': inspectorName,
      'queenSeen': queenSeen ? 1 : 0,
      'queenCellsSeen': queenCellsSeen ? 1 : 0,
      'eggsSeen': eggsSeen ? 1 : 0,
      'larvaeSeen': larvaeSeen ? 1 : 0,
      'broodPattern': broodPattern?.index,
      'populationStrength': populationStrength?.index,
      'framesOfBees': framesOfBees,
      'framesOfBrood': framesOfBrood,
      'honeyStores': honeyStores?.index,
      'pollenStores': pollenStores?.index,
      'needsFeeding': needsFeeding ? 1 : 0,
      'temperament': temperament?.index,
      'diseasesObserved': diseasesObserved.map((d) => d.index).toList().join(','),
      'pestsObserved': pestsObserved.map((p) => p.index).toList().join(','),
      'actionsTaken': actionsTaken.map((a) => a.index).toList().join(','),
      'actionNotes': actionNotes,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Inspection.fromMap(Map<String, dynamic> map, {List<InspectionImage>? images}) {
    return Inspection(
      id: map['id'],
      beehiveId: map['beehiveId'],
      inspectionDate: DateTime.parse(map['inspectionDate']),
      weather: map['weather'] != null ? WeatherCondition.values[map['weather']] : null,
      temperature: map['temperature']?.toDouble(),
      inspectorName: map['inspectorName'],
      queenSeen: map['queenSeen'] == 1,
      queenCellsSeen: map['queenCellsSeen'] == 1,
      eggsSeen: map['eggsSeen'] == 1,
      larvaeSeen: map['larvaeSeen'] == 1,
      broodPattern: map['broodPattern'] != null 
          ? BroodPattern.values[map['broodPattern']] 
          : null,
      populationStrength: map['populationStrength'] != null 
          ? PopulationStrength.values[map['populationStrength']] 
          : null,
      framesOfBees: map['framesOfBees'],
      framesOfBrood: map['framesOfBrood'],
      honeyStores: map['honeyStores'] != null 
          ? StoresLevel.values[map['honeyStores']] 
          : null,
      pollenStores: map['pollenStores'] != null 
          ? StoresLevel.values[map['pollenStores']] 
          : null,
      needsFeeding: map['needsFeeding'] == 1,
      temperament: map['temperament'] != null 
          ? Temperament.values[map['temperament']] 
          : null,
      diseasesObserved: map['diseasesObserved'] != null && map['diseasesObserved'].toString().isNotEmpty
          ? map['diseasesObserved'].toString()
              .split(',')
              .map((e) => Disease.values[int.parse(e)])
              .toList()
          : [],
      pestsObserved: map['pestsObserved'] != null && map['pestsObserved'].toString().isNotEmpty
          ? map['pestsObserved'].toString()
              .split(',')
              .map((e) => Pest.values[int.parse(e)])
              .toList()
          : [],
      actionsTaken: map['actionsTaken'] != null && map['actionsTaken'].toString().isNotEmpty
          ? map['actionsTaken'].toString()
              .split(',')
              .map((e) => ActionTaken.values[int.parse(e)])
              .toList()
          : [],
      actionNotes: map['actionNotes'],
      images: images ?? [],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Inspection copyWith({
    String? id,
    String? beehiveId,
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
}