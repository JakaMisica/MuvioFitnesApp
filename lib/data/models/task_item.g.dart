// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskItemCollection on Isar {
  IsarCollection<TaskItem> get taskItems => this.collection();
}

const TaskItemSchema = CollectionSchema(
  name: r'TaskItem',
  id: 2171180427076855156,
  properties: {
    r'alarmSoundPath': PropertySchema(
      id: 0,
      name: r'alarmSoundPath',
      type: IsarType.string,
    ),
    r'alarmTime': PropertySchema(
      id: 1,
      name: r'alarmTime',
      type: IsarType.string,
    ),
    r'breakTargetSeconds': PropertySchema(
      id: 2,
      name: r'breakTargetSeconds',
      type: IsarType.long,
    ),
    r'chimeEndHour': PropertySchema(
      id: 3,
      name: r'chimeEndHour',
      type: IsarType.long,
    ),
    r'chimeIntervalMinutes': PropertySchema(
      id: 4,
      name: r'chimeIntervalMinutes',
      type: IsarType.long,
    ),
    r'chimeStartHour': PropertySchema(
      id: 5,
      name: r'chimeStartHour',
      type: IsarType.long,
    ),
    r'counterMax': PropertySchema(
      id: 6,
      name: r'counterMax',
      type: IsarType.long,
    ),
    r'counterValue': PropertySchema(
      id: 7,
      name: r'counterValue',
      type: IsarType.long,
    ),
    r'currency': PropertySchema(
      id: 8,
      name: r'currency',
      type: IsarType.string,
    ),
    r'currentSeconds': PropertySchema(
      id: 9,
      name: r'currentSeconds',
      type: IsarType.long,
    ),
    r'distanceValue': PropertySchema(
      id: 10,
      name: r'distanceValue',
      type: IsarType.double,
    ),
    r'doseValue': PropertySchema(
      id: 11,
      name: r'doseValue',
      type: IsarType.string,
    ),
    r'energyValue': PropertySchema(
      id: 12,
      name: r'energyValue',
      type: IsarType.double,
    ),
    r'financialValue': PropertySchema(
      id: 13,
      name: r'financialValue',
      type: IsarType.double,
    ),
    r'group': PropertySchema(id: 14, name: r'group', type: IsarType.string),
    r'hasCounterMetric': PropertySchema(
      id: 15,
      name: r'hasCounterMetric',
      type: IsarType.bool,
    ),
    r'hasDistanceMetric': PropertySchema(
      id: 16,
      name: r'hasDistanceMetric',
      type: IsarType.bool,
    ),
    r'hasDoseMetric': PropertySchema(
      id: 17,
      name: r'hasDoseMetric',
      type: IsarType.bool,
    ),
    r'hasEnergyMetric': PropertySchema(
      id: 18,
      name: r'hasEnergyMetric',
      type: IsarType.bool,
    ),
    r'hasFinancialMetric': PropertySchema(
      id: 19,
      name: r'hasFinancialMetric',
      type: IsarType.bool,
    ),
    r'hasPercentageMetric': PropertySchema(
      id: 20,
      name: r'hasPercentageMetric',
      type: IsarType.bool,
    ),
    r'hasRatingMetric': PropertySchema(
      id: 21,
      name: r'hasRatingMetric',
      type: IsarType.bool,
    ),
    r'hasTimeMetric': PropertySchema(
      id: 22,
      name: r'hasTimeMetric',
      type: IsarType.bool,
    ),
    r'hasWeightMetric': PropertySchema(
      id: 23,
      name: r'hasWeightMetric',
      type: IsarType.bool,
    ),
    r'imagePaths': PropertySchema(
      id: 24,
      name: r'imagePaths',
      type: IsarType.stringList,
    ),
    r'isDoubleTimer': PropertySchema(
      id: 25,
      name: r'isDoubleTimer',
      type: IsarType.bool,
    ),
    r'isHourlyChimeEnabled': PropertySchema(
      id: 26,
      name: r'isHourlyChimeEnabled',
      type: IsarType.bool,
    ),
    r'isNote': PropertySchema(id: 27, name: r'isNote', type: IsarType.bool),
    r'isTimerRunning': PropertySchema(
      id: 28,
      name: r'isTimerRunning',
      type: IsarType.bool,
    ),
    r'isWorkPeriod': PropertySchema(
      id: 29,
      name: r'isWorkPeriod',
      type: IsarType.bool,
    ),
    r'lastChimeTime': PropertySchema(
      id: 30,
      name: r'lastChimeTime',
      type: IsarType.dateTime,
    ),
    r'lastCompleted': PropertySchema(
      id: 31,
      name: r'lastCompleted',
      type: IsarType.dateTime,
    ),
    r'lastEditedDate': PropertySchema(
      id: 32,
      name: r'lastEditedDate',
      type: IsarType.dateTime,
    ),
    r'lastReset': PropertySchema(
      id: 33,
      name: r'lastReset',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(id: 34, name: r'name', type: IsarType.string),
    r'notes': PropertySchema(id: 35, name: r'notes', type: IsarType.string),
    r'orderIndex': PropertySchema(
      id: 36,
      name: r'orderIndex',
      type: IsarType.long,
    ),
    r'percentageValue': PropertySchema(
      id: 37,
      name: r'percentageValue',
      type: IsarType.double,
    ),
    r'ratingValue': PropertySchema(
      id: 38,
      name: r'ratingValue',
      type: IsarType.long,
    ),
    r'recurrenceType': PropertySchema(
      id: 39,
      name: r'recurrenceType',
      type: IsarType.long,
    ),
    r'sentiment': PropertySchema(
      id: 40,
      name: r'sentiment',
      type: IsarType.double,
    ),
    r'specificDays': PropertySchema(
      id: 41,
      name: r'specificDays',
      type: IsarType.string,
    ),
    r'targetSeconds': PropertySchema(
      id: 42,
      name: r'targetSeconds',
      type: IsarType.long,
    ),
    r'timerType': PropertySchema(
      id: 43,
      name: r'timerType',
      type: IsarType.long,
    ),
    r'weightValue': PropertySchema(
      id: 44,
      name: r'weightValue',
      type: IsarType.double,
    ),
  },
  estimateSize: _taskItemEstimateSize,
  serialize: _taskItemSerialize,
  deserialize: _taskItemDeserialize,
  deserializeProp: _taskItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'isNote': IndexSchema(
      id: -6363497911419511312,
      name: r'isNote',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isNote',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'sentiment': IndexSchema(
      id: -7197530238874584912,
      name: r'sentiment',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sentiment',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'orderIndex': IndexSchema(
      id: -6149432298716175352,
      name: r'orderIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderIndex',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _taskItemGetId,
  getLinks: _taskItemGetLinks,
  attach: _taskItemAttach,
  version: '3.1.0+1',
);

int _taskItemEstimateSize(
  TaskItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.alarmSoundPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.alarmTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.doseValue.length * 3;
  {
    final value = object.group;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.imagePaths.length * 3;
  {
    for (var i = 0; i < object.imagePaths.length; i++) {
      final value = object.imagePaths[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.specificDays.length * 3;
  return bytesCount;
}

void _taskItemSerialize(
  TaskItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alarmSoundPath);
  writer.writeString(offsets[1], object.alarmTime);
  writer.writeLong(offsets[2], object.breakTargetSeconds);
  writer.writeLong(offsets[3], object.chimeEndHour);
  writer.writeLong(offsets[4], object.chimeIntervalMinutes);
  writer.writeLong(offsets[5], object.chimeStartHour);
  writer.writeLong(offsets[6], object.counterMax);
  writer.writeLong(offsets[7], object.counterValue);
  writer.writeString(offsets[8], object.currency);
  writer.writeLong(offsets[9], object.currentSeconds);
  writer.writeDouble(offsets[10], object.distanceValue);
  writer.writeString(offsets[11], object.doseValue);
  writer.writeDouble(offsets[12], object.energyValue);
  writer.writeDouble(offsets[13], object.financialValue);
  writer.writeString(offsets[14], object.group);
  writer.writeBool(offsets[15], object.hasCounterMetric);
  writer.writeBool(offsets[16], object.hasDistanceMetric);
  writer.writeBool(offsets[17], object.hasDoseMetric);
  writer.writeBool(offsets[18], object.hasEnergyMetric);
  writer.writeBool(offsets[19], object.hasFinancialMetric);
  writer.writeBool(offsets[20], object.hasPercentageMetric);
  writer.writeBool(offsets[21], object.hasRatingMetric);
  writer.writeBool(offsets[22], object.hasTimeMetric);
  writer.writeBool(offsets[23], object.hasWeightMetric);
  writer.writeStringList(offsets[24], object.imagePaths);
  writer.writeBool(offsets[25], object.isDoubleTimer);
  writer.writeBool(offsets[26], object.isHourlyChimeEnabled);
  writer.writeBool(offsets[27], object.isNote);
  writer.writeBool(offsets[28], object.isTimerRunning);
  writer.writeBool(offsets[29], object.isWorkPeriod);
  writer.writeDateTime(offsets[30], object.lastChimeTime);
  writer.writeDateTime(offsets[31], object.lastCompleted);
  writer.writeDateTime(offsets[32], object.lastEditedDate);
  writer.writeDateTime(offsets[33], object.lastReset);
  writer.writeString(offsets[34], object.name);
  writer.writeString(offsets[35], object.notes);
  writer.writeLong(offsets[36], object.orderIndex);
  writer.writeDouble(offsets[37], object.percentageValue);
  writer.writeLong(offsets[38], object.ratingValue);
  writer.writeLong(offsets[39], object.recurrenceType);
  writer.writeDouble(offsets[40], object.sentiment);
  writer.writeString(offsets[41], object.specificDays);
  writer.writeLong(offsets[42], object.targetSeconds);
  writer.writeLong(offsets[43], object.timerType);
  writer.writeDouble(offsets[44], object.weightValue);
}

TaskItem _taskItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskItem(
    alarmSoundPath: reader.readStringOrNull(offsets[0]),
    alarmTime: reader.readStringOrNull(offsets[1]),
    breakTargetSeconds: reader.readLongOrNull(offsets[2]) ?? 300,
    chimeEndHour: reader.readLongOrNull(offsets[3]) ?? 22,
    chimeIntervalMinutes: reader.readLongOrNull(offsets[4]) ?? 60,
    chimeStartHour: reader.readLongOrNull(offsets[5]) ?? 8,
    counterMax: reader.readLongOrNull(offsets[6]) ?? 0,
    counterValue: reader.readLongOrNull(offsets[7]) ?? 0,
    currency: reader.readStringOrNull(offsets[8]) ?? 'USD',
    currentSeconds: reader.readLongOrNull(offsets[9]) ?? 0,
    distanceValue: reader.readDoubleOrNull(offsets[10]) ?? 0.0,
    doseValue: reader.readStringOrNull(offsets[11]) ?? '',
    energyValue: reader.readDoubleOrNull(offsets[12]) ?? 0.0,
    financialValue: reader.readDoubleOrNull(offsets[13]) ?? 0.0,
    group: reader.readStringOrNull(offsets[14]),
    hasCounterMetric: reader.readBoolOrNull(offsets[15]) ?? false,
    hasDistanceMetric: reader.readBoolOrNull(offsets[16]) ?? false,
    hasDoseMetric: reader.readBoolOrNull(offsets[17]) ?? false,
    hasEnergyMetric: reader.readBoolOrNull(offsets[18]) ?? false,
    hasFinancialMetric: reader.readBoolOrNull(offsets[19]) ?? false,
    hasPercentageMetric: reader.readBoolOrNull(offsets[20]) ?? false,
    hasRatingMetric: reader.readBoolOrNull(offsets[21]) ?? false,
    hasTimeMetric: reader.readBoolOrNull(offsets[22]) ?? false,
    hasWeightMetric: reader.readBoolOrNull(offsets[23]) ?? false,
    imagePaths: reader.readStringList(offsets[24]) ?? const [],
    isDoubleTimer: reader.readBoolOrNull(offsets[25]) ?? false,
    isHourlyChimeEnabled: reader.readBoolOrNull(offsets[26]) ?? false,
    isNote: reader.readBoolOrNull(offsets[27]) ?? false,
    isTimerRunning: reader.readBoolOrNull(offsets[28]) ?? false,
    isWorkPeriod: reader.readBoolOrNull(offsets[29]) ?? true,
    lastChimeTime: reader.readDateTimeOrNull(offsets[30]),
    lastCompleted: reader.readDateTimeOrNull(offsets[31]),
    lastEditedDate: reader.readDateTimeOrNull(offsets[32]),
    lastReset: reader.readDateTimeOrNull(offsets[33]),
    name: reader.readStringOrNull(offsets[34]) ?? '',
    notes: reader.readStringOrNull(offsets[35]) ?? '',
    orderIndex: reader.readLongOrNull(offsets[36]) ?? 0,
    percentageValue: reader.readDoubleOrNull(offsets[37]) ?? 0.0,
    ratingValue: reader.readLongOrNull(offsets[38]) ?? 5,
    recurrenceType: reader.readLongOrNull(offsets[39]) ?? 0,
    sentiment: reader.readDoubleOrNull(offsets[40]) ?? 0.0,
    specificDays: reader.readStringOrNull(offsets[41]) ?? '',
    targetSeconds: reader.readLongOrNull(offsets[42]) ?? 0,
    timerType: reader.readLongOrNull(offsets[43]) ?? 0,
    weightValue: reader.readDoubleOrNull(offsets[44]) ?? 0.0,
  );
  object.id = id;
  return object;
}

P _taskItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 300) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 22) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 60) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 8) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? 'USD') as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 10:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 13:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 16:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 17:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 18:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 19:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 20:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 21:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 22:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 23:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 24:
      return (reader.readStringList(offset) ?? const []) as P;
    case 25:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 26:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 27:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 28:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 29:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 30:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 31:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 32:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 33:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 35:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 36:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 37:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 38:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 39:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 40:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 41:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 42:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 43:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 44:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskItemGetId(TaskItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskItemGetLinks(TaskItem object) {
  return [];
}

void _taskItemAttach(IsarCollection<dynamic> col, Id id, TaskItem object) {
  object.id = id;
}

extension TaskItemQueryWhereSort on QueryBuilder<TaskItem, TaskItem, QWhere> {
  QueryBuilder<TaskItem, TaskItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhere> anyIsNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isNote'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhere> anySentiment() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sentiment'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhere> anyOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'orderIndex'),
      );
    });
  }
}

