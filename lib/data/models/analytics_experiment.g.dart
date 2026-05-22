// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_experiment.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnalyticsExperimentCollection on Isar {
  IsarCollection<AnalyticsExperiment> get analyticsExperiments =>
      this.collection();
}

const AnalyticsExperimentSchema = CollectionSchema(
  name: r'AnalyticsExperiment',
  id: -9191529690293941385,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'endDate': PropertySchema(
      id: 1,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'startDate': PropertySchema(
      id: 3,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'trackedMetricKeys': PropertySchema(
      id: 5,
      name: r'trackedMetricKeys',
      type: IsarType.stringList,
    ),
    r'variableChanged': PropertySchema(
      id: 6,
      name: r'variableChanged',
      type: IsarType.string,
    )
  },
  estimateSize: _analyticsExperimentEstimateSize,
  serialize: _analyticsExperimentSerialize,
  deserialize: _analyticsExperimentDeserialize,
  deserializeProp: _analyticsExperimentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _analyticsExperimentGetId,
  getLinks: _analyticsExperimentGetLinks,
  attach: _analyticsExperimentAttach,
  version: '3.1.0+1',
);

int _analyticsExperimentEstimateSize(
  AnalyticsExperiment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.trackedMetricKeys.length * 3;
  {
    for (var i = 0; i < object.trackedMetricKeys.length; i++) {
      final value = object.trackedMetricKeys[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.variableChanged.length * 3;
  return bytesCount;
}

void _analyticsExperimentSerialize(
  AnalyticsExperiment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeDateTime(offsets[1], object.endDate);
  writer.writeBool(offsets[2], object.isActive);
  writer.writeDateTime(offsets[3], object.startDate);
  writer.writeString(offsets[4], object.title);
  writer.writeStringList(offsets[5], object.trackedMetricKeys);
  writer.writeString(offsets[6], object.variableChanged);
}

AnalyticsExperiment _analyticsExperimentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnalyticsExperiment();
  object.description = reader.readString(offsets[0]);
  object.endDate = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.isActive = reader.readBool(offsets[2]);
  object.startDate = reader.readDateTime(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.trackedMetricKeys = reader.readStringList(offsets[5]) ?? [];
  object.variableChanged = reader.readString(offsets[6]);
  return object;
}

P _analyticsExperimentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _analyticsExperimentGetId(AnalyticsExperiment object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _analyticsExperimentGetLinks(
    AnalyticsExperiment object) {
  return [];
}

void _analyticsExperimentAttach(
    IsarCollection<dynamic> col, Id id, AnalyticsExperiment object) {
  object.id = id;
}

extension AnalyticsExperimentQueryWhereSort
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QWhere> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnalyticsExperimentQueryWhere
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QWhereClause> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhereClause>
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

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterWhereClause>
      idBetween(
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

extension AnalyticsExperimentQueryFilter on QueryBuilder<AnalyticsExperiment,
    AnalyticsExperiment, QFilterCondition> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
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

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackedMetricKeys',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackedMetricKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackedMetricKeys',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackedMetricKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackedMetricKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      trackedMetricKeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trackedMetricKeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'variableChanged',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'variableChanged',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'variableChanged',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variableChanged',
        value: '',
      ));
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterFilterCondition>
      variableChangedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'variableChanged',
        value: '',
      ));
    });
  }
}

extension AnalyticsExperimentQueryObject on QueryBuilder<AnalyticsExperiment,
    AnalyticsExperiment, QFilterCondition> {}

extension AnalyticsExperimentQueryLinks on QueryBuilder<AnalyticsExperiment,
    AnalyticsExperiment, QFilterCondition> {}

extension AnalyticsExperimentQuerySortBy
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QSortBy> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByVariableChanged() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variableChanged', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      sortByVariableChangedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variableChanged', Sort.desc);
    });
  }
}

extension AnalyticsExperimentQuerySortThenBy
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QSortThenBy> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByVariableChanged() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variableChanged', Sort.asc);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QAfterSortBy>
      thenByVariableChangedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variableChanged', Sort.desc);
    });
  }
}

extension AnalyticsExperimentQueryWhereDistinct
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct> {
  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByTrackedMetricKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackedMetricKeys');
    });
  }

  QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QDistinct>
      distinctByVariableChanged({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'variableChanged',
          caseSensitive: caseSensitive);
    });
  }
}

extension AnalyticsExperimentQueryProperty
    on QueryBuilder<AnalyticsExperiment, AnalyticsExperiment, QQueryProperty> {
  QueryBuilder<AnalyticsExperiment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnalyticsExperiment, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<AnalyticsExperiment, DateTime?, QQueryOperations>
      endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<AnalyticsExperiment, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<AnalyticsExperiment, DateTime, QQueryOperations>
      startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<AnalyticsExperiment, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<AnalyticsExperiment, List<String>, QQueryOperations>
      trackedMetricKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackedMetricKeys');
    });
  }

  QueryBuilder<AnalyticsExperiment, String, QQueryOperations>
      variableChangedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'variableChanged');
    });
  }
}
