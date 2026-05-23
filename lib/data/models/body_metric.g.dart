// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_metric.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBodyMetricCollection on Isar {
  IsarCollection<BodyMetric> get bodyMetrics => this.collection();
}

const BodyMetricSchema = CollectionSchema(
  name: r'BodyMetric',
  id: 5683593080132234753,
  properties: {
    r'abdominalSkinfold': PropertySchema(
      id: 0,
      name: r'abdominalSkinfold',
      type: IsarType.double,
    ),
    r'bicepSkinfold': PropertySchema(
      id: 1,
      name: r'bicepSkinfold',
      type: IsarType.double,
    ),
    r'bodyFatMethod': PropertySchema(
      id: 2,
      name: r'bodyFatMethod',
      type: IsarType.long,
    ),
    r'bodyFatPercentage': PropertySchema(
      id: 3,
      name: r'bodyFatPercentage',
      type: IsarType.double,
    ),
    r'calfSkinfold': PropertySchema(
      id: 4,
      name: r'calfSkinfold',
      type: IsarType.double,
    ),
    r'chest': PropertySchema(id: 5, name: r'chest', type: IsarType.double),
    r'chestSkinfold': PropertySchema(
      id: 6,
      name: r'chestSkinfold',
      type: IsarType.double,
    ),
    r'date': PropertySchema(id: 7, name: r'date', type: IsarType.dateTime),
    r'estimatedFreeTestosterone': PropertySchema(
      id: 8,
      name: r'estimatedFreeTestosterone',
      type: IsarType.double,
    ),
    r'gripStrengthLeft': PropertySchema(
      id: 9,
      name: r'gripStrengthLeft',
      type: IsarType.double,
    ),
    r'gripStrengthRight': PropertySchema(
      id: 10,
      name: r'gripStrengthRight',
      type: IsarType.double,
    ),
    r'hips': PropertySchema(id: 11, name: r'hips', type: IsarType.double),
    r'labFreeTestosterone': PropertySchema(
      id: 12,
      name: r'labFreeTestosterone',
      type: IsarType.double,
    ),
    r'leftArm': PropertySchema(id: 13, name: r'leftArm', type: IsarType.double),
    r'leftCalf': PropertySchema(
      id: 14,
      name: r'leftCalf',
      type: IsarType.double,
    ),
    r'leftForearm': PropertySchema(
      id: 15,
      name: r'leftForearm',
      type: IsarType.double,
    ),
    r'leftThigh': PropertySchema(
      id: 16,
      name: r'leftThigh',
      type: IsarType.double,
    ),
    r'lowerBackSkinfold': PropertySchema(
      id: 17,
      name: r'lowerBackSkinfold',
      type: IsarType.double,
    ),
    r'midaxillarySkinfold': PropertySchema(
      id: 18,
      name: r'midaxillarySkinfold',
      type: IsarType.double,
    ),
    r'muscleMassGains': PropertySchema(
      id: 19,
      name: r'muscleMassGains',
      type: IsarType.double,
    ),
    r'neck': PropertySchema(id: 20, name: r'neck', type: IsarType.double),
    r'rightArm': PropertySchema(
      id: 21,
      name: r'rightArm',
      type: IsarType.double,
    ),
    r'rightCalf': PropertySchema(
      id: 22,
      name: r'rightCalf',
      type: IsarType.double,
    ),
    r'rightForearm': PropertySchema(
      id: 23,
      name: r'rightForearm',
      type: IsarType.double,
    ),
    r'rightThigh': PropertySchema(
      id: 24,
      name: r'rightThigh',
      type: IsarType.double,
    ),
    r'subscapularSkinfold': PropertySchema(
      id: 25,
      name: r'subscapularSkinfold',
      type: IsarType.double,
    ),
    r'suprailiacSkinfold': PropertySchema(
      id: 26,
      name: r'suprailiacSkinfold',
      type: IsarType.double,
    ),
    r'thighSkinfold': PropertySchema(
      id: 27,
      name: r'thighSkinfold',
      type: IsarType.double,
    ),
    r'tricepSkinfold': PropertySchema(
      id: 28,
      name: r'tricepSkinfold',
      type: IsarType.double,
    ),
    r'waist': PropertySchema(id: 29, name: r'waist', type: IsarType.double),
    r'weight': PropertySchema(id: 30, name: r'weight', type: IsarType.double),
  },
  estimateSize: _bodyMetricEstimateSize,
  serialize: _bodyMetricSerialize,
  deserialize: _bodyMetricDeserialize,
  deserializeProp: _bodyMetricDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _bodyMetricGetId,
  getLinks: _bodyMetricGetLinks,
  attach: _bodyMetricAttach,
  version: '3.1.0+1',
);

