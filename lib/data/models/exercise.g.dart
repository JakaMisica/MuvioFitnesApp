// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseCollection on Isar {
  IsarCollection<Exercise> get exercises => this.collection();
}

const ExerciseSchema = CollectionSchema(
  name: r'Exercise',
  id: 2972066467915231902,
  properties: {
    r'barbellWeight': PropertySchema(
      id: 0,
      name: r'barbellWeight',
      type: IsarType.double,
    ),
    r'caloriesUnit': PropertySchema(
      id: 1,
      name: r'caloriesUnit',
      type: IsarType.string,
    ),
    r'defaultUnit': PropertySchema(
      id: 2,
      name: r'defaultUnit',
      type: IsarType.string,
      enumMap: _ExercisedefaultUnitEnumValueMap,
    ),
    r'distanceUnit': PropertySchema(
      id: 3,
      name: r'distanceUnit',
      type: IsarType.string,
    ),
    r'hasBenchPosition': PropertySchema(
      id: 4,
      name: r'hasBenchPosition',
      type: IsarType.bool,
    ),
    r'hasCablePosition': PropertySchema(
      id: 5,
      name: r'hasCablePosition',
      type: IsarType.bool,
    ),
    r'isCustom': PropertySchema(id: 6, name: r'isCustom', type: IsarType.bool),
    r'isIsolate': PropertySchema(
      id: 7,
      name: r'isIsolate',
      type: IsarType.bool,
    ),
    r'muscleGroup': PropertySchema(
      id: 8,
      name: r'muscleGroup',
      type: IsarType.string,
      enumMap: _ExercisemuscleGroupEnumValueMap,
    ),
    r'name': PropertySchema(id: 9, name: r'name', type: IsarType.string),
    r'repsIncrement': PropertySchema(
      id: 10,
      name: r'repsIncrement',
      type: IsarType.double,
    ),
    r'secondaryMuscleEngagementMap': PropertySchema(
      id: 11,
      name: r'secondaryMuscleEngagementMap',
      type: IsarType.stringList,
    ),
    r'secondaryMuscleGroups': PropertySchema(
      id: 12,
      name: r'secondaryMuscleGroups',
      type: IsarType.stringList,
    ),
    r'speedUnit': PropertySchema(
      id: 13,
      name: r'speedUnit',
      type: IsarType.string,
    ),
    r'subGroup': PropertySchema(
      id: 14,
      name: r'subGroup',
      type: IsarType.string,
    ),
    r'subGroupEngagementMap': PropertySchema(
      id: 15,
      name: r'subGroupEngagementMap',
      type: IsarType.stringList,
    ),
    r'trackCalories': PropertySchema(
      id: 16,
      name: r'trackCalories',
      type: IsarType.bool,
    ),
    r'trackDistance': PropertySchema(
      id: 17,
      name: r'trackDistance',
      type: IsarType.bool,
    ),
    r'trackSpeed': PropertySchema(
      id: 18,
      name: r'trackSpeed',
      type: IsarType.bool,
    ),
    r'trackWeightReps': PropertySchema(
      id: 19,
      name: r'trackWeightReps',
      type: IsarType.bool,
    ),
    r'weightIncrement': PropertySchema(
      id: 20,
      name: r'weightIncrement',
      type: IsarType.double,
    ),
  },
  estimateSize: _exerciseEstimateSize,
  serialize: _exerciseSerialize,
  deserialize: _exerciseDeserialize,
  deserializeProp: _exerciseDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _exerciseGetId,
  getLinks: _exerciseGetLinks,
  attach: _exerciseAttach,
  version: '3.1.0+1',
);

