// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_day.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutDayCollection on Isar {
  IsarCollection<WorkoutDay> get workoutDays => this.collection();
}

const WorkoutDaySchema = CollectionSchema(
  name: r'WorkoutDay',
  id: -473137167238769109,
  properties: {
    r'date': PropertySchema(id: 0, name: r'date', type: IsarType.dateTime),
    r'distanceMeters': PropertySchema(
      id: 1,
      name: r'distanceMeters',
      type: IsarType.double,
    ),
    r'isRestDay': PropertySchema(
      id: 2,
      name: r'isRestDay',
      type: IsarType.bool,
    ),
    r'steps': PropertySchema(id: 3, name: r'steps', type: IsarType.long),
    r'templateId': PropertySchema(
      id: 4,
      name: r'templateId',
      type: IsarType.long,
    ),
  },
  estimateSize: _workoutDayEstimateSize,
  serialize: _workoutDaySerialize,
  deserialize: _workoutDayDeserialize,
  deserializeProp: _workoutDayDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'exercises': LinkSchema(
      id: -5460152314316938935,
      name: r'exercises',
      target: r'WorkoutExerciseLog',
      single: false,
    ),
  },
  embeddedSchemas: {},
  getId: _workoutDayGetId,
  getLinks: _workoutDayGetLinks,
  attach: _workoutDayAttach,
  version: '3.1.0+1',
);

int _workoutDayEstimateSize(
  WorkoutDay object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _workoutDaySerialize(
  WorkoutDay object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.distanceMeters);
  writer.writeBool(offsets[2], object.isRestDay);
  writer.writeLong(offsets[3], object.steps);
  writer.writeLong(offsets[4], object.templateId);
}

WorkoutDay _workoutDayDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutDay();
  object.date = reader.readDateTime(offsets[0]);
  object.distanceMeters = reader.readDouble(offsets[1]);
  object.id = id;
  object.isRestDay = reader.readBool(offsets[2]);
  object.steps = reader.readLong(offsets[3]);
  object.templateId = reader.readLongOrNull(offsets[4]);
  return object;
}

P _workoutDayDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutDayGetId(WorkoutDay object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutDayGetLinks(WorkoutDay object) {
  return [object.exercises];
}

void _workoutDayAttach(IsarCollection<dynamic> col, Id id, WorkoutDay object) {
  object.id = id;
  object.exercises.attach(
    col,
    col.isar.collection<WorkoutExerciseLog>(),
    r'exercises',
    id,
  );
}

extension WorkoutDayByIndex on IsarCollection<WorkoutDay> {
  Future<WorkoutDay?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  WorkoutDay? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<WorkoutDay?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<WorkoutDay?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(WorkoutDay object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(WorkoutDay object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<WorkoutDay> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<WorkoutDay> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension WorkoutDayQueryWhereSort
    on QueryBuilder<WorkoutDay, WorkoutDay, QWhere> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension WorkoutDayQueryWhere
    on QueryBuilder<WorkoutDay, WorkoutDay, QWhereClause> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> idBetween(
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

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> dateEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> dateNotEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [date],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [],
          upper: [date],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [lowerDate],
          includeLower: includeLower,
          upper: [upperDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkoutDayQueryFilter
    on QueryBuilder<WorkoutDay, WorkoutDay, QFilterCondition> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  distanceMetersEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distanceMeters',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  distanceMetersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distanceMeters',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  distanceMetersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distanceMeters',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  distanceMetersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distanceMeters',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> isRestDayEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isRestDay', value: value),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> stepsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> stepsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'steps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> stepsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'steps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> stepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'steps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  templateIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'templateId'),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  templateIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'templateId'),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> templateIdEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'templateId', value: value),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  templateIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'templateId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  templateIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'templateId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> templateIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'templateId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkoutDayQueryObject
    on QueryBuilder<WorkoutDay, WorkoutDay, QFilterCondition> {}

extension WorkoutDayQueryLinks
    on QueryBuilder<WorkoutDay, WorkoutDay, QFilterCondition> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition> exercises(
    FilterQuery<WorkoutExerciseLog> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exercises');
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', length, true, length, true);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, false, 999999, true);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, true, length, include);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', length, include, 999999, true);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterFilterCondition>
  exercisesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'exercises',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WorkoutDayQuerySortBy
    on QueryBuilder<WorkoutDay, WorkoutDay, QSortBy> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy>
  sortByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByIsRestDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByTemplateId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'templateId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> sortByTemplateIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'templateId', Sort.desc);
    });
  }
}

