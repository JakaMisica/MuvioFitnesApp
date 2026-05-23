// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingsCollection on Isar {
  IsarCollection<UserSettings> get userSettings => this.collection();
}

const UserSettingsSchema = CollectionSchema(
  name: r'UserSettings',
  id: 4939698790990493221,
  properties: {
    r'activeCoachId': PropertySchema(
      id: 0,
      name: r'activeCoachId',
      type: IsarType.long,
    ),
    r'age': PropertySchema(id: 1, name: r'age', type: IsarType.long),
    r'availableKgPlates': PropertySchema(
      id: 2,
      name: r'availableKgPlates',
      type: IsarType.stringList,
    ),
    r'availableLbsPlates': PropertySchema(
      id: 3,
      name: r'availableLbsPlates',
      type: IsarType.stringList,
    ),
    r'coins': PropertySchema(id: 4, name: r'coins', type: IsarType.long),
    r'consecutiveGetLostCount': PropertySchema(
      id: 5,
      name: r'consecutiveGetLostCount',
      type: IsarType.long,
    ),
    r'devPersistLogin': PropertySchema(
      id: 6,
      name: r'devPersistLogin',
      type: IsarType.bool,
    ),
    r'expandedExerciseIds': PropertySchema(
      id: 7,
      name: r'expandedExerciseIds',
      type: IsarType.longList,
    ),
    r'gender': PropertySchema(id: 8, name: r'gender', type: IsarType.string),
    r'goal': PropertySchema(id: 9, name: r'goal', type: IsarType.string),
    r'hasProcessedReferral': PropertySchema(
      id: 10,
      name: r'hasProcessedReferral',
      type: IsarType.bool,
    ),
    r'heightCm': PropertySchema(
      id: 11,
      name: r'heightCm',
      type: IsarType.double,
    ),
    r'isAiCallActive': PropertySchema(
      id: 12,
      name: r'isAiCallActive',
      type: IsarType.bool,
    ),
    r'isAiCallEnabled': PropertySchema(
      id: 13,
      name: r'isAiCallEnabled',
      type: IsarType.bool,
    ),
    r'isGuidedBreathingEnabled': PropertySchema(
      id: 14,
      name: r'isGuidedBreathingEnabled',
      type: IsarType.bool,
    ),
    r'isInjured': PropertySchema(
      id: 15,
      name: r'isInjured',
      type: IsarType.bool,
    ),
    r'isPremium': PropertySchema(
      id: 16,
      name: r'isPremium',
      type: IsarType.bool,
    ),
    r'isProfileComplete': PropertySchema(
      id: 17,
      name: r'isProfileComplete',
      type: IsarType.bool,
    ),
    r'isSick': PropertySchema(id: 18, name: r'isSick', type: IsarType.bool),
    r'lastAppOpenDate': PropertySchema(
      id: 19,
      name: r'lastAppOpenDate',
      type: IsarType.dateTime,
    ),
    r'lastMusclePointTime': PropertySchema(
      id: 20,
      name: r'lastMusclePointTime',
      type: IsarType.dateTime,
    ),
    r'lastRewardResetDate': PropertySchema(
      id: 21,
      name: r'lastRewardResetDate',
      type: IsarType.dateTime,
    ),
    r'lastSetCompletedDate': PropertySchema(
      id: 22,
      name: r'lastSetCompletedDate',
      type: IsarType.dateTime,
    ),
    r'lastWorkoutDate': PropertySchema(
      id: 23,
      name: r'lastWorkoutDate',
      type: IsarType.dateTime,
    ),
    r'lastWorkoutFinishTime': PropertySchema(
      id: 24,
      name: r'lastWorkoutFinishTime',
      type: IsarType.dateTime,
    ),
    r'musclePoints': PropertySchema(
      id: 25,
      name: r'musclePoints',
      type: IsarType.long,
    ),
    r'nextAiCallAllowedDate': PropertySchema(
      id: 26,
      name: r'nextAiCallAllowedDate',
      type: IsarType.dateTime,
    ),
    r'restTimerEndTime': PropertySchema(
      id: 27,
      name: r'restTimerEndTime',
      type: IsarType.dateTime,
    ),
    r'restTimerExerciseLogId': PropertySchema(
      id: 28,
      name: r'restTimerExerciseLogId',
      type: IsarType.long,
    ),
    r'restTimerNextSetIndex': PropertySchema(
      id: 29,
      name: r'restTimerNextSetIndex',
      type: IsarType.long,
    ),
    r'restTimerTotalDuration': PropertySchema(
      id: 30,
      name: r'restTimerTotalDuration',
      type: IsarType.long,
    ),
    r'rewardedTaskNamesToday': PropertySchema(
      id: 31,
      name: r'rewardedTaskNamesToday',
      type: IsarType.stringList,
    ),
    r'showExtraMetrics': PropertySchema(
      id: 32,
      name: r'showExtraMetrics',
      type: IsarType.bool,
    ),
    r'socialUserId': PropertySchema(
      id: 33,
      name: r'socialUserId',
      type: IsarType.string,
    ),
    r'socialUserName': PropertySchema(
      id: 34,
      name: r'socialUserName',
      type: IsarType.string,
    ),
    r'todayDietCoinsCount': PropertySchema(
      id: 35,
      name: r'todayDietCoinsCount',
      type: IsarType.long,
    ),
    r'totalFreeAiMessages': PropertySchema(
      id: 36,
      name: r'totalFreeAiMessages',
      type: IsarType.long,
    ),
    r'useKgAsDefault': PropertySchema(
      id: 37,
      name: r'useKgAsDefault',
      type: IsarType.bool,
    ),
    r'useKgForGrip': PropertySchema(
      id: 38,
      name: r'useKgForGrip',
      type: IsarType.bool,
    ),
    r'useLbsForVolume': PropertySchema(
      id: 39,
      name: r'useLbsForVolume',
      type: IsarType.bool,
    ),
    r'useMetricHeight': PropertySchema(
      id: 40,
      name: r'useMetricHeight',
      type: IsarType.bool,
    ),
    r'useMetricMeasurements': PropertySchema(
      id: 41,
      name: r'useMetricMeasurements',
      type: IsarType.bool,
    ),
    r'usedAiMessages': PropertySchema(
      id: 42,
      name: r'usedAiMessages',
      type: IsarType.long,
    ),
    r'workoutFrequencyDays': PropertySchema(
      id: 43,
      name: r'workoutFrequencyDays',
      type: IsarType.long,
    ),
  },
  estimateSize: _userSettingsEstimateSize,
  serialize: _userSettingsSerialize,
  deserialize: _userSettingsDeserialize,
  deserializeProp: _userSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userSettingsGetId,
  getLinks: _userSettingsGetLinks,
  attach: _userSettingsAttach,
  version: '3.1.0+1',
);

