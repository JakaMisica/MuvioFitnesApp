// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSleepSessionCollection on Isar {
  IsarCollection<SleepSession> get sleepSessions => this.collection();
}

const SleepSessionSchema = CollectionSchema(
  name: r'SleepSession',
  id: 1960440604736288964,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'events': PropertySchema(
      id: 2,
      name: r'events',
      type: IsarType.objectList,
      target: r'SleepEvent',
    ),
    r'qualityScore': PropertySchema(
      id: 3,
      name: r'qualityScore',
      type: IsarType.double,
    ),
    r'sensitivity': PropertySchema(
      id: 4,
      name: r'sensitivity',
      type: IsarType.double,
    ),
    r'smartAlarmEnd': PropertySchema(
      id: 5,
      name: r'smartAlarmEnd',
      type: IsarType.dateTime,
    ),
    r'smartAlarmStart': PropertySchema(
      id: 6,
      name: r'smartAlarmStart',
      type: IsarType.dateTime,
    ),
    r'stages': PropertySchema(
      id: 7,
      name: r'stages',
      type: IsarType.objectList,
      target: r'SleepStageData',
    ),
    r'startTime': PropertySchema(
      id: 8,
      name: r'startTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _sleepSessionEstimateSize,
  serialize: _sleepSessionSerialize,
  deserialize: _sleepSessionDeserialize,
  deserializeProp: _sleepSessionDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'SleepStageData': SleepStageDataSchema,
    r'SleepEvent': SleepEventSchema
  },
  getId: _sleepSessionGetId,
  getLinks: _sleepSessionGetLinks,
  attach: _sleepSessionAttach,
  version: '3.1.0+1',
);