int _bodyMetricEstimateSize(
  BodyMetric object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _bodyMetricSerialize(
  BodyMetric object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.abdominalSkinfold);
  writer.writeDouble(offsets[1], object.bicepSkinfold);
  writer.writeLong(offsets[2], object.bodyFatMethod);
  writer.writeDouble(offsets[3], object.bodyFatPercentage);
  writer.writeDouble(offsets[4], object.calfSkinfold);
  writer.writeDouble(offsets[5], object.chest);
  writer.writeDouble(offsets[6], object.chestSkinfold);
  writer.writeDateTime(offsets[7], object.date);
  writer.writeDouble(offsets[8], object.estimatedFreeTestosterone);
  writer.writeDouble(offsets[9], object.gripStrengthLeft);
  writer.writeDouble(offsets[10], object.gripStrengthRight);
  writer.writeDouble(offsets[11], object.hips);
  writer.writeDouble(offsets[12], object.labFreeTestosterone);
  writer.writeDouble(offsets[13], object.leftArm);
  writer.writeDouble(offsets[14], object.leftCalf);
  writer.writeDouble(offsets[15], object.leftForearm);
  writer.writeDouble(offsets[16], object.leftThigh);
  writer.writeDouble(offsets[17], object.lowerBackSkinfold);
  writer.writeDouble(offsets[18], object.midaxillarySkinfold);
  writer.writeDouble(offsets[19], object.muscleMassGains);
  writer.writeDouble(offsets[20], object.neck);
  writer.writeDouble(offsets[21], object.rightArm);
  writer.writeDouble(offsets[22], object.rightCalf);
  writer.writeDouble(offsets[23], object.rightForearm);
  writer.writeDouble(offsets[24], object.rightThigh);
  writer.writeDouble(offsets[25], object.subscapularSkinfold);
  writer.writeDouble(offsets[26], object.suprailiacSkinfold);
  writer.writeDouble(offsets[27], object.thighSkinfold);
  writer.writeDouble(offsets[28], object.tricepSkinfold);
  writer.writeDouble(offsets[29], object.waist);
  writer.writeDouble(offsets[30], object.weight);
}

BodyMetric _bodyMetricDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BodyMetric(
    abdominalSkinfold: reader.readDoubleOrNull(offsets[0]),
    bicepSkinfold: reader.readDoubleOrNull(offsets[1]),
    bodyFatMethod: reader.readLongOrNull(offsets[2]),
    bodyFatPercentage: reader.readDoubleOrNull(offsets[3]),
    calfSkinfold: reader.readDoubleOrNull(offsets[4]),
    chest: reader.readDoubleOrNull(offsets[5]),
    chestSkinfold: reader.readDoubleOrNull(offsets[6]),
    estimatedFreeTestosterone: reader.readDoubleOrNull(offsets[8]),
    gripStrengthLeft: reader.readDoubleOrNull(offsets[9]),
    gripStrengthRight: reader.readDoubleOrNull(offsets[10]),
    hips: reader.readDoubleOrNull(offsets[11]),
    labFreeTestosterone: reader.readDoubleOrNull(offsets[12]),
    leftArm: reader.readDoubleOrNull(offsets[13]),
    leftCalf: reader.readDoubleOrNull(offsets[14]),
    leftForearm: reader.readDoubleOrNull(offsets[15]),
    leftThigh: reader.readDoubleOrNull(offsets[16]),
    lowerBackSkinfold: reader.readDoubleOrNull(offsets[17]),
    midaxillarySkinfold: reader.readDoubleOrNull(offsets[18]),
    muscleMassGains: reader.readDoubleOrNull(offsets[19]),
    neck: reader.readDoubleOrNull(offsets[20]),
    rightArm: reader.readDoubleOrNull(offsets[21]),
    rightCalf: reader.readDoubleOrNull(offsets[22]),
    rightForearm: reader.readDoubleOrNull(offsets[23]),
    rightThigh: reader.readDoubleOrNull(offsets[24]),
    subscapularSkinfold: reader.readDoubleOrNull(offsets[25]),
    suprailiacSkinfold: reader.readDoubleOrNull(offsets[26]),
    thighSkinfold: reader.readDoubleOrNull(offsets[27]),
    tricepSkinfold: reader.readDoubleOrNull(offsets[28]),
    waist: reader.readDoubleOrNull(offsets[29]),
    weight: reader.readDoubleOrNull(offsets[30]),
  );
  object.date = reader.readDateTime(offsets[7]);
  object.id = id;
  return object;
}

