// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_workout_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAutoWorkoutConfigCollection on Isar {
  IsarCollection<AutoWorkoutConfig> get autoWorkoutConfigs => this.collection();
}

const AutoWorkoutConfigSchema = CollectionSchema(
  name: r'AutoWorkoutConfig',
  id: -4885673672880670026,
  properties: {
    r'currentFolderIndex': PropertySchema(
      id: 0,
      name: r'currentFolderIndex',
      type: IsarType.long,
    ),
    r'currentRepeatCount': PropertySchema(
      id: 1,
      name: r'currentRepeatCount',
      type: IsarType.long,
    ),
    r'currentWorkoutIndex': PropertySchema(
      id: 2,
      name: r'currentWorkoutIndex',
      type: IsarType.long,
    ),
    r'expandedFolderIds': PropertySchema(
      id: 3,
      name: r'expandedFolderIds',
      type: IsarType.longList,
    ),
    r'folders': PropertySchema(
      id: 4,
      name: r'folders',
      type: IsarType.objectList,
      target: r'AutoFolderConfig',
    ),
    r'multipleFoldersEnabled': PropertySchema(
      id: 5,
      name: r'multipleFoldersEnabled',
      type: IsarType.bool,
    ),
  },
  estimateSize: _autoWorkoutConfigEstimateSize,
  serialize: _autoWorkoutConfigSerialize,
  deserialize: _autoWorkoutConfigDeserialize,
  deserializeProp: _autoWorkoutConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AutoFolderConfig': AutoFolderConfigSchema},
  getId: _autoWorkoutConfigGetId,
  getLinks: _autoWorkoutConfigGetLinks,
  attach: _autoWorkoutConfigAttach,
  version: '3.1.0+1',
);

int _autoWorkoutConfigEstimateSize(
  AutoWorkoutConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.expandedFolderIds.length * 8;
  bytesCount += 3 + object.folders.length * 3;
  {
    final offsets = allOffsets[AutoFolderConfig]!;
    for (var i = 0; i < object.folders.length; i++) {
      final value = object.folders[i];
      bytesCount += AutoFolderConfigSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _autoWorkoutConfigSerialize(
  AutoWorkoutConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentFolderIndex);
  writer.writeLong(offsets[1], object.currentRepeatCount);
  writer.writeLong(offsets[2], object.currentWorkoutIndex);
  writer.writeLongList(offsets[3], object.expandedFolderIds);
  writer.writeObjectList<AutoFolderConfig>(
    offsets[4],
    allOffsets,
    AutoFolderConfigSchema.serialize,
    object.folders,
  );
  writer.writeBool(offsets[5], object.multipleFoldersEnabled);
}

AutoWorkoutConfig _autoWorkoutConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AutoWorkoutConfig();
  object.currentFolderIndex = reader.readLong(offsets[0]);
  object.currentRepeatCount = reader.readLong(offsets[1]);
  object.currentWorkoutIndex = reader.readLong(offsets[2]);
  object.expandedFolderIds = reader.readLongList(offsets[3]) ?? [];
  object.folders =
      reader.readObjectList<AutoFolderConfig>(
        offsets[4],
        AutoFolderConfigSchema.deserialize,
        allOffsets,
        AutoFolderConfig(),
      ) ??
      [];
  object.id = id;
  object.multipleFoldersEnabled = reader.readBool(offsets[5]);
  return object;
}

P _autoWorkoutConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    case 4:
      return (reader.readObjectList<AutoFolderConfig>(
                offset,
                AutoFolderConfigSchema.deserialize,
                allOffsets,
                AutoFolderConfig(),
              ) ??
              [])
          as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _autoWorkoutConfigGetId(AutoWorkoutConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _autoWorkoutConfigGetLinks(
  AutoWorkoutConfig object,
) {
  return [];
}

void _autoWorkoutConfigAttach(
  IsarCollection<dynamic> col,
  Id id,
  AutoWorkoutConfig object,
) {
  object.id = id;
}

extension AutoWorkoutConfigQueryWhereSort
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QWhere> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AutoWorkoutConfigQueryWhere
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QWhereClause> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhereClause>
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

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterWhereClause>
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

extension AutoWorkoutConfigQueryFilter
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QFilterCondition> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentFolderIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentFolderIndex', value: value),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentFolderIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentFolderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentFolderIndexLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentFolderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentFolderIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentFolderIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentRepeatCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentRepeatCount', value: value),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentRepeatCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentRepeatCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentRepeatCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentRepeatCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentRepeatCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentRepeatCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentWorkoutIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentWorkoutIndex', value: value),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentWorkoutIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentWorkoutIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentWorkoutIndexLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentWorkoutIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  currentWorkoutIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentWorkoutIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'expandedFolderIds', value: value),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'expandedFolderIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'expandedFolderIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'expandedFolderIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedFolderIds', length, true, length, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedFolderIds', 0, true, 0, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedFolderIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'expandedFolderIds', 0, true, length, include);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expandedFolderIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  expandedFolderIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expandedFolderIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'folders', length, true, length, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'folders', 0, true, 0, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'folders', 0, false, 999999, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'folders', 0, true, length, include);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'folders', length, include, 999999, true);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'folders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
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

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
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

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
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

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  multipleFoldersEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'multipleFoldersEnabled',
          value: value,
        ),
      );
    });
  }
}