extension WorkoutDayQuerySortThenBy
    on QueryBuilder<WorkoutDay, WorkoutDay, QSortThenBy> {
  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy>
  thenByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByIsRestDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByTemplateId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'templateId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QAfterSortBy> thenByTemplateIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'templateId', Sort.desc);
    });
  }
}

extension WorkoutDayQueryWhereDistinct
    on QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> {
  QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> distinctByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceMeters');
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> distinctByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRestDay');
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<WorkoutDay, WorkoutDay, QDistinct> distinctByTemplateId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'templateId');
    });
  }
}

extension WorkoutDayQueryProperty
    on QueryBuilder<WorkoutDay, WorkoutDay, QQueryProperty> {
  QueryBuilder<WorkoutDay, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutDay, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<WorkoutDay, double, QQueryOperations> distanceMetersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceMeters');
    });
  }

  QueryBuilder<WorkoutDay, bool, QQueryOperations> isRestDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRestDay');
    });
  }

  QueryBuilder<WorkoutDay, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<WorkoutDay, int?, QQueryOperations> templateIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'templateId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutExerciseLogCollection on Isar {
  IsarCollection<WorkoutExerciseLog> get workoutExerciseLogs =>
      this.collection();
}

const WorkoutExerciseLogSchema = CollectionSchema(
  name: r'WorkoutExerciseLog',
  id: 2877660473864446597,
  properties: {
    r'notes': PropertySchema(id: 0, name: r'notes', type: IsarType.string),
    r'orderIndex': PropertySchema(
      id: 1,
      name: r'orderIndex',
      type: IsarType.long,
    ),
    r'sets': PropertySchema(
      id: 2,
      name: r'sets',
      type: IsarType.objectList,
      target: r'WorkoutSet',
    ),
  },
  estimateSize: _workoutExerciseLogEstimateSize,
  serialize: _workoutExerciseLogSerialize,
  deserialize: _workoutExerciseLogDeserialize,
  deserializeProp: _workoutExerciseLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'exercise': LinkSchema(
      id: -9100795514625848219,
      name: r'exercise',
      target: r'Exercise',
      single: true,
    ),
  },
  embeddedSchemas: {
    r'WorkoutSet': WorkoutSetSchema,
    r'DropSetItem': DropSetItemSchema,
  },
  getId: _workoutExerciseLogGetId,
  getLinks: _workoutExerciseLogGetLinks,
  attach: _workoutExerciseLogAttach,
  version: '3.1.0+1',
);

int _workoutExerciseLogEstimateSize(
  WorkoutExerciseLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.sets.length * 3;
  {
    final offsets = allOffsets[WorkoutSet]!;
    for (var i = 0; i < object.sets.length; i++) {
      final value = object.sets[i];
      bytesCount += WorkoutSetSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _workoutExerciseLogSerialize(
  WorkoutExerciseLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.notes);
  writer.writeLong(offsets[1], object.orderIndex);
  writer.writeObjectList<WorkoutSet>(
    offsets[2],
    allOffsets,
    WorkoutSetSchema.serialize,
    object.sets,
  );
}

WorkoutExerciseLog _workoutExerciseLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutExerciseLog();
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[0]);
  object.orderIndex = reader.readLong(offsets[1]);
  object.sets =
      reader.readObjectList<WorkoutSet>(
        offsets[2],
        WorkoutSetSchema.deserialize,
        allOffsets,
        WorkoutSet(),
      ) ??
      [];
  return object;
}