extension TaskItemQueryWhere on QueryBuilder<TaskItem, TaskItem, QWhereClause> {
  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> isNoteEqualTo(
    bool isNote,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'isNote', value: [isNote]),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> isNoteNotEqualTo(
    bool isNote,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isNote',
                lower: [],
                upper: [isNote],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isNote',
                lower: [isNote],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isNote',
                lower: [isNote],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isNote',
                lower: [],
                upper: [isNote],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> sentimentEqualTo(
    double sentiment,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'sentiment', value: [sentiment]),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> sentimentNotEqualTo(
    double sentiment,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sentiment',
                lower: [],
                upper: [sentiment],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sentiment',
                lower: [sentiment],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sentiment',
                lower: [sentiment],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sentiment',
                lower: [],
                upper: [sentiment],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> sentimentGreaterThan(
    double sentiment, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sentiment',
          lower: [sentiment],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> sentimentLessThan(
    double sentiment, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sentiment',
          lower: [],
          upper: [sentiment],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> sentimentBetween(
    double lowerSentiment,
    double upperSentiment, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sentiment',
          lower: [lowerSentiment],
          includeLower: includeLower,
          upper: [upperSentiment],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> orderIndexEqualTo(
    int orderIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'orderIndex', value: [orderIndex]),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> orderIndexNotEqualTo(
    int orderIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'orderIndex',
                lower: [],
                upper: [orderIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'orderIndex',
                lower: [orderIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'orderIndex',
                lower: [orderIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'orderIndex',
                lower: [],
                upper: [orderIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> orderIndexGreaterThan(
    int orderIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'orderIndex',
          lower: [orderIndex],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> orderIndexLessThan(
    int orderIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'orderIndex',
          lower: [],
          upper: [orderIndex],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterWhereClause> orderIndexBetween(
    int lowerOrderIndex,
    int upperOrderIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'orderIndex',
          lower: [lowerOrderIndex],
          includeLower: includeLower,
          upper: [upperOrderIndex],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension TaskItemQueryFilter
    on QueryBuilder<TaskItem, TaskItem, QFilterCondition> {
  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'alarmSoundPath'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'alarmSoundPath'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmSoundPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmSoundPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alarmSoundPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'alarmSoundPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmSoundPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'alarmSoundPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alarmSoundPath', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmSoundPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'alarmSoundPath', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'alarmTime'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'alarmTime'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alarmTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'alarmTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'alarmTime',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> alarmTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alarmTime', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  alarmTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'alarmTime', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  breakTargetSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'breakTargetSeconds', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  breakTargetSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'breakTargetSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  breakTargetSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'breakTargetSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  breakTargetSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'breakTargetSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> chimeEndHourEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'chimeEndHour', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeEndHourGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chimeEndHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> chimeEndHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chimeEndHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> chimeEndHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chimeEndHour',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeIntervalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'chimeIntervalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeIntervalMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chimeIntervalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeIntervalMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chimeIntervalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeIntervalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chimeIntervalMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> chimeStartHourEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'chimeStartHour', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeStartHourGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chimeStartHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  chimeStartHourLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chimeStartHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> chimeStartHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chimeStartHour',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterMaxEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'counterMax', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterMaxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'counterMax',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterMaxLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'counterMax',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterMaxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'counterMax',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterValueEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'counterValue', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  counterValueGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'counterValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'counterValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> counterValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'counterValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currentSecondsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentSeconds', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  currentSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  currentSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> currentSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> distanceValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distanceValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  distanceValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distanceValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> distanceValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distanceValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> distanceValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distanceValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doseValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'doseValue',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'doseValue',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> doseValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'doseValue', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  doseValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'doseValue', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> energyValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'energyValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  energyValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'energyValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> energyValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'energyValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> energyValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'energyValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> financialValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'financialValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  financialValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'financialValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  financialValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'financialValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> financialValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'financialValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'group'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'group'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'group',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'group',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'group',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'group', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> groupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'group', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasCounterMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasCounterMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasDistanceMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasDistanceMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> hasDoseMetricEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasDoseMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasEnergyMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasEnergyMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasFinancialMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasFinancialMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasPercentageMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasPercentageMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasRatingMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasRatingMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> hasTimeMetricEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasTimeMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  hasWeightMetricEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasWeightMetric', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePaths',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePaths',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePaths', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePaths', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'imagePaths', length, true, length, true);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> imagePathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'imagePaths', 0, true, 0, true);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'imagePaths', 0, false, 999999, true);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'imagePaths', 0, true, length, include);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'imagePaths', length, include, 999999, true);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  imagePathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imagePaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> isDoubleTimerEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDoubleTimer', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  isHourlyChimeEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'isHourlyChimeEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> isNoteEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isNote', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> isTimerRunningEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTimerRunning', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> isWorkPeriodEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isWorkPeriod', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastChimeTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastChimeTime'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastChimeTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastChimeTime'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastChimeTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastChimeTime', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastChimeTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastChimeTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastChimeTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastChimeTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastChimeTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastChimeTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastCompleted'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastCompleted'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastCompletedEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastCompleted', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastCompletedGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastCompleted',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastCompletedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastCompleted',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastCompletedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastCompleted',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastEditedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastEditedDate'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastEditedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastEditedDate'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastEditedDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastEditedDate', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastEditedDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastEditedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  lastEditedDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastEditedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastEditedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastEditedDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastReset'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastReset'),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastReset', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastReset',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastReset',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> lastResetBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastReset',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> orderIndexEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orderIndex', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> orderIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'orderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> orderIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'orderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> orderIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'orderIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  percentageValueEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'percentageValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  percentageValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'percentageValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  percentageValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'percentageValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  percentageValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'percentageValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> ratingValueEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ratingValue', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  ratingValueGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ratingValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> ratingValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ratingValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> ratingValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ratingValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> recurrenceTypeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recurrenceType', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  recurrenceTypeGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recurrenceType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  recurrenceTypeLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recurrenceType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> recurrenceTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recurrenceType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> sentimentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sentiment',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> sentimentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sentiment',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> sentimentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sentiment',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> sentimentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sentiment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  specificDaysGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'specificDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  specificDaysStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'specificDays',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> specificDaysMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'specificDays',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  specificDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'specificDays', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  specificDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'specificDays', value: ''),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> targetSecondsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'targetSeconds', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  targetSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'targetSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> targetSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'targetSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> targetSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'targetSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> timerTypeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timerType', value: value),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> timerTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timerType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> timerTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timerType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> timerTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timerType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> weightValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition>
  weightValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> weightValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightValue',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterFilterCondition> weightValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }
}

extension TaskItemQueryObject
    on QueryBuilder<TaskItem, TaskItem, QFilterCondition> {}

extension TaskItemQueryLinks
    on QueryBuilder<TaskItem, TaskItem, QFilterCondition> {}

extension TaskItemQuerySortBy on QueryBuilder<TaskItem, TaskItem, QSortBy> {
  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByAlarmSoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByAlarmSoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByAlarmTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByAlarmTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByBreakTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakTargetSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  sortByBreakTargetSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakTargetSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByChimeEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeEndHour', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByChimeEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeEndHour', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByChimeIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeIntervalMinutes', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  sortByChimeIntervalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeIntervalMinutes', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByChimeStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeStartHour', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByChimeStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeStartHour', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCounterMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterMax', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCounterMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterMax', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCounterValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCounterValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCurrentSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByCurrentSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByDistanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByDistanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByDoseValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByDoseValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByEnergyValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByEnergyValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByFinancialValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financialValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByFinancialValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financialValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'group', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'group', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasCounterMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCounterMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasCounterMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCounterMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasDistanceMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDistanceMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasDistanceMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDistanceMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasDoseMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDoseMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasDoseMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDoseMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasEnergyMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasEnergyMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasEnergyMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasEnergyMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasFinancialMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinancialMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  sortByHasFinancialMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinancialMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasPercentageMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPercentageMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  sortByHasPercentageMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPercentageMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasRatingMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRatingMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasRatingMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRatingMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasTimeMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasTimeMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasWeightMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasWeightMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByHasWeightMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasWeightMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsDoubleTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDoubleTimer', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsDoubleTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDoubleTimer', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsHourlyChimeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHourlyChimeEnabled', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  sortByIsHourlyChimeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHourlyChimeEnabled', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNote', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNote', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsTimerRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerRunning', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsTimerRunningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerRunning', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsWorkPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWorkPeriod', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByIsWorkPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWorkPeriod', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastChimeTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChimeTime', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastChimeTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChimeTime', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompleted', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompleted', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastEditedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedDate', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastEditedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedDate', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastReset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReset', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByLastResetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReset', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByPercentageValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentageValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByPercentageValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentageValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByRatingValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByRatingValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByRecurrenceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByRecurrenceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortBySentiment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentiment', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortBySentimentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentiment', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortBySpecificDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specificDays', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortBySpecificDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specificDays', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByTargetSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByTimerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerType', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByTimerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerType', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> sortByWeightValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.desc);
    });
  }
}

extension TaskItemQuerySortThenBy
    on QueryBuilder<TaskItem, TaskItem, QSortThenBy> {
  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByAlarmSoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByAlarmSoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByAlarmTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByAlarmTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByBreakTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakTargetSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  thenByBreakTargetSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakTargetSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByChimeEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeEndHour', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByChimeEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeEndHour', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByChimeIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeIntervalMinutes', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  thenByChimeIntervalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeIntervalMinutes', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByChimeStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeStartHour', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByChimeStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chimeStartHour', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCounterMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterMax', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCounterMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterMax', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCounterValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCounterValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCurrentSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByCurrentSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByDistanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByDistanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByDoseValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByDoseValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByEnergyValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByEnergyValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByFinancialValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financialValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByFinancialValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financialValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'group', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'group', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasCounterMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCounterMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasCounterMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCounterMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasDistanceMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDistanceMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasDistanceMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDistanceMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasDoseMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDoseMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasDoseMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDoseMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasEnergyMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasEnergyMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasEnergyMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasEnergyMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasFinancialMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinancialMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  thenByHasFinancialMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinancialMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasPercentageMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPercentageMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  thenByHasPercentageMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPercentageMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasRatingMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRatingMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasRatingMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRatingMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasTimeMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasTimeMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasWeightMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasWeightMetric', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByHasWeightMetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasWeightMetric', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsDoubleTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDoubleTimer', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsDoubleTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDoubleTimer', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsHourlyChimeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHourlyChimeEnabled', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy>
  thenByIsHourlyChimeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHourlyChimeEnabled', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNote', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNote', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsTimerRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerRunning', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsTimerRunningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerRunning', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsWorkPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWorkPeriod', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByIsWorkPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWorkPeriod', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastChimeTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChimeTime', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastChimeTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChimeTime', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompleted', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompleted', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastEditedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedDate', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastEditedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedDate', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastReset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReset', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByLastResetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReset', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByPercentageValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentageValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByPercentageValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentageValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByRatingValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByRatingValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingValue', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByRecurrenceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByRecurrenceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenBySentiment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentiment', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenBySentimentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentiment', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenBySpecificDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specificDays', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenBySpecificDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specificDays', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetSeconds', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByTargetSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetSeconds', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByTimerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerType', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByTimerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerType', Sort.desc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.asc);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QAfterSortBy> thenByWeightValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.desc);
    });
  }
}

