// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatigue_state.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFatigueStateCollection on Isar {
  IsarCollection<FatigueState> get fatigueStates => this.collection();
}

const FatigueStateSchema = CollectionSchema(
  name: r'FatigueState',
  id: 4572279692108921640,
  properties: {
    r'compositeKey': PropertySchema(
      id: 0,
      name: r'compositeKey',
      type: IsarType.string,
    ),
    r'currentFatiguePercent': PropertySchema(
      id: 1,
      name: r'currentFatiguePercent',
      type: IsarType.double,
    ),
    r'lastUpdateTime': PropertySchema(
      id: 2,
      name: r'lastUpdateTime',
      type: IsarType.dateTime,
    ),
    r'muscleGroup': PropertySchema(
      id: 3,
      name: r'muscleGroup',
      type: IsarType.string,
    ),
    r'peakFatiguePercent': PropertySchema(
      id: 4,
      name: r'peakFatiguePercent',
      type: IsarType.double,
    ),
    r'side': PropertySchema(id: 5, name: r'side', type: IsarType.string),
    r'snapshots': PropertySchema(
      id: 6,
      name: r'snapshots',
      type: IsarType.objectList,
      target: r'FatigueSnapshot',
    ),
    r'subGroup': PropertySchema(
      id: 7,
      name: r'subGroup',
      type: IsarType.string,
    ),
    r'workoutDate': PropertySchema(
      id: 8,
      name: r'workoutDate',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _fatigueStateEstimateSize,
  serialize: _fatigueStateSerialize,
  deserialize: _fatigueStateDeserialize,
  deserializeProp: _fatigueStateDeserializeProp,
  idName: r'id',
  indexes: {
    r'workoutDate': IndexSchema(
      id: -5586023166526116543,
      name: r'workoutDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'workoutDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'compositeKey': IndexSchema(
      id: -66619599277560115,
      name: r'compositeKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'compositeKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {r'FatigueSnapshot': FatigueSnapshotSchema},
  getId: _fatigueStateGetId,
  getLinks: _fatigueStateGetLinks,
  attach: _fatigueStateAttach,
  version: '3.1.0+1',
);

int _fatigueStateEstimateSize(
  FatigueState object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.compositeKey.length * 3;
  bytesCount += 3 + object.muscleGroup.length * 3;
  {
    final value = object.side;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.snapshots.length * 3;
  {
    final offsets = allOffsets[FatigueSnapshot]!;
    for (var i = 0; i < object.snapshots.length; i++) {
      final value = object.snapshots[i];
      bytesCount += FatigueSnapshotSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  {
    final value = object.subGroup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fatigueStateSerialize(
  FatigueState object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.compositeKey);
  writer.writeDouble(offsets[1], object.currentFatiguePercent);
  writer.writeDateTime(offsets[2], object.lastUpdateTime);
  writer.writeString(offsets[3], object.muscleGroup);
  writer.writeDouble(offsets[4], object.peakFatiguePercent);
  writer.writeString(offsets[5], object.side);
  writer.writeObjectList<FatigueSnapshot>(
    offsets[6],
    allOffsets,
    FatigueSnapshotSchema.serialize,
    object.snapshots,
  );
  writer.writeString(offsets[7], object.subGroup);
  writer.writeDateTime(offsets[8], object.workoutDate);
}

FatigueState _fatigueStateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FatigueState();
  object.currentFatiguePercent = reader.readDouble(offsets[1]);
  object.id = id;
  object.lastUpdateTime = reader.readDateTime(offsets[2]);
  object.muscleGroup = reader.readString(offsets[3]);
  object.peakFatiguePercent = reader.readDouble(offsets[4]);
  object.side = reader.readStringOrNull(offsets[5]);
  object.snapshots =
      reader.readObjectList<FatigueSnapshot>(
        offsets[6],
        FatigueSnapshotSchema.deserialize,
        allOffsets,
        FatigueSnapshot(),
      ) ??
      [];
  object.subGroup = reader.readStringOrNull(offsets[7]);
  object.workoutDate = reader.readDateTime(offsets[8]);
  return object;
}

P _fatigueStateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<FatigueSnapshot>(
                offset,
                FatigueSnapshotSchema.deserialize,
                allOffsets,
                FatigueSnapshot(),
              ) ??
              [])
          as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fatigueStateGetId(FatigueState object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fatigueStateGetLinks(FatigueState object) {
  return [];
}

void _fatigueStateAttach(
  IsarCollection<dynamic> col,
  Id id,
  FatigueState object,
) {
  object.id = id;
}

extension FatigueStateQueryWhereSort
    on QueryBuilder<FatigueState, FatigueState, QWhere> {
  QueryBuilder<FatigueState, FatigueState, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhere> anyWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'workoutDate'),
      );
    });
  }
}

extension FatigueStateQueryWhere
    on QueryBuilder<FatigueState, FatigueState, QWhereClause> {
  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause> idBetween(
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

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  workoutDateEqualTo(DateTime workoutDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'workoutDate',
          value: [workoutDate],
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  workoutDateNotEqualTo(DateTime workoutDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'workoutDate',
                lower: [],
                upper: [workoutDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'workoutDate',
                lower: [workoutDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'workoutDate',
                lower: [workoutDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'workoutDate',
                lower: [],
                upper: [workoutDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  workoutDateGreaterThan(DateTime workoutDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'workoutDate',
          lower: [workoutDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  workoutDateLessThan(DateTime workoutDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'workoutDate',
          lower: [],
          upper: [workoutDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  workoutDateBetween(
    DateTime lowerWorkoutDate,
    DateTime upperWorkoutDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'workoutDate',
          lower: [lowerWorkoutDate],
          includeLower: includeLower,
          upper: [upperWorkoutDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  compositeKeyEqualTo(String compositeKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'compositeKey',
          value: [compositeKey],
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterWhereClause>
  compositeKeyNotEqualTo(String compositeKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'compositeKey',
                lower: [],
                upper: [compositeKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'compositeKey',
                lower: [compositeKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'compositeKey',
                lower: [compositeKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'compositeKey',
                lower: [],
                upper: [compositeKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FatigueStateQueryFilter
    on QueryBuilder<FatigueState, FatigueState, QFilterCondition> {
  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'compositeKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'compositeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'compositeKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'compositeKey', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  compositeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'compositeKey', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  currentFatiguePercentEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currentFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  currentFatiguePercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  currentFatiguePercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  currentFatiguePercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentFatiguePercent',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  lastUpdateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdateTime', value: value),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  lastUpdateTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastUpdateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  lastUpdateTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastUpdateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  lastUpdateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastUpdateTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupGreaterThan(
    String value, {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupLessThan(
    String value, {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'muscleGroup', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  muscleGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'muscleGroup', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  peakFatiguePercentEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'peakFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  peakFatiguePercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'peakFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  peakFatiguePercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'peakFatiguePercent',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  peakFatiguePercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'peakFatiguePercent',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'side'),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  sideIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'side'),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  sideGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'side',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  sideStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'side',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition> sideMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'side',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  sideIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'side', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  sideIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'side', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'snapshots', length, true, length, true);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'snapshots', 0, true, 0, true);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'snapshots', 0, false, 999999, true);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'snapshots', 0, true, length, include);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'snapshots', length, include, 999999, true);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'snapshots',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'subGroup'),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'subGroup'),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupGreaterThan(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupLessThan(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupBetween(
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  subGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  workoutDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'workoutDate', value: value),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  workoutDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workoutDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  workoutDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workoutDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  workoutDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workoutDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FatigueStateQueryObject
    on QueryBuilder<FatigueState, FatigueState, QFilterCondition> {
  QueryBuilder<FatigueState, FatigueState, QAfterFilterCondition>
  snapshotsElement(FilterQuery<FatigueSnapshot> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'snapshots');
    });
  }
}

extension FatigueStateQueryLinks
    on QueryBuilder<FatigueState, FatigueState, QFilterCondition> {}

extension FatigueStateQuerySortBy
    on QueryBuilder<FatigueState, FatigueState, QSortBy> {
  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByCurrentFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFatiguePercent', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByCurrentFatiguePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFatiguePercent', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdateTime', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByLastUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdateTime', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByPeakFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peakFatiguePercent', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByPeakFatiguePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peakFatiguePercent', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortBySide() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'side', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortBySideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'side', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> sortByWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDate', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  sortByWorkoutDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDate', Sort.desc);
    });
  }
}

extension FatigueStateQuerySortThenBy
    on QueryBuilder<FatigueState, FatigueState, QSortThenBy> {
  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByCurrentFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFatiguePercent', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByCurrentFatiguePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFatiguePercent', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdateTime', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByLastUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdateTime', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByPeakFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peakFatiguePercent', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByPeakFatiguePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peakFatiguePercent', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenBySide() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'side', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenBySideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'side', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy> thenByWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDate', Sort.asc);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QAfterSortBy>
  thenByWorkoutDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDate', Sort.desc);
    });
  }
}

extension FatigueStateQueryWhereDistinct
    on QueryBuilder<FatigueState, FatigueState, QDistinct> {
  QueryBuilder<FatigueState, FatigueState, QDistinct> distinctByCompositeKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compositeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct>
  distinctByCurrentFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentFatiguePercent');
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct>
  distinctByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdateTime');
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct> distinctByMuscleGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct>
  distinctByPeakFatiguePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peakFatiguePercent');
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct> distinctBySide({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'side', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct> distinctBySubGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FatigueState, FatigueState, QDistinct> distinctByWorkoutDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutDate');
    });
  }
}

extension FatigueStateQueryProperty
    on QueryBuilder<FatigueState, FatigueState, QQueryProperty> {
  QueryBuilder<FatigueState, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FatigueState, String, QQueryOperations> compositeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compositeKey');
    });
  }

  QueryBuilder<FatigueState, double, QQueryOperations>
  currentFatiguePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentFatiguePercent');
    });
  }

  QueryBuilder<FatigueState, DateTime, QQueryOperations>
  lastUpdateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdateTime');
    });
  }

  QueryBuilder<FatigueState, String, QQueryOperations> muscleGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleGroup');
    });
  }

  QueryBuilder<FatigueState, double, QQueryOperations>
  peakFatiguePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peakFatiguePercent');
    });
  }

  QueryBuilder<FatigueState, String?, QQueryOperations> sideProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'side');
    });
  }

  QueryBuilder<FatigueState, List<FatigueSnapshot>, QQueryOperations>
  snapshotsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snapshots');
    });
  }

  QueryBuilder<FatigueState, String?, QQueryOperations> subGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subGroup');
    });
  }

  QueryBuilder<FatigueState, DateTime, QQueryOperations> workoutDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutDate');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FatigueSnapshotSchema = Schema(
  name: r'FatigueSnapshot',
  id: 1066123776215740105,
  properties: {
    r'benchPosition': PropertySchema(
      id: 0,
      name: r'benchPosition',
      type: IsarType.long,
    ),
    r'cablePosition': PropertySchema(
      id: 1,
      name: r'cablePosition',
      type: IsarType.long,
    ),
    r'performanceDrop': PropertySchema(
      id: 2,
      name: r'performanceDrop',
      type: IsarType.double,
    ),
    r'reps': PropertySchema(id: 3, name: r'reps', type: IsarType.long),
    r'restSeconds': PropertySchema(
      id: 4,
      name: r'restSeconds',
      type: IsarType.long,
    ),
    r'setNumber': PropertySchema(
      id: 5,
      name: r'setNumber',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'weight': PropertySchema(id: 7, name: r'weight', type: IsarType.double),
  },
  estimateSize: _fatigueSnapshotEstimateSize,
  serialize: _fatigueSnapshotSerialize,
  deserialize: _fatigueSnapshotDeserialize,
  deserializeProp: _fatigueSnapshotDeserializeProp,
);