int _sleepSessionEstimateSize(
  SleepSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.events.length * 3;
  {
    final offsets = allOffsets[SleepEvent]!;
    for (var i = 0; i < object.events.length; i++) {
      final value = object.events[i];
      bytesCount += SleepEventSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.stages.length * 3;
  {
    final offsets = allOffsets[SleepStageData]!;
    for (var i = 0; i < object.stages.length; i++) {
      final value = object.stages[i];
      bytesCount +=
          SleepStageDataSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _sleepSessionSerialize(
  SleepSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeObjectList<SleepEvent>(
    offsets[2],
    allOffsets,
    SleepEventSchema.serialize,
    object.events,
  );
  writer.writeDouble(offsets[3], object.qualityScore);
  writer.writeDouble(offsets[4], object.sensitivity);
  writer.writeDateTime(offsets[5], object.smartAlarmEnd);
  writer.writeDateTime(offsets[6], object.smartAlarmStart);
  writer.writeObjectList<SleepStageData>(
    offsets[7],
    allOffsets,
    SleepStageDataSchema.serialize,
    object.stages,
  );
  writer.writeDateTime(offsets[8], object.startTime);
}

SleepSession _sleepSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SleepSession();
  object.date = reader.readDateTime(offsets[0]);
  object.endTime = reader.readDateTimeOrNull(offsets[1]);
  object.events = reader.readObjectList<SleepEvent>(
        offsets[2],
        SleepEventSchema.deserialize,
        allOffsets,
        SleepEvent(),
      ) ??
      [];
  object.id = id;
  object.qualityScore = reader.readDouble(offsets[3]);
  object.sensitivity = reader.readDouble(offsets[4]);
  object.smartAlarmEnd = reader.readDateTimeOrNull(offsets[5]);
  object.smartAlarmStart = reader.readDateTimeOrNull(offsets[6]);
  object.stages = reader.readObjectList<SleepStageData>(
        offsets[7],
        SleepStageDataSchema.deserialize,
        allOffsets,
        SleepStageData(),
      ) ??
      [];
  object.startTime = reader.readDateTime(offsets[8]);
  return object;
}

P _sleepSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<SleepEvent>(
            offset,
            SleepEventSchema.deserialize,
            allOffsets,
            SleepEvent(),
          ) ??
          []) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readObjectList<SleepStageData>(
            offset,
            SleepStageDataSchema.deserialize,
            allOffsets,
            SleepStageData(),
          ) ??
          []) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sleepSessionGetId(SleepSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sleepSessionGetLinks(SleepSession object) {
  return [];
}

void _sleepSessionAttach(
    IsarCollection<dynamic> col, Id id, SleepSession object) {
  object.id = id;
}

extension SleepSessionQueryWhereSort
    on QueryBuilder<SleepSession, SleepSession, QWhere> {
  QueryBuilder<SleepSession, SleepSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension SleepSessionQueryWhere
    on QueryBuilder<SleepSession, SleepSession, QWhereClause> {
  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepSessionQueryFilter
    on QueryBuilder<SleepSession, SleepSession, QFilterCondition> {
  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      eventsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      qualityScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      qualityScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      qualityScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      qualityScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualityScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      sensitivityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      sensitivityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      sensitivityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      sensitivityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sensitivity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smartAlarmEnd',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smartAlarmEnd',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmEndBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smartAlarmEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smartAlarmStart',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smartAlarmStart',
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      smartAlarmStartBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smartAlarmStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      stagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition>
      startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepSessionQueryObject
    on QueryBuilder<SleepSession, SleepSession, QFilterCondition> {
  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> eventsElement(
      FilterQuery<SleepEvent> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'events');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterFilterCondition> stagesElement(
      FilterQuery<SleepStageData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'stages');
    });
  }
}

extension SleepSessionQueryLinks
    on QueryBuilder<SleepSession, SleepSession, QFilterCondition> {}

extension SleepSessionQuerySortBy
    on QueryBuilder<SleepSession, SleepSession, QSortBy> {
  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      sortByQualityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      sortBySensitivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      sortBySmartAlarmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      sortBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      sortBySmartAlarmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension SleepSessionQuerySortThenBy
    on QueryBuilder<SleepSession, SleepSession, QSortThenBy> {
  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      thenByQualityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      thenBySensitivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      thenBySmartAlarmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      thenBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy>
      thenBySmartAlarmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.desc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<SleepSession, SleepSession, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension SleepSessionQueryWhereDistinct
    on QueryBuilder<SleepSession, SleepSession, QDistinct> {
  QueryBuilder<SleepSession, SleepSession, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct> distinctByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityScore');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct> distinctBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensitivity');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct>
      distinctBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smartAlarmEnd');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct>
      distinctBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smartAlarmStart');
    });
  }

  QueryBuilder<SleepSession, SleepSession, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }
}

extension SleepSessionQueryProperty
    on QueryBuilder<SleepSession, SleepSession, QQueryProperty> {
  QueryBuilder<SleepSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SleepSession, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<SleepSession, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<SleepSession, List<SleepEvent>, QQueryOperations>
      eventsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'events');
    });
  }

  QueryBuilder<SleepSession, double, QQueryOperations> qualityScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityScore');
    });
  }

  QueryBuilder<SleepSession, double, QQueryOperations> sensitivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensitivity');
    });
  }

  QueryBuilder<SleepSession, DateTime?, QQueryOperations>
      smartAlarmEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smartAlarmEnd');
    });
  }

  QueryBuilder<SleepSession, DateTime?, QQueryOperations>
      smartAlarmStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smartAlarmStart');
    });
  }

  QueryBuilder<SleepSession, List<SleepStageData>, QQueryOperations>
      stagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stages');
    });
  }

  QueryBuilder<SleepSession, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSleepSettingsCollection on Isar {
  IsarCollection<SleepSettings> get sleepSettings => this.collection();
}