int _userSettingsEstimateSize(
  UserSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.availableKgPlates.length * 3;
  {
    for (var i = 0; i < object.availableKgPlates.length; i++) {
      final value = object.availableKgPlates[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.availableLbsPlates.length * 3;
  {
    for (var i = 0; i < object.availableLbsPlates.length; i++) {
      final value = object.availableLbsPlates[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.expandedExerciseIds.length * 8;
  bytesCount += 3 + object.gender.length * 3;
  bytesCount += 3 + object.goal.length * 3;
  bytesCount += 3 + object.rewardedTaskNamesToday.length * 3;
  {
    for (var i = 0; i < object.rewardedTaskNamesToday.length; i++) {
      final value = object.rewardedTaskNamesToday[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.socialUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.socialUserName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userSettingsSerialize(
  UserSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.activeCoachId);
  writer.writeLong(offsets[1], object.age);
  writer.writeStringList(offsets[2], object.availableKgPlates);
  writer.writeStringList(offsets[3], object.availableLbsPlates);
  writer.writeLong(offsets[4], object.coins);
  writer.writeLong(offsets[5], object.consecutiveGetLostCount);
  writer.writeBool(offsets[6], object.devPersistLogin);
  writer.writeLongList(offsets[7], object.expandedExerciseIds);
  writer.writeString(offsets[8], object.gender);
  writer.writeString(offsets[9], object.goal);
  writer.writeBool(offsets[10], object.hasProcessedReferral);
  writer.writeDouble(offsets[11], object.heightCm);
  writer.writeBool(offsets[12], object.isAiCallActive);
  writer.writeBool(offsets[13], object.isAiCallEnabled);
  writer.writeBool(offsets[14], object.isGuidedBreathingEnabled);
  writer.writeBool(offsets[15], object.isInjured);
  writer.writeBool(offsets[16], object.isPremium);
  writer.writeBool(offsets[17], object.isProfileComplete);
  writer.writeBool(offsets[18], object.isSick);
  writer.writeDateTime(offsets[19], object.lastAppOpenDate);
  writer.writeDateTime(offsets[20], object.lastMusclePointTime);
  writer.writeDateTime(offsets[21], object.lastRewardResetDate);
  writer.writeDateTime(offsets[22], object.lastSetCompletedDate);
  writer.writeDateTime(offsets[23], object.lastWorkoutDate);
  writer.writeDateTime(offsets[24], object.lastWorkoutFinishTime);
  writer.writeLong(offsets[25], object.musclePoints);
  writer.writeDateTime(offsets[26], object.nextAiCallAllowedDate);
  writer.writeDateTime(offsets[27], object.restTimerEndTime);
  writer.writeLong(offsets[28], object.restTimerExerciseLogId);
  writer.writeLong(offsets[29], object.restTimerNextSetIndex);
  writer.writeLong(offsets[30], object.restTimerTotalDuration);
  writer.writeStringList(offsets[31], object.rewardedTaskNamesToday);
  writer.writeBool(offsets[32], object.showExtraMetrics);
  writer.writeString(offsets[33], object.socialUserId);
  writer.writeString(offsets[34], object.socialUserName);
  writer.writeLong(offsets[35], object.todayDietCoinsCount);
  writer.writeLong(offsets[36], object.totalFreeAiMessages);
  writer.writeBool(offsets[37], object.useKgAsDefault);
  writer.writeBool(offsets[38], object.useKgForGrip);
  writer.writeBool(offsets[39], object.useLbsForVolume);
  writer.writeBool(offsets[40], object.useMetricHeight);
  writer.writeBool(offsets[41], object.useMetricMeasurements);
  writer.writeLong(offsets[42], object.usedAiMessages);
  writer.writeLong(offsets[43], object.workoutFrequencyDays);
}

UserSettings _userSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettings();
  object.activeCoachId = reader.readLongOrNull(offsets[0]);
  object.age = reader.readLong(offsets[1]);
  object.availableKgPlates = reader.readStringList(offsets[2]) ?? [];
  object.availableLbsPlates = reader.readStringList(offsets[3]) ?? [];
  object.coins = reader.readLong(offsets[4]);
  object.consecutiveGetLostCount = reader.readLong(offsets[5]);
  object.devPersistLogin = reader.readBool(offsets[6]);
  object.expandedExerciseIds = reader.readLongList(offsets[7]) ?? [];
  object.gender = reader.readString(offsets[8]);
  object.goal = reader.readString(offsets[9]);
  object.hasProcessedReferral = reader.readBool(offsets[10]);
  object.heightCm = reader.readDouble(offsets[11]);
  object.id = id;
  object.isAiCallActive = reader.readBool(offsets[12]);
  object.isAiCallEnabled = reader.readBool(offsets[13]);
  object.isGuidedBreathingEnabled = reader.readBool(offsets[14]);
  object.isInjured = reader.readBool(offsets[15]);
  object.isPremium = reader.readBool(offsets[16]);
  object.isProfileComplete = reader.readBool(offsets[17]);
  object.isSick = reader.readBool(offsets[18]);
  object.lastAppOpenDate = reader.readDateTimeOrNull(offsets[19]);
  object.lastMusclePointTime = reader.readDateTimeOrNull(offsets[20]);
  object.lastRewardResetDate = reader.readDateTimeOrNull(offsets[21]);
  object.lastSetCompletedDate = reader.readDateTimeOrNull(offsets[22]);
  object.lastWorkoutDate = reader.readDateTimeOrNull(offsets[23]);
  object.lastWorkoutFinishTime = reader.readDateTimeOrNull(offsets[24]);
  object.musclePoints = reader.readLong(offsets[25]);
  object.nextAiCallAllowedDate = reader.readDateTimeOrNull(offsets[26]);
  object.restTimerEndTime = reader.readDateTimeOrNull(offsets[27]);
  object.restTimerExerciseLogId = reader.readLongOrNull(offsets[28]);
  object.restTimerNextSetIndex = reader.readLongOrNull(offsets[29]);
  object.restTimerTotalDuration = reader.readLongOrNull(offsets[30]);
  object.rewardedTaskNamesToday = reader.readStringList(offsets[31]) ?? [];
  object.showExtraMetrics = reader.readBool(offsets[32]);
  object.socialUserId = reader.readStringOrNull(offsets[33]);
  object.socialUserName = reader.readStringOrNull(offsets[34]);
  object.todayDietCoinsCount = reader.readLong(offsets[35]);
  object.totalFreeAiMessages = reader.readLong(offsets[36]);
  object.useKgAsDefault = reader.readBool(offsets[37]);
  object.useKgForGrip = reader.readBool(offsets[38]);
  object.useLbsForVolume = reader.readBool(offsets[39]);
  object.useMetricHeight = reader.readBool(offsets[40]);
  object.useMetricMeasurements = reader.readBool(offsets[41]);
  object.usedAiMessages = reader.readLong(offsets[42]);
  object.workoutFrequencyDays = reader.readLong(offsets[43]);
  return object;
}

P _userSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readLongList(offset) ?? []) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 20:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 21:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 22:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 23:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 24:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 25:
      return (reader.readLong(offset)) as P;
    case 26:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 27:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readLongOrNull(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readStringList(offset) ?? []) as P;
    case 32:
      return (reader.readBool(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset)) as P;
    case 35:
      return (reader.readLong(offset)) as P;
    case 36:
      return (reader.readLong(offset)) as P;
    case 37:
      return (reader.readBool(offset)) as P;
    case 38:
      return (reader.readBool(offset)) as P;
    case 39:
      return (reader.readBool(offset)) as P;
    case 40:
      return (reader.readBool(offset)) as P;
    case 41:
      return (reader.readBool(offset)) as P;
    case 42:
      return (reader.readLong(offset)) as P;
    case 43:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userSettingsGetId(UserSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSettingsGetLinks(UserSettings object) {
  return [];
}

void _userSettingsAttach(
  IsarCollection<dynamic> col,
  Id id,
  UserSettings object,
) {
  object.id = id;
}

extension UserSettingsQueryWhereSort
    on QueryBuilder<UserSettings, UserSettings, QWhere> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSettingsQueryWhere
    on QueryBuilder<UserSettings, UserSettings, QWhereClause> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idBetween(
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
}

extension UserSettingsQueryFilter
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {
  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'activeCoachId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'activeCoachId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activeCoachId', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activeCoachId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activeCoachId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  activeCoachIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activeCoachId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> ageEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'age', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  ageGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'age',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> ageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'age',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> ageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'age',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'availableKgPlates',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'availableKgPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'availableKgPlates',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'availableKgPlates', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'availableKgPlates', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableKgPlates', length, true, length, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableKgPlates', 0, true, 0, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableKgPlates', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableKgPlates', 0, true, length, include);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'availableKgPlates',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableKgPlatesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'availableKgPlates',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'availableLbsPlates',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'availableLbsPlates',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'availableLbsPlates',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'availableLbsPlates', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'availableLbsPlates', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'availableLbsPlates',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableLbsPlates', 0, true, 0, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableLbsPlates', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'availableLbsPlates', 0, true, length, include);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'availableLbsPlates',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  availableLbsPlatesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'availableLbsPlates',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> coinsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'coins', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  coinsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'coins',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> coinsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'coins',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> coinsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'coins',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  consecutiveGetLostCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'consecutiveGetLostCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  consecutiveGetLostCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'consecutiveGetLostCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  consecutiveGetLostCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'consecutiveGetLostCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  consecutiveGetLostCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'consecutiveGetLostCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  devPersistLoginEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'devPersistLogin', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'expandedExerciseIds', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'expandedExerciseIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'expandedExerciseIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'expandedExerciseIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expandedExerciseIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedExerciseIds', 0, true, 0, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedExerciseIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedExerciseIds', 0, true, length, include);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expandedExerciseIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  expandedExerciseIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expandedExerciseIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> genderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> genderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gender',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> genderMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'gender',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gender', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'gender', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  goalGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'goal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  goalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'goal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> goalMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'goal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  goalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'goal', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  goalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'goal', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  hasProcessedReferralEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hasProcessedReferral',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  heightCmEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'heightCm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  heightCmGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'heightCm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  heightCmLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'heightCm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  heightCmBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'heightCm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isAiCallActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isAiCallActive', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isAiCallEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isAiCallEnabled', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isGuidedBreathingEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'isGuidedBreathingEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isInjuredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isInjured', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isPremiumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPremium', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  isProfileCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isProfileComplete', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> isSickEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isSick', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastAppOpenDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastAppOpenDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastAppOpenDate', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastAppOpenDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastAppOpenDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastAppOpenDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastAppOpenDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastMusclePointTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastMusclePointTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastMusclePointTime', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastMusclePointTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastMusclePointTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastMusclePointTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastMusclePointTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastRewardResetDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastRewardResetDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastRewardResetDate', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastRewardResetDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastRewardResetDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastRewardResetDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastRewardResetDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastSetCompletedDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastSetCompletedDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lastSetCompletedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSetCompletedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSetCompletedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastSetCompletedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSetCompletedDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastWorkoutDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastWorkoutDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastWorkoutDate', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastWorkoutDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastWorkoutDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastWorkoutDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastWorkoutFinishTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastWorkoutFinishTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lastWorkoutFinishTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastWorkoutFinishTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastWorkoutFinishTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  lastWorkoutFinishTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastWorkoutFinishTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  musclePointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'musclePoints', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  musclePointsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'musclePoints',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  musclePointsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'musclePoints',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  musclePointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'musclePoints',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nextAiCallAllowedDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nextAiCallAllowedDate'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nextAiCallAllowedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nextAiCallAllowedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nextAiCallAllowedDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  nextAiCallAllowedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nextAiCallAllowedDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restTimerEndTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restTimerEndTime'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restTimerEndTime', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restTimerEndTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restTimerEndTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerEndTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restTimerEndTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restTimerExerciseLogId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restTimerExerciseLogId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'restTimerExerciseLogId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restTimerExerciseLogId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restTimerExerciseLogId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerExerciseLogIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restTimerExerciseLogId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restTimerNextSetIndex'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restTimerNextSetIndex'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'restTimerNextSetIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restTimerNextSetIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restTimerNextSetIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerNextSetIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restTimerNextSetIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restTimerTotalDuration'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restTimerTotalDuration'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'restTimerTotalDuration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restTimerTotalDuration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restTimerTotalDuration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  restTimerTotalDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restTimerTotalDuration',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rewardedTaskNamesToday',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'rewardedTaskNamesToday',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'rewardedTaskNamesToday',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rewardedTaskNamesToday', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'rewardedTaskNamesToday',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rewardedTaskNamesToday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rewardedTaskNamesToday', 0, true, 0, true);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rewardedTaskNamesToday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rewardedTaskNamesToday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rewardedTaskNamesToday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  rewardedTaskNamesTodayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rewardedTaskNamesToday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  showExtraMetricsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'showExtraMetrics', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'socialUserId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'socialUserId'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'socialUserId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'socialUserId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'socialUserId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'socialUserId', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'socialUserId', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'socialUserName'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'socialUserName'),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'socialUserName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'socialUserName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'socialUserName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'socialUserName', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  socialUserNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'socialUserName', value: ''),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  todayDietCoinsCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'todayDietCoinsCount', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  todayDietCoinsCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'todayDietCoinsCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  todayDietCoinsCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'todayDietCoinsCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  todayDietCoinsCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'todayDietCoinsCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  totalFreeAiMessagesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalFreeAiMessages', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  totalFreeAiMessagesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalFreeAiMessages',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  totalFreeAiMessagesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalFreeAiMessages',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  totalFreeAiMessagesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalFreeAiMessages',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  useKgAsDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'useKgAsDefault', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  useKgForGripEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'useKgForGrip', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  useLbsForVolumeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'useLbsForVolume', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  useMetricHeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'useMetricHeight', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  useMetricMeasurementsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'useMetricMeasurements',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  usedAiMessagesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'usedAiMessages', value: value),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  usedAiMessagesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'usedAiMessages',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  usedAiMessagesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'usedAiMessages',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  usedAiMessagesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'usedAiMessages',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  workoutFrequencyDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'workoutFrequencyDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  workoutFrequencyDaysGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workoutFrequencyDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  workoutFrequencyDaysLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workoutFrequencyDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
  workoutFrequencyDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workoutFrequencyDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UserSettingsQueryObject
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQueryLinks
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQuerySortBy
    on QueryBuilder<UserSettings, UserSettings, QSortBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByActiveCoachId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCoachId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByActiveCoachIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCoachId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByConsecutiveGetLostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveGetLostCount', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByConsecutiveGetLostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveGetLostCount', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByDevPersistLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devPersistLogin', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByDevPersistLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devPersistLogin', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByHasProcessedReferral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasProcessedReferral', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByHasProcessedReferralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasProcessedReferral', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsAiCallActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallActive', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsAiCallActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallActive', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsAiCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsAiCallEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsGuidedBreathingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuidedBreathingEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsGuidedBreathingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuidedBreathingEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsInjured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInjured', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsInjuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInjured', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsProfileComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileComplete', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByIsProfileCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileComplete', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsSick() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSick', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsSickDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSick', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastAppOpenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAppOpenDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastAppOpenDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAppOpenDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastMusclePointTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMusclePointTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastMusclePointTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMusclePointTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastRewardResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRewardResetDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastRewardResetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRewardResetDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastSetCompletedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSetCompletedDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastSetCompletedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSetCompletedDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastWorkoutDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastWorkoutFinishTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutFinishTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByLastWorkoutFinishTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutFinishTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByMusclePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musclePoints', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByMusclePointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musclePoints', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByNextAiCallAllowedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextAiCallAllowedDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByNextAiCallAllowedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextAiCallAllowedDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerEndTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerEndTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerExerciseLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerExerciseLogId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerExerciseLogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerExerciseLogId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerNextSetIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerNextSetIndex', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerNextSetIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerNextSetIndex', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerTotalDuration', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByRestTimerTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerTotalDuration', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByShowExtraMetrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExtraMetrics', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByShowExtraMetricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExtraMetrics', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortBySocialUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortBySocialUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortBySocialUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserName', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortBySocialUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserName', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByTodayDietCoinsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayDietCoinsCount', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByTodayDietCoinsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayDietCoinsCount', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByTotalFreeAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFreeAiMessages', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByTotalFreeAiMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFreeAiMessages', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseKgAsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgAsDefault', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseKgAsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgAsDefault', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByUseKgForGrip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgForGrip', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseKgForGripDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgForGrip', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseLbsForVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useLbsForVolume', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseLbsForVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useLbsForVolume', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseMetricHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricHeight', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseMetricHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricHeight', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseMetricMeasurements() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricMeasurements', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUseMetricMeasurementsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricMeasurements', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUsedAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usedAiMessages', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByUsedAiMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usedAiMessages', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByWorkoutFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutFrequencyDays', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  sortByWorkoutFrequencyDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutFrequencyDays', Sort.desc);
    });
  }
}