int _fatigueSnapshotEstimateSize(
  FatigueSnapshot object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _fatigueSnapshotSerialize(
  FatigueSnapshot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.benchPosition);
  writer.writeLong(offsets[1], object.cablePosition);
  writer.writeDouble(offsets[2], object.performanceDrop);
  writer.writeLong(offsets[3], object.reps);
  writer.writeLong(offsets[4], object.restSeconds);
  writer.writeLong(offsets[5], object.setNumber);
  writer.writeDateTime(offsets[6], object.timestamp);
  writer.writeDouble(offsets[7], object.weight);
}

FatigueSnapshot _fatigueSnapshotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FatigueSnapshot();
  object.benchPosition = reader.readLongOrNull(offsets[0]);
  object.cablePosition = reader.readLongOrNull(offsets[1]);
  object.performanceDrop = reader.readDouble(offsets[2]);
  object.reps = reader.readLong(offsets[3]);
  object.restSeconds = reader.readLong(offsets[4]);
  object.setNumber = reader.readLong(offsets[5]);
  object.timestamp = reader.readDateTime(offsets[6]);
  object.weight = reader.readDouble(offsets[7]);
  return object;
}

P _fatigueSnapshotDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FatigueSnapshotQueryFilter
    on QueryBuilder<FatigueSnapshot, FatigueSnapshot, QFilterCondition> {
  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'benchPosition'),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'benchPosition'),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'benchPosition', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'benchPosition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'benchPosition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  benchPositionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'benchPosition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cablePosition'),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cablePosition'),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cablePosition', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cablePosition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cablePosition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  cablePositionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cablePosition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  performanceDropEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'performanceDrop',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  performanceDropGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'performanceDrop',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  performanceDropLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'performanceDrop',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  performanceDropBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'performanceDrop',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  repsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reps', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  repsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'reps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  repsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'reps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  repsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'reps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  restSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restSeconds', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  restSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  restSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  restSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  setNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'setNumber', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  setNumberGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'setNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  setNumberLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'setNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  setNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'setNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  timestampGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  timestampLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  weightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FatigueSnapshot, FatigueSnapshot, QAfterFilterCondition>
  weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weight',
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

extension FatigueSnapshotQueryObject
    on QueryBuilder<FatigueSnapshot, FatigueSnapshot, QFilterCondition> {}
