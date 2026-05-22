// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTemplateFolderCollection on Isar {
  IsarCollection<TemplateFolder> get templateFolders => this.collection();
}

const TemplateFolderSchema = CollectionSchema(
  name: r'TemplateFolder',
  id: 278137563155850793,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _templateFolderEstimateSize,
  serialize: _templateFolderSerialize,
  deserialize: _templateFolderDeserialize,
  deserializeProp: _templateFolderDeserializeProp,
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
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'parent': LinkSchema(
      id: 4796112286697916648,
      name: r'parent',
      target: r'TemplateFolder',
      single: true,
    ),
    r'subFolders': LinkSchema(
      id: 7140494443314892200,
      name: r'subFolders',
      target: r'TemplateFolder',
      single: false,
      linkName: r'parent',
    ),
    r'templates': LinkSchema(
      id: 6435932590783800094,
      name: r'templates',
      target: r'WorkoutTemplate',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _templateFolderGetId,
  getLinks: _templateFolderGetLinks,
  attach: _templateFolderAttach,
  version: '3.1.0+1',
);

int _templateFolderEstimateSize(
  TemplateFolder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _templateFolderSerialize(
  TemplateFolder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

TemplateFolder _templateFolderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TemplateFolder();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _templateFolderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _templateFolderGetId(TemplateFolder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _templateFolderGetLinks(TemplateFolder object) {
  return [object.parent, object.subFolders, object.templates];
}

void _templateFolderAttach(
    IsarCollection<dynamic> col, Id id, TemplateFolder object) {
  object.id = id;
  object.parent
      .attach(col, col.isar.collection<TemplateFolder>(), r'parent', id);
  object.subFolders
      .attach(col, col.isar.collection<TemplateFolder>(), r'subFolders', id);
  object.templates
      .attach(col, col.isar.collection<WorkoutTemplate>(), r'templates', id);
}

extension TemplateFolderQueryWhereSort
    on QueryBuilder<TemplateFolder, TemplateFolder, QWhere> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TemplateFolderQueryWhere
    on QueryBuilder<TemplateFolder, TemplateFolder, QWhereClause> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> idBetween(
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

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TemplateFolderQueryFilter
    on QueryBuilder<TemplateFolder, TemplateFolder, QFilterCondition> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
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

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
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

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension TemplateFolderQueryObject
    on QueryBuilder<TemplateFolder, TemplateFolder, QFilterCondition> {}

extension TemplateFolderQueryLinks
    on QueryBuilder<TemplateFolder, TemplateFolder, QFilterCondition> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition> parent(
      FilterQuery<TemplateFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parent');
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      parentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parent', 0, true, 0, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFolders(FilterQuery<TemplateFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subFolders');
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subFolders', length, true, length, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subFolders', 0, true, 0, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subFolders', 0, false, 999999, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subFolders', 0, true, length, include);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subFolders', length, include, 999999, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      subFoldersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'subFolders', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition> templates(
      FilterQuery<WorkoutTemplate> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'templates');
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'templates', length, true, length, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'templates', 0, true, 0, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'templates', 0, false, 999999, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'templates', 0, true, length, include);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'templates', length, include, 999999, true);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterFilterCondition>
      templatesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'templates', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TemplateFolderQuerySortBy
    on QueryBuilder<TemplateFolder, TemplateFolder, QSortBy> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TemplateFolderQuerySortThenBy
    on QueryBuilder<TemplateFolder, TemplateFolder, QSortThenBy> {
  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TemplateFolder, TemplateFolder, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TemplateFolderQueryWhereDistinct
    on QueryBuilder<TemplateFolder, TemplateFolder, QDistinct> {
  QueryBuilder<TemplateFolder, TemplateFolder, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension TemplateFolderQueryProperty
    on QueryBuilder<TemplateFolder, TemplateFolder, QQueryProperty> {
  QueryBuilder<TemplateFolder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TemplateFolder, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutTemplateCollection on Isar {
  IsarCollection<WorkoutTemplate> get workoutTemplates => this.collection();
}

const WorkoutTemplateSchema = CollectionSchema(
  name: r'WorkoutTemplate',
  id: 9152743543952114156,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _workoutTemplateEstimateSize,
  serialize: _workoutTemplateSerialize,
  deserialize: _workoutTemplateDeserialize,
  deserializeProp: _workoutTemplateDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'exercises': LinkSchema(
      id: -1008840687758299302,
      name: r'exercises',
      target: r'TemplateExercise',
      single: false,
    ),
    r'folder': LinkSchema(
      id: -7393426033091716770,
      name: r'folder',
      target: r'TemplateFolder',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _workoutTemplateGetId,
  getLinks: _workoutTemplateGetLinks,
  attach: _workoutTemplateAttach,
  version: '3.1.0+1',
);

int _workoutTemplateEstimateSize(
  WorkoutTemplate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _workoutTemplateSerialize(
  WorkoutTemplate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

WorkoutTemplate _workoutTemplateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutTemplate();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _workoutTemplateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutTemplateGetId(WorkoutTemplate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutTemplateGetLinks(WorkoutTemplate object) {
  return [object.exercises, object.folder];
}

void _workoutTemplateAttach(
    IsarCollection<dynamic> col, Id id, WorkoutTemplate object) {
  object.id = id;
  object.exercises
      .attach(col, col.isar.collection<TemplateExercise>(), r'exercises', id);
  object.folder
      .attach(col, col.isar.collection<TemplateFolder>(), r'folder', id);
}

extension WorkoutTemplateQueryWhereSort
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QWhere> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutTemplateQueryWhere
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QWhereClause> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhereClause>
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

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterWhereClause> idBetween(
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

extension WorkoutTemplateQueryFilter
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QFilterCondition> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
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

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
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

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
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

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension WorkoutTemplateQueryObject
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QFilterCondition> {}

extension WorkoutTemplateQueryLinks
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QFilterCondition> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercises(FilterQuery<TemplateExercise> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exercises');
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', length, true, length, true);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, false, 999999, true);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', 0, true, length, include);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercises', length, include, 999999, true);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      exercisesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'exercises', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition> folder(
      FilterQuery<TemplateFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'folder');
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterFilterCondition>
      folderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folder', 0, true, 0, true);
    });
  }
}

extension WorkoutTemplateQuerySortBy
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QSortBy> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension WorkoutTemplateQuerySortThenBy
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QSortThenBy> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension WorkoutTemplateQueryWhereDistinct
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QDistinct> {
  QueryBuilder<WorkoutTemplate, WorkoutTemplate, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension WorkoutTemplateQueryProperty
    on QueryBuilder<WorkoutTemplate, WorkoutTemplate, QQueryProperty> {
  QueryBuilder<WorkoutTemplate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutTemplate, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTemplateExerciseCollection on Isar {
  IsarCollection<TemplateExercise> get templateExercises => this.collection();
}

const TemplateExerciseSchema = CollectionSchema(
  name: r'TemplateExercise',
  id: -1658675780284381064,
  properties: {
    r'orderIndex': PropertySchema(
      id: 0,
      name: r'orderIndex',
      type: IsarType.long,
    ),
    r'sets': PropertySchema(
      id: 1,
      name: r'sets',
      type: IsarType.objectList,
      target: r'WorkoutSet',
    )
  },
  estimateSize: _templateExerciseEstimateSize,
  serialize: _templateExerciseSerialize,
  deserialize: _templateExerciseDeserialize,
  deserializeProp: _templateExerciseDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'exercise': LinkSchema(
      id: 4461925371127207465,
      name: r'exercise',
      target: r'Exercise',
      single: true,
    )
  },
  embeddedSchemas: {
    r'WorkoutSet': WorkoutSetSchema,
    r'DropSetItem': DropSetItemSchema
  },
  getId: _templateExerciseGetId,
  getLinks: _templateExerciseGetLinks,
  attach: _templateExerciseAttach,
  version: '3.1.0+1',
);

int _templateExerciseEstimateSize(
  TemplateExercise object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
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

void _templateExerciseSerialize(
  TemplateExercise object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.orderIndex);
  writer.writeObjectList<WorkoutSet>(
    offsets[1],
    allOffsets,
    WorkoutSetSchema.serialize,
    object.sets,
  );
}

TemplateExercise _templateExerciseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TemplateExercise();
  object.id = id;
  object.orderIndex = reader.readLong(offsets[0]);
  object.sets = reader.readObjectList<WorkoutSet>(
        offsets[1],
        WorkoutSetSchema.deserialize,
        allOffsets,
        WorkoutSet(),
      ) ??
      [];
  return object;
}

P _templateExerciseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readObjectList<WorkoutSet>(
            offset,
            WorkoutSetSchema.deserialize,
            allOffsets,
            WorkoutSet(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _templateExerciseGetId(TemplateExercise object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _templateExerciseGetLinks(TemplateExercise object) {
  return [object.exercise];
}

void _templateExerciseAttach(
    IsarCollection<dynamic> col, Id id, TemplateExercise object) {
  object.id = id;
  object.exercise.attach(col, col.isar.collection<Exercise>(), r'exercise', id);
}

extension TemplateExerciseQueryWhereSort
    on QueryBuilder<TemplateExercise, TemplateExercise, QWhere> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TemplateExerciseQueryWhere
    on QueryBuilder<TemplateExercise, TemplateExercise, QWhereClause> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhereClause>
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

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterWhereClause> idBetween(
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

extension TemplateExerciseQueryFilter
    on QueryBuilder<TemplateExercise, TemplateExercise, QFilterCondition> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
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

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
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

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
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

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      orderIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      orderIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      orderIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      orderIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
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

extension TemplateExerciseQueryObject
    on QueryBuilder<TemplateExercise, TemplateExercise, QFilterCondition> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      setsElement(FilterQuery<WorkoutSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sets');
    });
  }
}

extension TemplateExerciseQueryLinks
    on QueryBuilder<TemplateExercise, TemplateExercise, QFilterCondition> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      exercise(FilterQuery<Exercise> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exercise');
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterFilterCondition>
      exerciseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exercise', 0, true, 0, true);
    });
  }
}

extension TemplateExerciseQuerySortBy
    on QueryBuilder<TemplateExercise, TemplateExercise, QSortBy> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy>
      sortByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy>
      sortByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }
}

extension TemplateExerciseQuerySortThenBy
    on QueryBuilder<TemplateExercise, TemplateExercise, QSortThenBy> {
  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy>
      thenByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<TemplateExercise, TemplateExercise, QAfterSortBy>
      thenByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }
}

extension TemplateExerciseQueryWhereDistinct
    on QueryBuilder<TemplateExercise, TemplateExercise, QDistinct> {
  QueryBuilder<TemplateExercise, TemplateExercise, QDistinct>
      distinctByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderIndex');
    });
  }
}

extension TemplateExerciseQueryProperty
    on QueryBuilder<TemplateExercise, TemplateExercise, QQueryProperty> {
  QueryBuilder<TemplateExercise, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TemplateExercise, int, QQueryOperations> orderIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderIndex');
    });
  }

  QueryBuilder<TemplateExercise, List<WorkoutSet>, QQueryOperations>
      setsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sets');
    });
  }
}