extension UserSettingsQuerySortThenBy
    on QueryBuilder<UserSettings, UserSettings, QSortThenBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByActiveCoachId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCoachId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByActiveCoachIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCoachId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByConsecutiveGetLostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveGetLostCount', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByConsecutiveGetLostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveGetLostCount', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByDevPersistLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devPersistLogin', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByDevPersistLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devPersistLogin', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByHasProcessedReferral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasProcessedReferral', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByHasProcessedReferralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasProcessedReferral', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsAiCallActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallActive', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsAiCallActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallActive', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsAiCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsAiCallEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiCallEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsGuidedBreathingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuidedBreathingEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsGuidedBreathingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuidedBreathingEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsInjured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInjured', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsInjuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInjured', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsProfileComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileComplete', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByIsProfileCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileComplete', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsSick() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSick', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsSickDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSick', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastAppOpenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAppOpenDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastAppOpenDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAppOpenDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastMusclePointTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMusclePointTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastMusclePointTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMusclePointTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastRewardResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRewardResetDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastRewardResetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRewardResetDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastSetCompletedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSetCompletedDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastSetCompletedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSetCompletedDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastWorkoutDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastWorkoutFinishTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutFinishTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByLastWorkoutFinishTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWorkoutFinishTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByMusclePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musclePoints', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByMusclePointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musclePoints', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByNextAiCallAllowedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextAiCallAllowedDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByNextAiCallAllowedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextAiCallAllowedDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerEndTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerEndTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerExerciseLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerExerciseLogId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerExerciseLogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerExerciseLogId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerNextSetIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerNextSetIndex', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerNextSetIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerNextSetIndex', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerTotalDuration', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByRestTimerTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTimerTotalDuration', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByShowExtraMetrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExtraMetrics', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByShowExtraMetricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExtraMetrics', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenBySocialUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenBySocialUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserId', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenBySocialUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserName', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenBySocialUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'socialUserName', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByTodayDietCoinsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayDietCoinsCount', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByTodayDietCoinsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayDietCoinsCount', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByTotalFreeAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFreeAiMessages', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByTotalFreeAiMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFreeAiMessages', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseKgAsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgAsDefault', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseKgAsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgAsDefault', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByUseKgForGrip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgForGrip', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseKgForGripDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useKgForGrip', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseLbsForVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useLbsForVolume', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseLbsForVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useLbsForVolume', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseMetricHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricHeight', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseMetricHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricHeight', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseMetricMeasurements() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricMeasurements', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUseMetricMeasurementsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useMetricMeasurements', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUsedAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usedAiMessages', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByUsedAiMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usedAiMessages', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByWorkoutFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutFrequencyDays', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
  thenByWorkoutFrequencyDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutFrequencyDays', Sort.desc);
    });
  }
}