extension TaskItemQueryWhereDistinct
    on QueryBuilder<TaskItem, TaskItem, QDistinct> {
  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByAlarmSoundPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'alarmSoundPath',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByAlarmTime({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByBreakTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakTargetSeconds');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByChimeEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chimeEndHour');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByChimeIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chimeIntervalMinutes');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByChimeStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chimeStartHour');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByCounterMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'counterMax');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByCounterValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'counterValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByCurrentSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentSeconds');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByDistanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByDoseValue({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doseValue', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByEnergyValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByFinancialValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'financialValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'group', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasCounterMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasCounterMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasDistanceMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasDistanceMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasDoseMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasDoseMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasEnergyMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasEnergyMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasFinancialMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFinancialMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasPercentageMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasPercentageMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasRatingMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasRatingMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasTimeMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasTimeMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByHasWeightMetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasWeightMetric');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByImagePaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePaths');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByIsDoubleTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDoubleTimer');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByIsHourlyChimeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHourlyChimeEnabled');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByIsNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isNote');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByIsTimerRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTimerRunning');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByIsWorkPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isWorkPeriod');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByLastChimeTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastChimeTime');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByLastCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCompleted');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByLastEditedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEditedDate');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByLastReset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReset');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderIndex');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByPercentageValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'percentageValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByRatingValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratingValue');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByRecurrenceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurrenceType');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctBySentiment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sentiment');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctBySpecificDays({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'specificDays', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByTargetSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetSeconds');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByTimerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timerType');
    });
  }

  QueryBuilder<TaskItem, TaskItem, QDistinct> distinctByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightValue');
    });
  }
}