P _workoutExerciseLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectList<WorkoutSet>(
                offset,
                WorkoutSetSchema.deserialize,
                allOffsets,
                WorkoutSet(),
              ) ??
              [])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutExerciseLogGetId(WorkoutExerciseLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutExerciseLogGetLinks(
  WorkoutExerciseLog object,
) {
  return [object.exercise];
}

void _workoutExerciseLogAttach(
  IsarCollection<dynamic> col,
  Id id,
  WorkoutExerciseLog object,
) {
  object.id = id;
  object.exercise.attach(col, col.isar.collection<Exercise>(), r'exercise', id);
}

extension WorkoutExerciseLogQueryWhereSort
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QWhere> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutExerciseLogQueryWhere
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QWhereClause> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterWhereClause>
  idBetween(
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

extension WorkoutExerciseLogQueryFilter
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QFilterCondition> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesGreaterThan(
    String? value, {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesLessThan(
    String? value, {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  orderIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orderIndex', value: value),
      );
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  orderIndexGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  orderIndexLessThan(int value, {bool include = false}) {
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  orderIndexBetween(
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

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', length, true, length, true);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, false, 999999, true);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, true, length, include);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', length, include, 999999, true);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WorkoutExerciseLogQueryObject
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QFilterCondition> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  setsElement(FilterQuery<WorkoutSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sets');
    });
  }
}

extension WorkoutExerciseLogQueryLinks
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QFilterCondition> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  exercise(FilterQuery<Exercise> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exercise');
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterFilterCondition>
  exerciseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercise', 0, true, 0, true);
    });
  }
}

extension WorkoutExerciseLogQuerySortBy
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QSortBy> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  sortByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  sortByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }
}

extension WorkoutExerciseLogQuerySortThenBy
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QSortThenBy> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QAfterSortBy>
  thenByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }
}

extension WorkoutExerciseLogQueryWhereDistinct
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QDistinct> {
  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QDistinct>
  distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QDistinct>
  distinctByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderIndex');
    });
  }
}

extension WorkoutExerciseLogQueryProperty
    on QueryBuilder<WorkoutExerciseLog, WorkoutExerciseLog, QQueryProperty> {
  QueryBuilder<WorkoutExerciseLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutExerciseLog, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<WorkoutExerciseLog, int, QQueryOperations> orderIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderIndex');
    });
  }

  QueryBuilder<WorkoutExerciseLog, List<WorkoutSet>, QQueryOperations>
  setsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sets');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DropSetItemSchema = Schema(
  name: r'DropSetItem',
  id: 2120846225982662141,
  properties: {
    r'isCompleted': PropertySchema(
      id: 0,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'pointsEarned': PropertySchema(
      id: 1,
      name: r'pointsEarned',
      type: IsarType.bool,
    ),
    r'reps': PropertySchema(id: 2, name: r'reps', type: IsarType.long),
    r'tutSeconds': PropertySchema(
      id: 3,
      name: r'tutSeconds',
      type: IsarType.long,
    ),
    r'weight': PropertySchema(id: 4, name: r'weight', type: IsarType.double),
  },
  estimateSize: _dropSetItemEstimateSize,
  serialize: _dropSetItemSerialize,
  deserialize: _dropSetItemDeserialize,
  deserializeProp: _dropSetItemDeserializeProp,
);

int _dropSetItemEstimateSize(
  DropSetItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dropSetItemSerialize(
  DropSetItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCompleted);
  writer.writeBool(offsets[1], object.pointsEarned);
  writer.writeLong(offsets[2], object.reps);
  writer.writeLong(offsets[3], object.tutSeconds);
  writer.writeDouble(offsets[4], object.weight);
}

DropSetItem _dropSetItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DropSetItem();
  object.isCompleted = reader.readBool(offsets[0]);
  object.pointsEarned = reader.readBool(offsets[1]);
  object.reps = reader.readLongOrNull(offsets[2]);
  object.tutSeconds = reader.readLongOrNull(offsets[3]);
  object.weight = reader.readDoubleOrNull(offsets[4]);
  return object;
}