int _exerciseEstimateSize(
  Exercise object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.caloriesUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.defaultUnit.name.length * 3;
  {
    final value = object.distanceUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.muscleGroup.name.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.secondaryMuscleEngagementMap.length * 3;
  {
    for (var i = 0; i < object.secondaryMuscleEngagementMap.length; i++) {
      final value = object.secondaryMuscleEngagementMap[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.secondaryMuscleGroups.length * 3;
  {
    for (var i = 0; i < object.secondaryMuscleGroups.length; i++) {
      final value = object.secondaryMuscleGroups[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.speedUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subGroup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.subGroupEngagementMap.length * 3;
  {
    for (var i = 0; i < object.subGroupEngagementMap.length; i++) {
      final value = object.subGroupEngagementMap[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _exerciseSerialize(
  Exercise object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.barbellWeight);
  writer.writeString(offsets[1], object.caloriesUnit);
  writer.writeString(offsets[2], object.defaultUnit.name);
  writer.writeString(offsets[3], object.distanceUnit);
  writer.writeBool(offsets[4], object.hasBenchPosition);
  writer.writeBool(offsets[5], object.hasCablePosition);
  writer.writeBool(offsets[6], object.isCustom);
  writer.writeBool(offsets[7], object.isIsolate);
  writer.writeString(offsets[8], object.muscleGroup.name);
  writer.writeString(offsets[9], object.name);
  writer.writeDouble(offsets[10], object.repsIncrement);
  writer.writeStringList(offsets[11], object.secondaryMuscleEngagementMap);
  writer.writeStringList(offsets[12], object.secondaryMuscleGroups);
  writer.writeString(offsets[13], object.speedUnit);
  writer.writeString(offsets[14], object.subGroup);
  writer.writeStringList(offsets[15], object.subGroupEngagementMap);
  writer.writeBool(offsets[16], object.trackCalories);
  writer.writeBool(offsets[17], object.trackDistance);
  writer.writeBool(offsets[18], object.trackSpeed);
  writer.writeBool(offsets[19], object.trackWeightReps);
  writer.writeDouble(offsets[20], object.weightIncrement);
}

Exercise _exerciseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Exercise();
  object.barbellWeight = reader.readDouble(offsets[0]);
  object.caloriesUnit = reader.readStringOrNull(offsets[1]);
  object.defaultUnit =
      _ExercisedefaultUnitValueEnumMap[reader.readStringOrNull(offsets[2])] ??
      WeightUnit.kg;
  object.distanceUnit = reader.readStringOrNull(offsets[3]);
  object.hasBenchPosition = reader.readBool(offsets[4]);
  object.hasCablePosition = reader.readBool(offsets[5]);
  object.id = id;
  object.isCustom = reader.readBool(offsets[6]);
  object.isIsolate = reader.readBool(offsets[7]);
  object.muscleGroup =
      _ExercisemuscleGroupValueEnumMap[reader.readStringOrNull(offsets[8])] ??
      MuscleGroup.chest;
  object.name = reader.readString(offsets[9]);
  object.repsIncrement = reader.readDouble(offsets[10]);
  object.secondaryMuscleEngagementMap =
      reader.readStringList(offsets[11]) ?? [];
  object.secondaryMuscleGroups = reader.readStringList(offsets[12]) ?? [];
  object.speedUnit = reader.readStringOrNull(offsets[13]);
  object.subGroup = reader.readStringOrNull(offsets[14]);
  object.subGroupEngagementMap = reader.readStringList(offsets[15]) ?? [];
  object.trackCalories = reader.readBool(offsets[16]);
  object.trackDistance = reader.readBool(offsets[17]);
  object.trackSpeed = reader.readBool(offsets[18]);
  object.trackWeightReps = reader.readBool(offsets[19]);
  object.weightIncrement = reader.readDouble(offsets[20]);
  return object;
}

P _exerciseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (_ExercisedefaultUnitValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              WeightUnit.kg)
          as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (_ExercisemuscleGroupValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              MuscleGroup.chest)
          as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readStringList(offset) ?? []) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringList(offset) ?? []) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ExercisedefaultUnitEnumValueMap = {r'kg': r'kg', r'lbs': r'lbs'};
const _ExercisedefaultUnitValueEnumMap = {
  r'kg': WeightUnit.kg,
  r'lbs': WeightUnit.lbs,
};
const _ExercisemuscleGroupEnumValueMap = {
  r'chest': r'chest',
  r'back': r'back',
  r'legs': r'legs',
  r'shoulders': r'shoulders',
  r'arms': r'arms',
  r'core': r'core',
  r'cardio': r'cardio',
  r'other': r'other',
};
const _ExercisemuscleGroupValueEnumMap = {
  r'chest': MuscleGroup.chest,
  r'back': MuscleGroup.back,
  r'legs': MuscleGroup.legs,
  r'shoulders': MuscleGroup.shoulders,
  r'arms': MuscleGroup.arms,
  r'core': MuscleGroup.core,
  r'cardio': MuscleGroup.cardio,
  r'other': MuscleGroup.other,
};

Id _exerciseGetId(Exercise object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _exerciseGetLinks(Exercise object) {
  return [];
}

void _exerciseAttach(IsarCollection<dynamic> col, Id id, Exercise object) {
  object.id = id;
}

extension ExerciseQueryWhereSort on QueryBuilder<Exercise, Exercise, QWhere> {
  QueryBuilder<Exercise, Exercise, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension ExerciseQueryWhere on QueryBuilder<Exercise, Exercise, QWhereClause> {
  QueryBuilder<Exercise, Exercise, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> idBetween(
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

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameNotEqualTo(
    String name,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'name',
          lower: [name],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'name',
          lower: [],
          upper: [name],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'name',
          lower: [lowerName],
          includeLower: includeLower,
          upper: [upperName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameStartsWith(
    String NamePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'name',
          lower: [NamePrefix],
          upper: ['$NamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: ['']),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'name', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'name', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'name', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'name', upper: ['']),
            );
      }
    });
  }
}

extension ExerciseQueryFilter
    on QueryBuilder<Exercise, Exercise, QFilterCondition> {
  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> barbellWeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'barbellWeight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  barbellWeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'barbellWeight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> barbellWeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'barbellWeight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> barbellWeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'barbellWeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'caloriesUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  caloriesUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'caloriesUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  caloriesUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'caloriesUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  caloriesUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'caloriesUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> caloriesUnitMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'caloriesUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  caloriesUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'caloriesUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  caloriesUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'caloriesUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitEqualTo(
    WeightUnit value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  defaultUnitGreaterThan(
    WeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitLessThan(
    WeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitBetween(
    WeightUnit lower,
    WeightUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'defaultUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'defaultUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'defaultUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> defaultUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'defaultUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  defaultUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'defaultUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'distanceUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  distanceUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'distanceUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  distanceUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distanceUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  distanceUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'distanceUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> distanceUnitMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'distanceUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  distanceUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'distanceUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  distanceUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'distanceUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  hasBenchPositionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasBenchPosition', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  hasCablePositionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasCablePosition', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> isCustomEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCustom', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> isIsolateEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isIsolate', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupEqualTo(
    MuscleGroup value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  muscleGroupGreaterThan(
    MuscleGroup value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupLessThan(
    MuscleGroup value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupBetween(
    MuscleGroup lower,
    MuscleGroup upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'muscleGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'muscleGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'muscleGroup',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> muscleGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'muscleGroup', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  muscleGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'muscleGroup', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> repsIncrementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'repsIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  repsIncrementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repsIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> repsIncrementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repsIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> repsIncrementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repsIncrement',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'secondaryMuscleEngagementMap',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'secondaryMuscleEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'secondaryMuscleEngagementMap',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'secondaryMuscleEngagementMap',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'secondaryMuscleEngagementMap',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleEngagementMapLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleEngagementMap',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'secondaryMuscleGroups',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'secondaryMuscleGroups',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'secondaryMuscleGroups',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'secondaryMuscleGroups', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'secondaryMuscleGroups',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleGroups',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'secondaryMuscleGroups', 0, true, 0, true);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'secondaryMuscleGroups', 0, false, 999999, true);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleGroups',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleGroups',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  secondaryMuscleGroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscleGroups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'speedUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'speedUnit'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'speedUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'speedUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'speedUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> speedUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'speedUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  speedUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'speedUnit', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'subGroup'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'subGroup'),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subGroup',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> subGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subGroupEngagementMap',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subGroupEngagementMap',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subGroupEngagementMap',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subGroupEngagementMap', value: ''),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'subGroupEngagementMap',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subGroupEngagementMap',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subGroupEngagementMap', 0, true, 0, true);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subGroupEngagementMap', 0, false, 999999, true);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subGroupEngagementMap',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subGroupEngagementMap',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  subGroupEngagementMapLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subGroupEngagementMap',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> trackCaloriesEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trackCalories', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> trackDistanceEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trackDistance', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition> trackSpeedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trackSpeed', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  trackWeightRepsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trackWeightReps', value: value),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  weightIncrementEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  weightIncrementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  weightIncrementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightIncrement',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterFilterCondition>
  weightIncrementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightIncrement',
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

extension ExerciseQueryObject
    on QueryBuilder<Exercise, Exercise, QFilterCondition> {}

extension ExerciseQueryLinks
    on QueryBuilder<Exercise, Exercise, QFilterCondition> {}

extension ExerciseQuerySortBy on QueryBuilder<Exercise, Exercise, QSortBy> {
  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByBarbellWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barbellWeight', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByBarbellWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barbellWeight', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByCaloriesUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByCaloriesUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByDefaultUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByDefaultUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByDistanceUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByDistanceUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByHasBenchPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBenchPosition', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByHasBenchPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBenchPosition', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByHasCablePosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCablePosition', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByHasCablePositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCablePosition', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByIsIsolate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIsolate', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByIsIsolateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIsolate', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByRepsIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repsIncrement', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByRepsIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repsIncrement', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortBySpeedUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortBySpeedUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCalories', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCalories', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackDistance', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackDistance', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackSpeed', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackSpeed', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackWeightReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackWeightReps', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByTrackWeightRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackWeightReps', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> sortByWeightIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.desc);
    });
  }
}

extension ExerciseQuerySortThenBy
    on QueryBuilder<Exercise, Exercise, QSortThenBy> {
  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByBarbellWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barbellWeight', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByBarbellWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barbellWeight', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByCaloriesUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByCaloriesUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByDefaultUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByDefaultUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByDistanceUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByDistanceUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByHasBenchPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBenchPosition', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByHasBenchPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBenchPosition', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByHasCablePosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCablePosition', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByHasCablePositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCablePosition', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByIsIsolate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIsolate', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByIsIsolateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIsolate', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByRepsIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repsIncrement', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByRepsIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repsIncrement', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenBySpeedUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedUnit', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenBySpeedUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedUnit', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCalories', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCalories', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackDistance', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackDistance', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackSpeed', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackSpeed', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackWeightReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackWeightReps', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByTrackWeightRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackWeightReps', Sort.desc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.asc);
    });
  }

  QueryBuilder<Exercise, Exercise, QAfterSortBy> thenByWeightIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.desc);
    });
  }
}

extension ExerciseQueryWhereDistinct
    on QueryBuilder<Exercise, Exercise, QDistinct> {
  QueryBuilder<Exercise, Exercise, QDistinct> distinctByBarbellWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barbellWeight');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByCaloriesUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriesUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByDefaultUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByDistanceUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByHasBenchPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasBenchPosition');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByHasCablePosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasCablePosition');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByIsIsolate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isIsolate');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByMuscleGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByRepsIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repsIncrement');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct>
  distinctBySecondaryMuscleEngagementMap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryMuscleEngagementMap');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct>
  distinctBySecondaryMuscleGroups() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryMuscleGroups');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctBySpeedUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speedUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctBySubGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct>
  distinctBySubGroupEngagementMap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subGroupEngagementMap');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByTrackCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackCalories');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByTrackDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackDistance');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByTrackSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackSpeed');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByTrackWeightReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackWeightReps');
    });
  }

  QueryBuilder<Exercise, Exercise, QDistinct> distinctByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightIncrement');
    });
  }
}