extension UserSettingsQueryWhereDistinct
    on QueryBuilder<UserSettings, UserSettings, QDistinct> {
  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByActiveCoachId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeCoachId');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByAvailableKgPlates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'availableKgPlates');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByAvailableLbsPlates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'availableLbsPlates');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coins');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByConsecutiveGetLostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consecutiveGetLostCount');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByDevPersistLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'devPersistLogin');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByExpandedExerciseIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expandedExerciseIds');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByGender({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByGoal({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByHasProcessedReferral() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasProcessedReferral');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightCm');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByIsAiCallActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAiCallActive');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByIsAiCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAiCallEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByIsGuidedBreathingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGuidedBreathingEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByIsInjured() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isInjured');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPremium');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByIsProfileComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isProfileComplete');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByIsSick() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSick');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastAppOpenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAppOpenDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastMusclePointTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMusclePointTime');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastRewardResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRewardResetDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastSetCompletedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSetCompletedDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWorkoutDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByLastWorkoutFinishTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWorkoutFinishTime');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByMusclePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'musclePoints');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByNextAiCallAllowedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextAiCallAllowedDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByRestTimerEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restTimerEndTime');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByRestTimerExerciseLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restTimerExerciseLogId');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByRestTimerNextSetIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restTimerNextSetIndex');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByRestTimerTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restTimerTotalDuration');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByRewardedTaskNamesToday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rewardedTaskNamesToday');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByShowExtraMetrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showExtraMetrics');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctBySocialUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'socialUserId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctBySocialUserName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'socialUserName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByTodayDietCoinsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'todayDietCoinsCount');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByTotalFreeAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFreeAiMessages');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByUseKgAsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useKgAsDefault');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByUseKgForGrip() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useKgForGrip');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByUseLbsForVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useLbsForVolume');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByUseMetricHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useMetricHeight');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByUseMetricMeasurements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useMetricMeasurements');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByUsedAiMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usedAiMessages');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
  distinctByWorkoutFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutFrequencyDays');
    });
  }
}