P _bodyMetricDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readDoubleOrNull(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readDoubleOrNull(offset)) as P;
    case 26:
      return (reader.readDoubleOrNull(offset)) as P;
    case 27:
      return (reader.readDoubleOrNull(offset)) as P;
    case 28:
      return (reader.readDoubleOrNull(offset)) as P;
    case 29:
      return (reader.readDoubleOrNull(offset)) as P;
    case 30:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bodyMetricGetId(BodyMetric object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bodyMetricGetLinks(BodyMetric object) {
  return [];
}

void _bodyMetricAttach(IsarCollection<dynamic> col, Id id, BodyMetric object) {
  object.id = id;
}

extension BodyMetricByIndex on IsarCollection<BodyMetric> {
  Future<BodyMetric?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  BodyMetric? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<BodyMetric?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<BodyMetric?> getAllByDateSync(List<DateTime> dateValues) {
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

  Future<Id> putByDate(BodyMetric object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(BodyMetric object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<BodyMetric> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<BodyMetric> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension BodyMetricQueryWhereSort
    on QueryBuilder<BodyMetric, BodyMetric, QWhere> {
  QueryBuilder<BodyMetric, BodyMetric, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension BodyMetricQueryWhere
    on QueryBuilder<BodyMetric, BodyMetric, QWhereClause> {
  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> idBetween(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> dateEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> dateNotEqualTo(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> dateGreaterThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> dateLessThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterWhereClause> dateBetween(
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

extension BodyMetricQueryFilter
    on QueryBuilder<BodyMetric, BodyMetric, QFilterCondition> {
  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'abdominalSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'abdominalSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'abdominalSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'abdominalSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'abdominalSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  abdominalSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'abdominalSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bicepSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bicepSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bicepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bicepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bicepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bicepSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bicepSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bodyFatMethod'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bodyFatMethod'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bodyFatMethod', value: value),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyFatMethod',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyFatMethod',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatMethodBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyFatMethod',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bodyFatPercentage'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bodyFatPercentage'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bodyFatPercentage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyFatPercentage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyFatPercentage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  bodyFatPercentageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyFatPercentage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'calfSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'calfSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'calfSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'calfSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'calfSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  calfSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'calfSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'chest'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'chest'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'chest',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chest',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chest',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> chestBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chest',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'chestSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'chestSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'chestSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chestSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chestSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  chestSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chestSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'estimatedFreeTestosterone'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'estimatedFreeTestosterone'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'estimatedFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estimatedFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estimatedFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  estimatedFreeTestosteroneBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estimatedFreeTestosterone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gripStrengthLeft'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gripStrengthLeft'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gripStrengthLeft',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gripStrengthLeft',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gripStrengthLeft',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthLeftBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gripStrengthLeft',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gripStrengthRight'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gripStrengthRight'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gripStrengthRight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gripStrengthRight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gripStrengthRight',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  gripStrengthRightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gripStrengthRight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'hips'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'hips'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hips',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hips',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hips',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> hipsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hips',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'labFreeTestosterone'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'labFreeTestosterone'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'labFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'labFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'labFreeTestosterone',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  labFreeTestosteroneBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'labFreeTestosterone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftArmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'leftArm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftArmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'leftArm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftArmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'leftArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftArmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'leftArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftArmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'leftArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftArmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'leftArm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftCalfIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'leftCalf'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftCalfIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'leftCalf'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftCalfEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'leftCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftCalfGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'leftCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftCalfLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'leftCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftCalfBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'leftCalf',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'leftForearm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'leftForearm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'leftForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'leftForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'leftForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftForearmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'leftForearm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftThighIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'leftThigh'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftThighIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'leftThigh'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftThighEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'leftThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  leftThighGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'leftThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftThighLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'leftThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> leftThighBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'leftThigh',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lowerBackSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lowerBackSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lowerBackSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lowerBackSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lowerBackSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  lowerBackSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lowerBackSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'midaxillarySkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'midaxillarySkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'midaxillarySkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'midaxillarySkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'midaxillarySkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  midaxillarySkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'midaxillarySkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'muscleMassGains'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'muscleMassGains'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'muscleMassGains',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'muscleMassGains',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'muscleMassGains',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  muscleMassGainsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'muscleMassGains',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'neck'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'neck'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'neck',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'neck',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'neck',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> neckBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'neck',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightArmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rightArm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightArmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rightArm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightArmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rightArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightArmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rightArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightArmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rightArm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightArmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rightArm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightCalfIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rightCalf'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightCalfIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rightCalf'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightCalfEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rightCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightCalfGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rightCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightCalfLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rightCalf',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightCalfBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rightCalf',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rightForearm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rightForearm'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rightForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rightForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rightForearm',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightForearmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rightForearm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightThighIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rightThigh'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightThighIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rightThigh'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightThighEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rightThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightThighGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rightThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  rightThighLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rightThigh',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> rightThighBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rightThigh',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'subscapularSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'subscapularSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subscapularSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subscapularSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subscapularSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  subscapularSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subscapularSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'suprailiacSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'suprailiacSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'suprailiacSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suprailiacSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suprailiacSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  suprailiacSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suprailiacSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'thighSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'thighSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'thighSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'thighSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'thighSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  thighSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'thighSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tricepSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tricepSkinfold'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tricepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tricepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tricepSkinfold',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  tricepSkinfoldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tricepSkinfold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'waist'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'waist'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waist',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waist',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waist',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> waistBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waist',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition>
  weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> weightEqualTo(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> weightGreaterThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> weightLessThan(
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

  QueryBuilder<BodyMetric, BodyMetric, QAfterFilterCondition> weightBetween(
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

extension BodyMetricQueryObject
    on QueryBuilder<BodyMetric, BodyMetric, QFilterCondition> {}

extension BodyMetricQueryLinks
    on QueryBuilder<BodyMetric, BodyMetric, QFilterCondition> {}

extension BodyMetricQuerySortBy
    on QueryBuilder<BodyMetric, BodyMetric, QSortBy> {
  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByAbdominalSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'abdominalSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByAbdominalSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'abdominalSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByBicepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bicepSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByBicepSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bicepSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByBodyFatMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatMethod', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByBodyFatMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatMethod', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByBodyFatPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatPercentage', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByBodyFatPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatPercentage', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByCalfSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calfSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByCalfSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calfSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByChest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chest', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByChestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chest', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByChestSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chestSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByChestSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chestSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByEstimatedFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedFreeTestosterone', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByEstimatedFreeTestosteroneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedFreeTestosterone', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByGripStrengthLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthLeft', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByGripStrengthLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthLeft', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByGripStrengthRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthRight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByGripStrengthRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthRight', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByHips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hips', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByHipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hips', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByLabFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labFreeTestosterone', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByLabFreeTestosteroneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labFreeTestosterone', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftArm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftArmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftArm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCalf', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftCalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCalf', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftForearm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftForearmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftForearm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftThigh', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLeftThighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftThigh', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByLowerBackSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowerBackSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByLowerBackSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowerBackSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByMidaxillarySkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'midaxillarySkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByMidaxillarySkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'midaxillarySkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByMuscleMassGains() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMassGains', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByMuscleMassGainsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMassGains', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByNeck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'neck', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByNeckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'neck', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightArm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightArmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightArm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCalf', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightCalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCalf', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightForearm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightForearmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightForearm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightThigh', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByRightThighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightThigh', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortBySubscapularSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscapularSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortBySubscapularSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscapularSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortBySuprailiacSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suprailiacSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortBySuprailiacSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suprailiacSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByThighSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thighSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByThighSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thighSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByTricepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tricepSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  sortByTricepSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tricepSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByWaist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waist', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByWaistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waist', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension BodyMetricQuerySortThenBy
    on QueryBuilder<BodyMetric, BodyMetric, QSortThenBy> {
  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByAbdominalSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'abdominalSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByAbdominalSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'abdominalSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByBicepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bicepSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByBicepSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bicepSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByBodyFatMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatMethod', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByBodyFatMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatMethod', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByBodyFatPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatPercentage', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByBodyFatPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFatPercentage', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByCalfSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calfSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByCalfSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calfSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByChest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chest', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByChestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chest', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByChestSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chestSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByChestSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chestSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByEstimatedFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedFreeTestosterone', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByEstimatedFreeTestosteroneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedFreeTestosterone', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByGripStrengthLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthLeft', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByGripStrengthLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthLeft', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByGripStrengthRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthRight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByGripStrengthRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gripStrengthRight', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByHips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hips', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByHipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hips', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByLabFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labFreeTestosterone', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByLabFreeTestosteroneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labFreeTestosterone', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftArm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftArmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftArm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCalf', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftCalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCalf', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftForearm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftForearmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftForearm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftThigh', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLeftThighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftThigh', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByLowerBackSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowerBackSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByLowerBackSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowerBackSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByMidaxillarySkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'midaxillarySkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByMidaxillarySkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'midaxillarySkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByMuscleMassGains() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMassGains', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByMuscleMassGainsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMassGains', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByNeck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'neck', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByNeckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'neck', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightArm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightArmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightArm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCalf', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightCalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCalf', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightForearm', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightForearmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightForearm', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightThigh', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByRightThighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightThigh', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenBySubscapularSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscapularSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenBySubscapularSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscapularSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenBySuprailiacSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suprailiacSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenBySuprailiacSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suprailiacSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByThighSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thighSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByThighSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thighSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByTricepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tricepSkinfold', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy>
  thenByTricepSkinfoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tricepSkinfold', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByWaist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waist', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByWaistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waist', Sort.desc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension BodyMetricQueryWhereDistinct
    on QueryBuilder<BodyMetric, BodyMetric, QDistinct> {
  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByAbdominalSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'abdominalSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByBicepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bicepSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByBodyFatMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyFatMethod');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByBodyFatPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyFatPercentage');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByCalfSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calfSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByChest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chest');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByChestSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chestSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByEstimatedFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedFreeTestosterone');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByGripStrengthLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gripStrengthLeft');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByGripStrengthRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gripStrengthRight');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByHips() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hips');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByLabFreeTestosterone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'labFreeTestosterone');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByLeftArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftArm');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByLeftCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftCalf');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByLeftForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftForearm');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByLeftThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftThigh');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByLowerBackSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lowerBackSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctByMidaxillarySkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'midaxillarySkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByMuscleMassGains() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleMassGains');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByNeck() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'neck');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByRightArm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightArm');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByRightCalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightCalf');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByRightForearm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightForearm');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByRightThigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightThigh');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctBySubscapularSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscapularSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct>
  distinctBySuprailiacSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suprailiacSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByThighSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thighSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByTricepSkinfold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tricepSkinfold');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByWaist() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waist');
    });
  }

  QueryBuilder<BodyMetric, BodyMetric, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension BodyMetricQueryProperty
    on QueryBuilder<BodyMetric, BodyMetric, QQueryProperty> {
  QueryBuilder<BodyMetric, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  abdominalSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'abdominalSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> bicepSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bicepSkinfold');
    });
  }

  QueryBuilder<BodyMetric, int?, QQueryOperations> bodyFatMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyFatMethod');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  bodyFatPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyFatPercentage');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> calfSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calfSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> chestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chest');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> chestSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chestSkinfold');
    });
  }

  QueryBuilder<BodyMetric, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  estimatedFreeTestosteroneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedFreeTestosterone');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  gripStrengthLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gripStrengthLeft');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  gripStrengthRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gripStrengthRight');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> hipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hips');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  labFreeTestosteroneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'labFreeTestosterone');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> leftArmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftArm');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> leftCalfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftCalf');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> leftForearmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftForearm');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> leftThighProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftThigh');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  lowerBackSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lowerBackSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  midaxillarySkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'midaxillarySkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  muscleMassGainsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleMassGains');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> neckProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'neck');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> rightArmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightArm');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> rightCalfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightCalf');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> rightForearmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightForearm');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> rightThighProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightThigh');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  subscapularSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscapularSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations>
  suprailiacSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suprailiacSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> thighSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thighSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> tricepSkinfoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tricepSkinfold');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> waistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waist');
    });
  }

  QueryBuilder<BodyMetric, double?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}
