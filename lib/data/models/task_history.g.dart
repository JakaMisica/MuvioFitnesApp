// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskHistoryCollection on Isar {
  IsarCollection<TaskHistory> get taskHistorys => this.collection();
}

const TaskHistorySchema = CollectionSchema(
  name: r'TaskHistory',
  id: -172266110336452280,
  properties: {
    r'metricType': PropertySchema(
      id: 0,
      name: r'metricType',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 1,
      name: r'notes',
      type: IsarType.string,
    ),
    r'numericValue': PropertySchema(
      id: 2,
      name: r'numericValue',
      type: IsarType.double,
    ),
    r'recordedDate': PropertySchema(
      id: 3,
      name: r'recordedDate',
      type: IsarType.dateTime,
    ),
    r'taskId': PropertySchema(
      id: 4,
      name: r'taskId',
      type: IsarType.long,
    ),
    r'textValue': PropertySchema(
      id: 5,
      name: r'textValue',
      type: IsarType.string,
    )
  },
  estimateSize: _taskHistoryEstimateSize,
  serialize: _taskHistorySerialize,
  deserialize: _taskHistoryDeserialize,
  deserializeProp: _taskHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'taskId': IndexSchema(
      id: -6391211041487498726,
      name: r'taskId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'taskId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'recordedDate': IndexSchema(
      id: 1486048683921086016,
      name: r'recordedDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'recordedDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _taskHistoryGetId,
  getLinks: _taskHistoryGetLinks,
  attach: _taskHistoryAttach,
  version: '3.1.0+1',
);

int _taskHistoryEstimateSize(
  TaskHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.metricType.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.textValue.length * 3;
  return bytesCount;
}

void _taskHistorySerialize(
  TaskHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.metricType);
  writer.writeString(offsets[1], object.notes);
  writer.writeDouble(offsets[2], object.numericValue);
  writer.writeDateTime(offsets[3], object.recordedDate);
  writer.writeLong(offsets[4], object.taskId);
  writer.writeString(offsets[5], object.textValue);
}

TaskHistory _taskHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskHistory(
    metricType: reader.readStringOrNull(offsets[0]) ?? '',
    notes: reader.readStringOrNull(offsets[1]) ?? '',
    numericValue: reader.readDoubleOrNull(offsets[2]) ?? 0.0,
    taskId: reader.readLongOrNull(offsets[4]) ?? 0,
    textValue: reader.readStringOrNull(offsets[5]) ?? '',
  );
  object.id = id;
  object.recordedDate = reader.readDateTime(offsets[3]);
  return object;
}

P _taskHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskHistoryGetId(TaskHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskHistoryGetLinks(TaskHistory object) {
  return [];
}

void _taskHistoryAttach(
    IsarCollection<dynamic> col, Id id, TaskHistory object) {
  object.id = id;
}

extension TaskHistoryQueryWhereSort
    on QueryBuilder<TaskHistory, TaskHistory, QWhere> {
  QueryBuilder<TaskHistory, TaskHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhere> anyTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'taskId'),
      );
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhere> anyRecordedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'recordedDate'),
      );
    });
  }
}

extension TaskHistoryQueryWhere
    on QueryBuilder<TaskHistory, TaskHistory, QWhereClause> {
  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> idBetween(
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

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> taskIdEqualTo(
      int taskId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskId',
        value: [taskId],
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> taskIdNotEqualTo(
      int taskId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> taskIdGreaterThan(
    int taskId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [taskId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> taskIdLessThan(
    int taskId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [],
        upper: [taskId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> taskIdBetween(
    int lowerTaskId,
    int upperTaskId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [lowerTaskId],
        includeLower: includeLower,
        upper: [upperTaskId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> recordedDateEqualTo(
      DateTime recordedDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recordedDate',
        value: [recordedDate],
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause>
      recordedDateNotEqualTo(DateTime recordedDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordedDate',
              lower: [],
              upper: [recordedDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordedDate',
              lower: [recordedDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordedDate',
              lower: [recordedDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordedDate',
              lower: [],
              upper: [recordedDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause>
      recordedDateGreaterThan(
    DateTime recordedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordedDate',
        lower: [recordedDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause>
      recordedDateLessThan(
    DateTime recordedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordedDate',
        lower: [],
        upper: [recordedDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterWhereClause> recordedDateBetween(
    DateTime lowerRecordedDate,
    DateTime upperRecordedDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordedDate',
        lower: [lowerRecordedDate],
        includeLower: includeLower,
        upper: [upperRecordedDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskHistoryQueryFilter
    on QueryBuilder<TaskHistory, TaskHistory, QFilterCondition> {
  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metricType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metricType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metricType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metricType',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      metricTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metricType',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      numericValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      numericValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      numericValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      numericValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numericValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      recordedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      recordedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      recordedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      recordedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> taskIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      taskIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> taskIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition> taskIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textValue',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterFilterCondition>
      textValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textValue',
        value: '',
      ));
    });
  }
}

extension TaskHistoryQueryObject
    on QueryBuilder<TaskHistory, TaskHistory, QFilterCondition> {}

extension TaskHistoryQueryLinks
    on QueryBuilder<TaskHistory, TaskHistory, QFilterCondition> {}

extension TaskHistoryQuerySortBy
    on QueryBuilder<TaskHistory, TaskHistory, QSortBy> {
  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByMetricType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricType', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByMetricTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricType', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy>
      sortByNumericValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByRecordedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedDate', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy>
      sortByRecordedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedDate', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByTextValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> sortByTextValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.desc);
    });
  }
}

extension TaskHistoryQuerySortThenBy
    on QueryBuilder<TaskHistory, TaskHistory, QSortThenBy> {
  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByMetricType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricType', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByMetricTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricType', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy>
      thenByNumericValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByRecordedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedDate', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy>
      thenByRecordedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedDate', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByTextValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.asc);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QAfterSortBy> thenByTextValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.desc);
    });
  }
}

extension TaskHistoryQueryWhereDistinct
    on QueryBuilder<TaskHistory, TaskHistory, QDistinct> {
  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByMetricType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metricType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numericValue');
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByRecordedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedDate');
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId');
    });
  }

  QueryBuilder<TaskHistory, TaskHistory, QDistinct> distinctByTextValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textValue', caseSensitive: caseSensitive);
    });
  }
}

extension TaskHistoryQueryProperty
    on QueryBuilder<TaskHistory, TaskHistory, QQueryProperty> {
  QueryBuilder<TaskHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskHistory, String, QQueryOperations> metricTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metricType');
    });
  }

  QueryBuilder<TaskHistory, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<TaskHistory, double, QQueryOperations> numericValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numericValue');
    });
  }

  QueryBuilder<TaskHistory, DateTime, QQueryOperations> recordedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedDate');
    });
  }

  QueryBuilder<TaskHistory, int, QQueryOperations> taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<TaskHistory, String, QQueryOperations> textValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textValue');
    });
  }
}