extension AutoWorkoutConfigQueryObject
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QFilterCondition> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterFilterCondition>
  foldersElement(FilterQuery<AutoFolderConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'folders');
    });
  }
}

extension AutoWorkoutConfigQueryLinks
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QFilterCondition> {}

extension AutoWorkoutConfigQuerySortBy
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QSortBy> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentFolderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFolderIndex', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentFolderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFolderIndex', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentRepeatCount', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentRepeatCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentRepeatCount', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentWorkoutIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWorkoutIndex', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByCurrentWorkoutIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWorkoutIndex', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByMultipleFoldersEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multipleFoldersEnabled', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  sortByMultipleFoldersEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multipleFoldersEnabled', Sort.desc);
    });
  }
}

extension AutoWorkoutConfigQuerySortThenBy
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QSortThenBy> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentFolderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFolderIndex', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentFolderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentFolderIndex', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentRepeatCount', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentRepeatCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentRepeatCount', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentWorkoutIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWorkoutIndex', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByCurrentWorkoutIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWorkoutIndex', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByMultipleFoldersEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multipleFoldersEnabled', Sort.asc);
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QAfterSortBy>
  thenByMultipleFoldersEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multipleFoldersEnabled', Sort.desc);
    });
  }
}

extension AutoWorkoutConfigQueryWhereDistinct
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct> {
  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct>
  distinctByCurrentFolderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentFolderIndex');
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct>
  distinctByCurrentRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentRepeatCount');
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct>
  distinctByCurrentWorkoutIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentWorkoutIndex');
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct>
  distinctByExpandedFolderIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expandedFolderIds');
    });
  }

  QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QDistinct>
  distinctByMultipleFoldersEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'multipleFoldersEnabled');
    });
  }
}

extension AutoWorkoutConfigQueryProperty
    on QueryBuilder<AutoWorkoutConfig, AutoWorkoutConfig, QQueryProperty> {
  QueryBuilder<AutoWorkoutConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AutoWorkoutConfig, int, QQueryOperations>
  currentFolderIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentFolderIndex');
    });
  }

  QueryBuilder<AutoWorkoutConfig, int, QQueryOperations>
  currentRepeatCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentRepeatCount');
    });
  }

  QueryBuilder<AutoWorkoutConfig, int, QQueryOperations>
  currentWorkoutIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentWorkoutIndex');
    });
  }

  QueryBuilder<AutoWorkoutConfig, List<int>, QQueryOperations>
  expandedFolderIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expandedFolderIds');
    });
  }

  QueryBuilder<AutoWorkoutConfig, List<AutoFolderConfig>, QQueryOperations>
  foldersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folders');
    });
  }

  QueryBuilder<AutoWorkoutConfig, bool, QQueryOperations>
  multipleFoldersEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'multipleFoldersEnabled');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AutoFolderConfigSchema = Schema(
  name: r'AutoFolderConfig',
  id: -3713723201332809309,
  properties: {
    r'folderId': PropertySchema(id: 0, name: r'folderId', type: IsarType.long),
    r'folderName': PropertySchema(
      id: 1,
      name: r'folderName',
      type: IsarType.string,
    ),
    r'repeats': PropertySchema(id: 2, name: r'repeats', type: IsarType.long),
  },
  estimateSize: _autoFolderConfigEstimateSize,
  serialize: _autoFolderConfigSerialize,
  deserialize: _autoFolderConfigDeserialize,
  deserializeProp: _autoFolderConfigDeserializeProp,
);

int _autoFolderConfigEstimateSize(
  AutoFolderConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.folderName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _autoFolderConfigSerialize(
  AutoFolderConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.folderId);
  writer.writeString(offsets[1], object.folderName);
  writer.writeLong(offsets[2], object.repeats);
}

AutoFolderConfig _autoFolderConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AutoFolderConfig();
  object.folderId = reader.readLongOrNull(offsets[0]);
  object.folderName = reader.readStringOrNull(offsets[1]);
  object.repeats = reader.readLong(offsets[2]);
  return object;
}

P _autoFolderConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AutoFolderConfigQueryFilter
    on QueryBuilder<AutoFolderConfig, AutoFolderConfig, QFilterCondition> {
  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'folderId'),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'folderId'),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'folderId', value: value),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'folderId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'folderId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'folderId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'folderName'),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'folderName'),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'folderName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'folderName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'folderName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'folderName', value: ''),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  folderNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'folderName', value: ''),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  repeatsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repeats', value: value),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  repeatsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeats',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  repeatsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeats',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AutoFolderConfig, AutoFolderConfig, QAfterFilterCondition>
  repeatsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeats',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AutoFolderConfigQueryObject
    on QueryBuilder<AutoFolderConfig, AutoFolderConfig, QFilterCondition> {}