const SleepSettingsSchema = CollectionSchema(
  name: r'SleepSettings',
  id: -4347864824362360419,
  properties: {
    r'alarmSoundPath': PropertySchema(
      id: 0,
      name: r'alarmSoundPath',
      type: IsarType.string,
    ),
    r'autoTrackEnabled': PropertySchema(
      id: 1,
      name: r'autoTrackEnabled',
      type: IsarType.bool,
    ),
    r'daySchedules': PropertySchema(
      id: 2,
      name: r'daySchedules',
      type: IsarType.stringList,
    ),
    r'isSmartAlarmEnabled': PropertySchema(
      id: 3,
      name: r'isSmartAlarmEnabled',
      type: IsarType.bool,
    ),
    r'lastSnoozeDurationMinutes': PropertySchema(
      id: 4,
      name: r'lastSnoozeDurationMinutes',
      type: IsarType.long,
    ),
    r'smartAlarmEnd': PropertySchema(
      id: 5,
      name: r'smartAlarmEnd',
      type: IsarType.dateTime,
    ),
    r'smartAlarmStart': PropertySchema(
      id: 6,
      name: r'smartAlarmStart',
      type: IsarType.dateTime,
    ),
    r'smartAlarmWindowMinutes': PropertySchema(
      id: 7,
      name: r'smartAlarmWindowMinutes',
      type: IsarType.long,
    )
  },
  estimateSize: _sleepSettingsEstimateSize,
  serialize: _sleepSettingsSerialize,
  deserialize: _sleepSettingsDeserialize,
  deserializeProp: _sleepSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sleepSettingsGetId,
  getLinks: _sleepSettingsGetLinks,
  attach: _sleepSettingsAttach,
  version: '3.1.0+1',
);

int _sleepSettingsEstimateSize(
  SleepSettings object,
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
  bytesCount += 3 + object.daySchedules.length * 3;
  {
    for (var i = 0; i < object.daySchedules.length; i++) {
      final value = object.daySchedules[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _sleepSettingsSerialize(
  SleepSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alarmSoundPath);
  writer.writeBool(offsets[1], object.autoTrackEnabled);
  writer.writeStringList(offsets[2], object.daySchedules);
  writer.writeBool(offsets[3], object.isSmartAlarmEnabled);
  writer.writeLong(offsets[4], object.lastSnoozeDurationMinutes);
  writer.writeDateTime(offsets[5], object.smartAlarmEnd);
  writer.writeDateTime(offsets[6], object.smartAlarmStart);
  writer.writeLong(offsets[7], object.smartAlarmWindowMinutes);
}

SleepSettings _sleepSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SleepSettings();
  object.alarmSoundPath = reader.readStringOrNull(offsets[0]);
  object.autoTrackEnabled = reader.readBool(offsets[1]);
  object.daySchedules = reader.readStringList(offsets[2]) ?? [];
  object.id = id;
  object.isSmartAlarmEnabled = reader.readBool(offsets[3]);
  object.lastSnoozeDurationMinutes = reader.readLongOrNull(offsets[4]);
  object.smartAlarmEnd = reader.readDateTimeOrNull(offsets[5]);
  object.smartAlarmStart = reader.readDateTimeOrNull(offsets[6]);
  object.smartAlarmWindowMinutes = reader.readLong(offsets[7]);
  return object;
}

P _sleepSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sleepSettingsGetId(SleepSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sleepSettingsGetLinks(SleepSettings object) {
  return [];
}

void _sleepSettingsAttach(
    IsarCollection<dynamic> col, Id id, SleepSettings object) {
  object.id = id;
}

extension SleepSettingsQueryWhereSort
    on QueryBuilder<SleepSettings, SleepSettings, QWhere> {
  QueryBuilder<SleepSettings, SleepSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SleepSettingsQueryWhere
    on QueryBuilder<SleepSettings, SleepSettings, QWhereClause> {
  QueryBuilder<SleepSettings, SleepSettings, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SleepSettings, SleepSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepSettingsQueryFilter
    on QueryBuilder<SleepSettings, SleepSettings, QFilterCondition> {
  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alarmSoundPath',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alarmSoundPath',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmSoundPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmSoundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmSoundPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmSoundPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      alarmSoundPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmSoundPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      autoTrackEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoTrackEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daySchedules',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'daySchedules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'daySchedules',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daySchedules',
        value: '',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'daySchedules',
        value: '',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      daySchedulesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daySchedules',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      isSmartAlarmEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSmartAlarmEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSnoozeDurationMinutes',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSnoozeDurationMinutes',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSnoozeDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSnoozeDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSnoozeDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      lastSnoozeDurationMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSnoozeDurationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smartAlarmEnd',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smartAlarmEnd',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smartAlarmEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmEndBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smartAlarmEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smartAlarmStart',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smartAlarmStart',
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smartAlarmStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmStartBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smartAlarmStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmWindowMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smartAlarmWindowMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmWindowMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smartAlarmWindowMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmWindowMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smartAlarmWindowMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterFilterCondition>
      smartAlarmWindowMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smartAlarmWindowMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepSettingsQueryObject
    on QueryBuilder<SleepSettings, SleepSettings, QFilterCondition> {}

extension SleepSettingsQueryLinks
    on QueryBuilder<SleepSettings, SleepSettings, QFilterCondition> {}

extension SleepSettingsQuerySortBy
    on QueryBuilder<SleepSettings, SleepSettings, QSortBy> {
  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByAlarmSoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByAlarmSoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByAutoTrackEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoTrackEnabled', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByAutoTrackEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoTrackEnabled', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByIsSmartAlarmEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSmartAlarmEnabled', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByIsSmartAlarmEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSmartAlarmEnabled', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByLastSnoozeDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSnoozeDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortByLastSnoozeDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSnoozeDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmWindowMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmWindowMinutes', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      sortBySmartAlarmWindowMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmWindowMinutes', Sort.desc);
    });
  }
}

extension SleepSettingsQuerySortThenBy
    on QueryBuilder<SleepSettings, SleepSettings, QSortThenBy> {
  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByAlarmSoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByAlarmSoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSoundPath', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByAutoTrackEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoTrackEnabled', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByAutoTrackEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoTrackEnabled', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByIsSmartAlarmEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSmartAlarmEnabled', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByIsSmartAlarmEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSmartAlarmEnabled', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByLastSnoozeDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSnoozeDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenByLastSnoozeDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSnoozeDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmEnd', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmStart', Sort.desc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmWindowMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmWindowMinutes', Sort.asc);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QAfterSortBy>
      thenBySmartAlarmWindowMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smartAlarmWindowMinutes', Sort.desc);
    });
  }
}