extension ExerciseQueryProperty
    on QueryBuilder<Exercise, Exercise, QQueryProperty> {
  QueryBuilder<Exercise, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Exercise, double, QQueryOperations> barbellWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barbellWeight');
    });
  }

  QueryBuilder<Exercise, String?, QQueryOperations> caloriesUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriesUnit');
    });
  }

  QueryBuilder<Exercise, WeightUnit, QQueryOperations> defaultUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultUnit');
    });
  }

  QueryBuilder<Exercise, String?, QQueryOperations> distanceUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceUnit');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> hasBenchPositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasBenchPosition');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> hasCablePositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasCablePosition');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> isIsolateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isIsolate');
    });
  }

  QueryBuilder<Exercise, MuscleGroup, QQueryOperations> muscleGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleGroup');
    });
  }

  QueryBuilder<Exercise, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Exercise, double, QQueryOperations> repsIncrementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repsIncrement');
    });
  }

  QueryBuilder<Exercise, List<String>, QQueryOperations>
  secondaryMuscleEngagementMapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryMuscleEngagementMap');
    });
  }

  QueryBuilder<Exercise, List<String>, QQueryOperations>
  secondaryMuscleGroupsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryMuscleGroups');
    });
  }

  QueryBuilder<Exercise, String?, QQueryOperations> speedUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speedUnit');
    });
  }

  QueryBuilder<Exercise, String?, QQueryOperations> subGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subGroup');
    });
  }

  QueryBuilder<Exercise, List<String>, QQueryOperations>
  subGroupEngagementMapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subGroupEngagementMap');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> trackCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackCalories');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> trackDistanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackDistance');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> trackSpeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackSpeed');
    });
  }

  QueryBuilder<Exercise, bool, QQueryOperations> trackWeightRepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackWeightReps');
    });
  }

  QueryBuilder<Exercise, double, QQueryOperations> weightIncrementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightIncrement');
    });
  }
}