extension UserSettingsQueryProperty
    on QueryBuilder<UserSettings, UserSettings, QQueryProperty> {
  QueryBuilder<UserSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettings, int?, QQueryOperations> activeCoachIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeCoachId');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<UserSettings, List<String>, QQueryOperations>
  availableKgPlatesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'availableKgPlates');
    });
  }

  QueryBuilder<UserSettings, List<String>, QQueryOperations>
  availableLbsPlatesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'availableLbsPlates');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations> coinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coins');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations>
  consecutiveGetLostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consecutiveGetLostCount');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> devPersistLoginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'devPersistLogin');
    });
  }

  QueryBuilder<UserSettings, List<int>, QQueryOperations>
  expandedExerciseIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expandedExerciseIds');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations> goalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goal');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
  hasProcessedReferralProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasProcessedReferral');
    });
  }

  QueryBuilder<UserSettings, double, QQueryOperations> heightCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightCm');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isAiCallActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAiCallActive');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isAiCallEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAiCallEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
  isGuidedBreathingEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGuidedBreathingEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isInjuredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isInjured');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isPremiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPremium');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
  isProfileCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isProfileComplete');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isSickProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSick');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastAppOpenDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAppOpenDate');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastMusclePointTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMusclePointTime');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastRewardResetDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRewardResetDate');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastSetCompletedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSetCompletedDate');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastWorkoutDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWorkoutDate');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  lastWorkoutFinishTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWorkoutFinishTime');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations> musclePointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'musclePoints');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  nextAiCallAllowedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextAiCallAllowedDate');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
  restTimerEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTimerEndTime');
    });
  }

  QueryBuilder<UserSettings, int?, QQueryOperations>
  restTimerExerciseLogIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTimerExerciseLogId');
    });
  }

  QueryBuilder<UserSettings, int?, QQueryOperations>
  restTimerNextSetIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTimerNextSetIndex');
    });
  }

  QueryBuilder<UserSettings, int?, QQueryOperations>
  restTimerTotalDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTimerTotalDuration');
    });
  }

  QueryBuilder<UserSettings, List<String>, QQueryOperations>
  rewardedTaskNamesTodayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rewardedTaskNamesToday');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
  showExtraMetricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showExtraMetrics');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> socialUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'socialUserId');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations>
  socialUserNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'socialUserName');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations>
  todayDietCoinsCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'todayDietCoinsCount');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations>
  totalFreeAiMessagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFreeAiMessages');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> useKgAsDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useKgAsDefault');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> useKgForGripProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useKgForGrip');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> useLbsForVolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useLbsForVolume');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> useMetricHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useMetricHeight');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
  useMetricMeasurementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useMetricMeasurements');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations> usedAiMessagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usedAiMessages');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations>
  workoutFrequencyDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutFrequencyDays');
    });
  }
}