extension SleepSettingsQueryWhereDistinct
    on QueryBuilder<SleepSettings, SleepSettings, QDistinct> {
  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctByAlarmSoundPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmSoundPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctByAutoTrackEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoTrackEnabled');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctByDaySchedules() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daySchedules');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctByIsSmartAlarmEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSmartAlarmEnabled');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctByLastSnoozeDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSnoozeDurationMinutes');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctBySmartAlarmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smartAlarmEnd');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctBySmartAlarmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smartAlarmStart');
    });
  }

  QueryBuilder<SleepSettings, SleepSettings, QDistinct>
      distinctBySmartAlarmWindowMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smartAlarmWindowMinutes');
    });
  }
}

extension SleepSettingsQueryProperty
    on QueryBuilder<SleepSettings, SleepSettings, QQueryProperty> {
  QueryBuilder<SleepSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SleepSettings, String?, QQueryOperations>
      alarmSoundPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmSoundPath');
    });
  }

  QueryBuilder<SleepSettings, bool, QQueryOperations>
      autoTrackEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoTrackEnabled');
    });
  }

  QueryBuilder<SleepSettings, List<String>, QQueryOperations>
      daySchedulesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daySchedules');
    });
  }

  QueryBuilder<SleepSettings, bool, QQueryOperations>
      isSmartAlarmEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSmartAlarmEnabled');
    });
  }

  QueryBuilder<SleepSettings, int?, QQueryOperations>
      lastSnoozeDurationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSnoozeDurationMinutes');
    });
  }

  QueryBuilder<SleepSettings, DateTime?, QQueryOperations>
      smartAlarmEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smartAlarmEnd');
    });
  }

  QueryBuilder<SleepSettings, DateTime?, QQueryOperations>
      smartAlarmStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smartAlarmStart');
    });
  }

  QueryBuilder<SleepSettings, int, QQueryOperations>
      smartAlarmWindowMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smartAlarmWindowMinutes');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SleepStageDataSchema = Schema(
  name: r'SleepStageData',
  id: 9144574884713924097,
  properties: {
    r'stage': PropertySchema(
      id: 0,
      name: r'stage',
      type: IsarType.byte,
      enumMap: _SleepStageDatastageEnumValueMap,
    ),
    r'timestamp': PropertySchema(
      id: 1,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _sleepStageDataEstimateSize,
  serialize: _sleepStageDataSerialize,
  deserialize: _sleepStageDataDeserialize,
  deserializeProp: _sleepStageDataDeserializeProp,
);

int _sleepStageDataEstimateSize(
  SleepStageData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sleepStageDataSerialize(
  SleepStageData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.stage.index);
  writer.writeDateTime(offsets[1], object.timestamp);
}

SleepStageData _sleepStageDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SleepStageData();
  object.stage =
      _SleepStageDatastageValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          SleepStage.awake;
  object.timestamp = reader.readDateTime(offsets[1]);
  return object;
}