extension TaskItemQueryProperty
    on QueryBuilder<TaskItem, TaskItem, QQueryProperty> {
  QueryBuilder<TaskItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskItem, String?, QQueryOperations> alarmSoundPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmSoundPath');
    });
  }

  QueryBuilder<TaskItem, String?, QQueryOperations> alarmTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmTime');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> breakTargetSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakTargetSeconds');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> chimeEndHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chimeEndHour');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> chimeIntervalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chimeIntervalMinutes');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> chimeStartHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chimeStartHour');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> counterMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'counterMax');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> counterValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'counterValue');
    });
  }

  QueryBuilder<TaskItem, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> currentSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentSeconds');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> distanceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceValue');
    });
  }

  QueryBuilder<TaskItem, String, QQueryOperations> doseValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doseValue');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> energyValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyValue');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> financialValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'financialValue');
    });
  }

  QueryBuilder<TaskItem, String?, QQueryOperations> groupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'group');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasCounterMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasCounterMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasDistanceMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasDistanceMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasDoseMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasDoseMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasEnergyMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasEnergyMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasFinancialMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFinancialMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasPercentageMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasPercentageMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasRatingMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasRatingMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasTimeMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasTimeMetric');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> hasWeightMetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasWeightMetric');
    });
  }

  QueryBuilder<TaskItem, List<String>, QQueryOperations> imagePathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePaths');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> isDoubleTimerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDoubleTimer');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations>
  isHourlyChimeEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHourlyChimeEnabled');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> isNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isNote');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> isTimerRunningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTimerRunning');
    });
  }

  QueryBuilder<TaskItem, bool, QQueryOperations> isWorkPeriodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isWorkPeriod');
    });
  }

  QueryBuilder<TaskItem, DateTime?, QQueryOperations> lastChimeTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastChimeTime');
    });
  }

  QueryBuilder<TaskItem, DateTime?, QQueryOperations> lastCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCompleted');
    });
  }

  QueryBuilder<TaskItem, DateTime?, QQueryOperations> lastEditedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEditedDate');
    });
  }

  QueryBuilder<TaskItem, DateTime?, QQueryOperations> lastResetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReset');
    });
  }

  QueryBuilder<TaskItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TaskItem, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> orderIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderIndex');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> percentageValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percentageValue');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> ratingValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratingValue');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> recurrenceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurrenceType');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> sentimentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sentiment');
    });
  }

  QueryBuilder<TaskItem, String, QQueryOperations> specificDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'specificDays');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> targetSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetSeconds');
    });
  }

  QueryBuilder<TaskItem, int, QQueryOperations> timerTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timerType');
    });
  }

  QueryBuilder<TaskItem, double, QQueryOperations> weightValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightValue');
    });
  }
}