P _dropSetItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DropSetItemQueryFilter
    on QueryBuilder<DropSetItem, DropSetItem, QFilterCondition> {
  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCompleted', value: value),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  pointsEarnedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pointsEarned', value: value),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> repsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  repsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> repsEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reps', value: value),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> repsGreaterThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> repsLessThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> repsBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tutSeconds'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tutSeconds'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tutSeconds', value: value),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tutSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tutSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  tutSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tutSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> weightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition>
  weightGreaterThan(
    double? value, {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> weightLessThan(
    double? value, {
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

  QueryBuilder<DropSetItem, DropSetItem, QAfterFilterCondition> weightBetween(
    double? lower,
    double? upper, {
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

extension DropSetItemQueryObject
    on QueryBuilder<DropSetItem, DropSetItem, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WorkoutSetSchema = Schema(
  name: r'WorkoutSet',
  id: -5974587475565306185,
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
    r'calories': PropertySchema(
      id: 2,
      name: r'calories',
      type: IsarType.double,
    ),
    r'concentricSeconds': PropertySchema(
      id: 3,
      name: r'concentricSeconds',
      type: IsarType.long,
    ),
    r'distance': PropertySchema(
      id: 4,
      name: r'distance',
      type: IsarType.double,
    ),
    r'dropSetItems': PropertySchema(
      id: 5,
      name: r'dropSetItems',
      type: IsarType.objectList,
      target: r'DropSetItem',
    ),
    r'eccentricSeconds': PropertySchema(
      id: 6,
      name: r'eccentricSeconds',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 7,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isDropSet': PropertySchema(
      id: 8,
      name: r'isDropSet',
      type: IsarType.bool,
    ),
    r'isFailure': PropertySchema(
      id: 9,
      name: r'isFailure',
      type: IsarType.bool,
    ),
    r'isPr': PropertySchema(id: 10, name: r'isPr', type: IsarType.bool),
    r'isRestTimerEnabled': PropertySchema(
      id: 11,
      name: r'isRestTimerEnabled',
      type: IsarType.bool,
    ),
    r'isTodayPr': PropertySchema(
      id: 12,
      name: r'isTodayPr',
      type: IsarType.bool,
    ),
    r'isTutEnabled': PropertySchema(
      id: 13,
      name: r'isTutEnabled',
      type: IsarType.bool,
    ),
    r'isWarmUp': PropertySchema(id: 14, name: r'isWarmUp', type: IsarType.bool),
    r'isometricSeconds': PropertySchema(
      id: 15,
      name: r'isometricSeconds',
      type: IsarType.long,
    ),
    r'myoPauseSeconds': PropertySchema(
      id: 16,
      name: r'myoPauseSeconds',
      type: IsarType.long,
    ),
    r'myoReps': PropertySchema(id: 17, name: r'myoReps', type: IsarType.long),
    r'partialReps': PropertySchema(
      id: 18,
      name: r'partialReps',
      type: IsarType.long,
    ),
    r'pointsEarned': PropertySchema(
      id: 19,
      name: r'pointsEarned',
      type: IsarType.bool,
    ),
    r'reps': PropertySchema(id: 20, name: r'reps', type: IsarType.long),
    r'restDuration': PropertySchema(
      id: 21,
      name: r'restDuration',
      type: IsarType.long,
    ),
    r'rir': PropertySchema(id: 22, name: r'rir', type: IsarType.long),
    r'side': PropertySchema(id: 23, name: r'side', type: IsarType.string),
    r'speed': PropertySchema(id: 24, name: r'speed', type: IsarType.double),
    r'spotReps': PropertySchema(id: 25, name: r'spotReps', type: IsarType.long),
    r'timeCompleted': PropertySchema(
      id: 26,
      name: r'timeCompleted',
      type: IsarType.dateTime,
    ),
    r'tutPrepSeconds': PropertySchema(
      id: 27,
      name: r'tutPrepSeconds',
      type: IsarType.long,
    ),
    r'tutSeconds': PropertySchema(
      id: 28,
      name: r'tutSeconds',
      type: IsarType.long,
    ),
    r'weight': PropertySchema(id: 29, name: r'weight', type: IsarType.double),
  },
  estimateSize: _workoutSetEstimateSize,
  serialize: _workoutSetSerialize,
  deserialize: _workoutSetDeserialize,
  deserializeProp: _workoutSetDeserializeProp,
);

int _workoutSetEstimateSize(
  WorkoutSet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dropSetItems.length * 3;
  {
    final offsets = allOffsets[DropSetItem]!;
    for (var i = 0; i < object.dropSetItems.length; i++) {
      final value = object.dropSetItems[i];
      bytesCount += DropSetItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.side;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _workoutSetSerialize(
  WorkoutSet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.benchPosition);
  writer.writeLong(offsets[1], object.cablePosition);
  writer.writeDouble(offsets[2], object.calories);
  writer.writeLong(offsets[3], object.concentricSeconds);
  writer.writeDouble(offsets[4], object.distance);
  writer.writeObjectList<DropSetItem>(
    offsets[5],
    allOffsets,
    DropSetItemSchema.serialize,
    object.dropSetItems,
  );
  writer.writeLong(offsets[6], object.eccentricSeconds);
  writer.writeBool(offsets[7], object.isCompleted);
  writer.writeBool(offsets[8], object.isDropSet);
  writer.writeBool(offsets[9], object.isFailure);
  writer.writeBool(offsets[10], object.isPr);
  writer.writeBool(offsets[11], object.isRestTimerEnabled);
  writer.writeBool(offsets[12], object.isTodayPr);
  writer.writeBool(offsets[13], object.isTutEnabled);
  writer.writeBool(offsets[14], object.isWarmUp);
  writer.writeLong(offsets[15], object.isometricSeconds);
  writer.writeLong(offsets[16], object.myoPauseSeconds);
  writer.writeLong(offsets[17], object.myoReps);
  writer.writeLong(offsets[18], object.partialReps);
  writer.writeBool(offsets[19], object.pointsEarned);
  writer.writeLong(offsets[20], object.reps);
  writer.writeLong(offsets[21], object.restDuration);
  writer.writeLong(offsets[22], object.rir);
  writer.writeString(offsets[23], object.side);
  writer.writeDouble(offsets[24], object.speed);
  writer.writeLong(offsets[25], object.spotReps);
  writer.writeDateTime(offsets[26], object.timeCompleted);
  writer.writeLong(offsets[27], object.tutPrepSeconds);
  writer.writeLong(offsets[28], object.tutSeconds);
  writer.writeDouble(offsets[29], object.weight);
}

WorkoutSet _workoutSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutSet();
  object.benchPosition = reader.readLongOrNull(offsets[0]);
  object.cablePosition = reader.readLongOrNull(offsets[1]);
  object.calories = reader.readDoubleOrNull(offsets[2]);
  object.concentricSeconds = reader.readLongOrNull(offsets[3]);
  object.distance = reader.readDoubleOrNull(offsets[4]);
  object.dropSetItems =
      reader.readObjectList<DropSetItem>(
        offsets[5],
        DropSetItemSchema.deserialize,
        allOffsets,
        DropSetItem(),
      ) ??
      [];
  object.eccentricSeconds = reader.readLongOrNull(offsets[6]);
  object.isCompleted = reader.readBool(offsets[7]);
  object.isDropSet = reader.readBool(offsets[8]);
  object.isFailure = reader.readBool(offsets[9]);
  object.isPr = reader.readBool(offsets[10]);
  object.isRestTimerEnabled = reader.readBool(offsets[11]);
  object.isTodayPr = reader.readBool(offsets[12]);
  object.isTutEnabled = reader.readBool(offsets[13]);
  object.isWarmUp = reader.readBool(offsets[14]);
  object.isometricSeconds = reader.readLongOrNull(offsets[15]);
  object.myoPauseSeconds = reader.readLongOrNull(offsets[16]);
  object.myoReps = reader.readLongOrNull(offsets[17]);
  object.partialReps = reader.readLongOrNull(offsets[18]);
  object.pointsEarned = reader.readBool(offsets[19]);
  object.reps = reader.readLongOrNull(offsets[20]);
  object.restDuration = reader.readLongOrNull(offsets[21]);
  object.rir = reader.readLongOrNull(offsets[22]);
  object.side = reader.readStringOrNull(offsets[23]);
  object.speed = reader.readDoubleOrNull(offsets[24]);
  object.spotReps = reader.readLongOrNull(offsets[25]);
  object.timeCompleted = reader.readDateTimeOrNull(offsets[26]);
  object.tutPrepSeconds = reader.readLong(offsets[27]);
  object.tutSeconds = reader.readLongOrNull(offsets[28]);
  object.weight = reader.readDoubleOrNull(offsets[29]);
  return object;
}

P _workoutSetDeserializeProp<P>(
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<DropSetItem>(
                offset,
                DropSetItemSchema.deserialize,
                allOffsets,
                DropSetItem(),
              ) ??
              [])
          as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 27:
      return (reader.readLong(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension WorkoutSetQueryFilter
    on QueryBuilder<WorkoutSet, WorkoutSet, QFilterCondition> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  benchPositionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'benchPosition'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  benchPositionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'benchPosition'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  benchPositionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'benchPosition', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  cablePositionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cablePosition'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  cablePositionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cablePosition'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  cablePositionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cablePosition', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> caloriesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'calories'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  caloriesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'calories'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> caloriesEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'calories',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  caloriesGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'calories',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> caloriesLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'calories',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> caloriesBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'calories',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'concentricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'concentricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'concentricSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'concentricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'concentricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  concentricSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'concentricSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> distanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'distance'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  distanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'distance'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> distanceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distance',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  distanceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distance',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> distanceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distance',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> distanceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'dropSetItems', length, true, length, true);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'dropSetItems', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'dropSetItems', 0, false, 999999, true);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'dropSetItems', 0, true, length, include);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'dropSetItems', length, include, 999999, true);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dropSetItems',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'eccentricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'eccentricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'eccentricSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'eccentricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'eccentricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  eccentricSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'eccentricSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCompleted', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> isDropSetEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDropSet', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> isFailureEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isFailure', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> isPrEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPr', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isRestTimerEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isRestTimerEnabled', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> isTodayPrEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTodayPr', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isTutEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTutEnabled', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> isWarmUpEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isWarmUp', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'isometricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'isometricSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isometricSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isometricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isometricSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  isometricSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isometricSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'myoPauseSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'myoPauseSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'myoPauseSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'myoPauseSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'myoPauseSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoPauseSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'myoPauseSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> myoRepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'myoReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoRepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'myoReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> myoRepsEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'myoReps', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  myoRepsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'myoReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> myoRepsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'myoReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> myoRepsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'myoReps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'partialReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'partialReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'partialReps', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'partialReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'partialReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  partialRepsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'partialReps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  pointsEarnedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pointsEarned', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reps', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsGreaterThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsLessThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restDuration'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restDuration'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restDuration', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restDuration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restDuration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  restDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restDuration',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rir'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rir'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rir', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rir',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rir',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> rirBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rir',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'side'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'side'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideEqualTo(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideGreaterThan(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideLessThan(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideBetween(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideEndsWith(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideContains(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideMatches(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'side', value: ''),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> sideIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'side', value: ''),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'speed'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'speed'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'speed',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'speed',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'speed',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> speedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'speed',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> spotRepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spotReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  spotRepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spotReps'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> spotRepsEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spotReps', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  spotRepsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spotReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> spotRepsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spotReps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> spotRepsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spotReps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeCompleted'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeCompleted'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeCompleted', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeCompleted',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeCompleted',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  timeCompletedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeCompleted',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutPrepSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tutPrepSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutPrepSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tutPrepSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutPrepSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tutPrepSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutPrepSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tutPrepSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tutSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tutSeconds'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> tutSecondsEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tutSeconds', value: value),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutSecondsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tutSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  tutSecondsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tutSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> tutSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tutSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightGreaterThan(
    double? value, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightLessThan(
    double? value, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightBetween(
    double? lower,
    double? upper, {
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

extension WorkoutSetQueryObject
    on QueryBuilder<WorkoutSet, WorkoutSet, QFilterCondition> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
  dropSetItemsElement(FilterQuery<DropSetItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dropSetItems');
    });
  }
}