P _sleepStageDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_SleepStageDatastageValueEnumMap[reader.readByteOrNull(offset)] ??
          SleepStage.awake) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SleepStageDatastageEnumValueMap = {
  'awake': 0,
  'light': 1,
  'deep': 2,
  'rem': 3,
};
const _SleepStageDatastageValueEnumMap = {
  0: SleepStage.awake,
  1: SleepStage.light,
  2: SleepStage.deep,
  3: SleepStage.rem,
};

extension SleepStageDataQueryFilter
    on QueryBuilder<SleepStageData, SleepStageData, QFilterCondition> {
  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      stageEqualTo(SleepStage value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stage',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      stageGreaterThan(
    SleepStage value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stage',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      stageLessThan(
    SleepStage value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stage',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      stageBetween(
    SleepStage lower,
    SleepStage upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepStageData, SleepStageData, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepStageDataQueryObject
    on QueryBuilder<SleepStageData, SleepStageData, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SleepEventSchema = Schema(
  name: r'SleepEvent',
  id: -8208767796087376204,
  properties: {
    r'confidence': PropertySchema(
      id: 0,
      name: r'confidence',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 1,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.byte,
      enumMap: _SleepEventtypeEnumValueMap,
    )
  },
  estimateSize: _sleepEventEstimateSize,
  serialize: _sleepEventSerialize,
  deserialize: _sleepEventDeserialize,
  deserializeProp: _sleepEventDeserializeProp,
);

int _sleepEventEstimateSize(
  SleepEvent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sleepEventSerialize(
  SleepEvent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.confidence);
  writer.writeDateTime(offsets[1], object.timestamp);
  writer.writeByte(offsets[2], object.type.index);
}

SleepEvent _sleepEventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SleepEvent();
  object.confidence = reader.readDouble(offsets[0]);
  object.timestamp = reader.readDateTime(offsets[1]);
  object.type =
      _SleepEventtypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          SleepEventType.snoring;
  return object;
}

P _sleepEventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (_SleepEventtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          SleepEventType.snoring) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SleepEventtypeEnumValueMap = {
  'snoring': 0,
  'breathing': 1,
  'movement': 2,
};
const _SleepEventtypeValueEnumMap = {
  0: SleepEventType.snoring,
  1: SleepEventType.breathing,
  2: SleepEventType.movement,
};

extension SleepEventQueryFilter
    on QueryBuilder<SleepEvent, SleepEvent, QFilterCondition> {
  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> confidenceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition>
      confidenceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition>
      confidenceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> confidenceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> typeEqualTo(
      SleepEventType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> typeGreaterThan(
    SleepEventType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> typeLessThan(
    SleepEventType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepEvent, SleepEvent, QAfterFilterCondition> typeBetween(
    SleepEventType lower,
    SleepEventType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepEventQueryObject
    on QueryBuilder<SleepEvent, SleepEvent, QFilterCondition> {}
