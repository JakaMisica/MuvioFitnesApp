// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSocialConversationCollection on Isar {
  IsarCollection<SocialConversation> get socialConversations =>
      this.collection();
}

const SocialConversationSchema = CollectionSchema(
  name: r'SocialConversation',
  id: 5722497852811130073,
  properties: {
    r'isBlocked': PropertySchema(
      id: 0,
      name: r'isBlocked',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 1,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'isMuted': PropertySchema(
      id: 2,
      name: r'isMuted',
      type: IsarType.bool,
    ),
    r'isPendingFriendRequest': PropertySchema(
      id: 3,
      name: r'isPendingFriendRequest',
      type: IsarType.bool,
    ),
    r'lastActive': PropertySchema(
      id: 4,
      name: r'lastActive',
      type: IsarType.dateTime,
    ),
    r'lastMessage': PropertySchema(
      id: 5,
      name: r'lastMessage',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'participantIds': PropertySchema(
      id: 7,
      name: r'participantIds',
      type: IsarType.stringList,
    ),
    r'peerId': PropertySchema(
      id: 8,
      name: r'peerId',
      type: IsarType.string,
    ),
    r'peerName': PropertySchema(
      id: 9,
      name: r'peerName',
      type: IsarType.string,
    ),
    r'remoteId': PropertySchema(
      id: 10,
      name: r'remoteId',
      type: IsarType.string,
    )
  },
  estimateSize: _socialConversationEstimateSize,
  serialize: _socialConversationSerialize,
  deserialize: _socialConversationDeserialize,
  deserializeProp: _socialConversationDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _socialConversationGetId,
  getLinks: _socialConversationGetLinks,
  attach: _socialConversationAttach,
  version: '3.1.0+1',
);

int _socialConversationEstimateSize(
  SocialConversation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.participantIds.length * 3;
  {
    for (var i = 0; i < object.participantIds.length; i++) {
      final value = object.participantIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.peerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.peerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.remoteId.length * 3;
  return bytesCount;
}

void _socialConversationSerialize(
  SocialConversation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isBlocked);
  writer.writeBool(offsets[1], object.isGroup);
  writer.writeBool(offsets[2], object.isMuted);
  writer.writeBool(offsets[3], object.isPendingFriendRequest);
  writer.writeDateTime(offsets[4], object.lastActive);
  writer.writeString(offsets[5], object.lastMessage);
  writer.writeString(offsets[6], object.name);
  writer.writeStringList(offsets[7], object.participantIds);
  writer.writeString(offsets[8], object.peerId);
  writer.writeString(offsets[9], object.peerName);
  writer.writeString(offsets[10], object.remoteId);
}

SocialConversation _socialConversationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SocialConversation();
  object.id = id;
  object.isBlocked = reader.readBool(offsets[0]);
  object.isGroup = reader.readBool(offsets[1]);
  object.isMuted = reader.readBool(offsets[2]);
  object.isPendingFriendRequest = reader.readBool(offsets[3]);
  object.lastActive = reader.readDateTime(offsets[4]);
  object.lastMessage = reader.readStringOrNull(offsets[5]);
  object.name = reader.readString(offsets[6]);
  object.participantIds = reader.readStringList(offsets[7]) ?? [];
  object.peerId = reader.readStringOrNull(offsets[8]);
  object.peerName = reader.readStringOrNull(offsets[9]);
  object.remoteId = reader.readString(offsets[10]);
  return object;
}

P _socialConversationDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _socialConversationGetId(SocialConversation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _socialConversationGetLinks(
    SocialConversation object) {
  return [];
}

void _socialConversationAttach(
    IsarCollection<dynamic> col, Id id, SocialConversation object) {
  object.id = id;
}

extension SocialConversationByIndex on IsarCollection<SocialConversation> {
  Future<SocialConversation?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  SocialConversation? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<SocialConversation?>> getAllByRemoteId(
      List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<SocialConversation?> getAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteId', values);
  }

  Future<int> deleteAllByRemoteId(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteId', values);
  }

  int deleteAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteId', values);
  }

  Future<Id> putByRemoteId(SocialConversation object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(SocialConversation object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<SocialConversation> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<SocialConversation> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension SocialConversationQueryWhereSort
    on QueryBuilder<SocialConversation, SocialConversation, QWhere> {
  QueryBuilder<SocialConversation, SocialConversation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SocialConversationQueryWhere
    on QueryBuilder<SocialConversation, SocialConversation, QWhereClause> {
  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
      remoteIdEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterWhereClause>
      remoteIdNotEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SocialConversationQueryFilter
    on QueryBuilder<SocialConversation, SocialConversation, QFilterCondition> {
  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      isBlockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      isGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      isMutedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMuted',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      isPendingFriendRequestEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPendingFriendRequest',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastActiveEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastActive',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastActiveGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastActive',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastActiveLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastActive',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastActiveBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastActive',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      lastMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
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

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantIds',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantIds',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      participantIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'participantIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peerId',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peerId',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peerId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peerName',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peerName',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      peerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }
}

extension SocialConversationQueryObject
    on QueryBuilder<SocialConversation, SocialConversation, QFilterCondition> {}

extension SocialConversationQueryLinks
    on QueryBuilder<SocialConversation, SocialConversation, QFilterCondition> {}

extension SocialConversationQuerySortBy
    on QueryBuilder<SocialConversation, SocialConversation, QSortBy> {
  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsMutedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsPendingFriendRequest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPendingFriendRequest', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByIsPendingFriendRequestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPendingFriendRequest', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByLastActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActive', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByLastActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActive', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByLastMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByLastMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByPeerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerId', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByPeerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerId', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByPeerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerName', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByPeerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerName', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }
}

extension SocialConversationQuerySortThenBy
    on QueryBuilder<SocialConversation, SocialConversation, QSortThenBy> {
  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsMutedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsPendingFriendRequest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPendingFriendRequest', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByIsPendingFriendRequestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPendingFriendRequest', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByLastActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActive', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByLastActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActive', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByLastMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByLastMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByPeerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerId', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByPeerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerId', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByPeerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerName', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByPeerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerName', Sort.desc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }
}

extension SocialConversationQueryWhereDistinct
    on QueryBuilder<SocialConversation, SocialConversation, QDistinct> {
  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlocked');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMuted');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByIsPendingFriendRequest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPendingFriendRequest');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByLastActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastActive');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByLastMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByParticipantIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantIds');
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByPeerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByPeerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialConversation, SocialConversation, QDistinct>
      distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }
}

extension SocialConversationQueryProperty
    on QueryBuilder<SocialConversation, SocialConversation, QQueryProperty> {
  QueryBuilder<SocialConversation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SocialConversation, bool, QQueryOperations> isBlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlocked');
    });
  }

  QueryBuilder<SocialConversation, bool, QQueryOperations> isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<SocialConversation, bool, QQueryOperations> isMutedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMuted');
    });
  }

  QueryBuilder<SocialConversation, bool, QQueryOperations>
      isPendingFriendRequestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPendingFriendRequest');
    });
  }

  QueryBuilder<SocialConversation, DateTime, QQueryOperations>
      lastActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastActive');
    });
  }

  QueryBuilder<SocialConversation, String?, QQueryOperations>
      lastMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessage');
    });
  }

  QueryBuilder<SocialConversation, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SocialConversation, List<String>, QQueryOperations>
      participantIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantIds');
    });
  }

  QueryBuilder<SocialConversation, String?, QQueryOperations> peerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peerId');
    });
  }

  QueryBuilder<SocialConversation, String?, QQueryOperations>
      peerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peerName');
    });
  }

  QueryBuilder<SocialConversation, String, QQueryOperations>
      remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSocialMessageCollection on Isar {
  IsarCollection<SocialMessage> get socialMessages => this.collection();
}

const SocialMessageSchema = CollectionSchema(
  name: r'SocialMessage',
  id: -3529106162850884599,
  properties: {
    r'conversationId': PropertySchema(
      id: 0,
      name: r'conversationId',
      type: IsarType.string,
    ),
    r'isBlurred': PropertySchema(
      id: 1,
      name: r'isBlurred',
      type: IsarType.bool,
    ),
    r'isDeleted': PropertySchema(
      id: 2,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isEdited': PropertySchema(
      id: 3,
      name: r'isEdited',
      type: IsarType.bool,
    ),
    r'isImported': PropertySchema(
      id: 4,
      name: r'isImported',
      type: IsarType.bool,
    ),
    r'isPending': PropertySchema(
      id: 5,
      name: r'isPending',
      type: IsarType.bool,
    ),
    r'isProfane': PropertySchema(
      id: 6,
      name: r'isProfane',
      type: IsarType.bool,
    ),
    r'remoteId': PropertySchema(
      id: 7,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 8,
      name: r'senderId',
      type: IsarType.string,
    ),
    r'senderName': PropertySchema(
      id: 9,
      name: r'senderName',
      type: IsarType.string,
    ),
    r'sharedContentJson': PropertySchema(
      id: 10,
      name: r'sharedContentJson',
      type: IsarType.string,
    ),
    r'sharedType': PropertySchema(
      id: 11,
      name: r'sharedType',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 12,
      name: r'text',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 13,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _socialMessageEstimateSize,
  serialize: _socialMessageSerialize,
  deserialize: _socialMessageDeserialize,
  deserializeProp: _socialMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'conversationId': IndexSchema(
      id: 2945908346256754300,
      name: r'conversationId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'conversationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _socialMessageGetId,
  getLinks: _socialMessageGetLinks,
  attach: _socialMessageAttach,
  version: '3.1.0+1',
);

int _socialMessageEstimateSize(
  SocialMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.conversationId.length * 3;
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.senderId.length * 3;
  bytesCount += 3 + object.senderName.length * 3;
  {
    final value = object.sharedContentJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sharedType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _socialMessageSerialize(
  SocialMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.conversationId);
  writer.writeBool(offsets[1], object.isBlurred);
  writer.writeBool(offsets[2], object.isDeleted);
  writer.writeBool(offsets[3], object.isEdited);
  writer.writeBool(offsets[4], object.isImported);
  writer.writeBool(offsets[5], object.isPending);
  writer.writeBool(offsets[6], object.isProfane);
  writer.writeString(offsets[7], object.remoteId);
  writer.writeString(offsets[8], object.senderId);
  writer.writeString(offsets[9], object.senderName);
  writer.writeString(offsets[10], object.sharedContentJson);
  writer.writeString(offsets[11], object.sharedType);
  writer.writeString(offsets[12], object.text);
  writer.writeDateTime(offsets[13], object.timestamp);
}

SocialMessage _socialMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SocialMessage();
  object.conversationId = reader.readString(offsets[0]);
  object.id = id;
  object.isBlurred = reader.readBool(offsets[1]);
  object.isDeleted = reader.readBool(offsets[2]);
  object.isEdited = reader.readBool(offsets[3]);
  object.isImported = reader.readBool(offsets[4]);
  object.isPending = reader.readBool(offsets[5]);
  object.isProfane = reader.readBool(offsets[6]);
  object.remoteId = reader.readString(offsets[7]);
  object.senderId = reader.readString(offsets[8]);
  object.senderName = reader.readString(offsets[9]);
  object.sharedContentJson = reader.readStringOrNull(offsets[10]);
  object.sharedType = reader.readStringOrNull(offsets[11]);
  object.text = reader.readString(offsets[12]);
  object.timestamp = reader.readDateTime(offsets[13]);
  return object;
}

P _socialMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _socialMessageGetId(SocialMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _socialMessageGetLinks(SocialMessage object) {
  return [];
}

void _socialMessageAttach(
    IsarCollection<dynamic> col, Id id, SocialMessage object) {
  object.id = id;
}

extension SocialMessageQueryWhereSort
    on QueryBuilder<SocialMessage, SocialMessage, QWhere> {
  QueryBuilder<SocialMessage, SocialMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SocialMessageQueryWhere
    on QueryBuilder<SocialMessage, SocialMessage, QWhereClause> {
  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause>
      conversationIdEqualTo(String conversationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'conversationId',
        value: [conversationId],
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause>
      conversationIdNotEqualTo(String conversationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationId',
              lower: [],
              upper: [conversationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationId',
              lower: [conversationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationId',
              lower: [conversationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationId',
              lower: [],
              upper: [conversationId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause> remoteIdEqualTo(
      String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterWhereClause>
      remoteIdNotEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SocialMessageQueryFilter
    on QueryBuilder<SocialMessage, SocialMessage, QFilterCondition> {
  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conversationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conversationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      conversationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conversationId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isBlurredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlurred',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isEditedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isImportedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isImported',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isPendingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPending',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      isProfaneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isProfane',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderName',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      senderNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderName',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sharedContentJson',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sharedContentJson',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sharedContentJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sharedContentJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sharedContentJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedContentJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedContentJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sharedContentJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sharedType',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sharedType',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sharedType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sharedType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sharedType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedType',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      sharedTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sharedType',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
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

  QueryBuilder<SocialMessage, SocialMessage, QAfterFilterCondition>
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

extension SocialMessageQueryObject
    on QueryBuilder<SocialMessage, SocialMessage, QFilterCondition> {}

extension SocialMessageQueryLinks
    on QueryBuilder<SocialMessage, SocialMessage, QFilterCondition> {}

extension SocialMessageQuerySortBy
    on QueryBuilder<SocialMessage, SocialMessage, QSortBy> {
  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsBlurred() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlurred', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsBlurredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlurred', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isImported', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isImported', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsPendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByIsProfane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfane', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByIsProfaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfane', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortBySenderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderName', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortBySenderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderName', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortBySharedContentJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedContentJson', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortBySharedContentJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedContentJson', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortBySharedType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedType', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortBySharedTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedType', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension SocialMessageQuerySortThenBy
    on QueryBuilder<SocialMessage, SocialMessage, QSortThenBy> {
  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsBlurred() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlurred', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsBlurredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlurred', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isImported', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isImported', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsPendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByIsProfane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfane', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByIsProfaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfane', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenBySenderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderName', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenBySenderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderName', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenBySharedContentJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedContentJson', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenBySharedContentJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedContentJson', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenBySharedType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedType', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenBySharedTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sharedType', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension SocialMessageQueryWhereDistinct
    on QueryBuilder<SocialMessage, SocialMessage, QDistinct> {
  QueryBuilder<SocialMessage, SocialMessage, QDistinct>
      distinctByConversationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsBlurred() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlurred');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEdited');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isImported');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPending');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByIsProfane() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isProfane');
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByRemoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctBySenderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctBySenderName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct>
      distinctBySharedContentJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sharedContentJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctBySharedType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sharedType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SocialMessage, SocialMessage, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension SocialMessageQueryProperty
    on QueryBuilder<SocialMessage, SocialMessage, QQueryProperty> {
  QueryBuilder<SocialMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SocialMessage, String, QQueryOperations>
      conversationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationId');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isBlurredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlurred');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isEditedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEdited');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isImportedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isImported');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isPendingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPending');
    });
  }

  QueryBuilder<SocialMessage, bool, QQueryOperations> isProfaneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isProfane');
    });
  }

  QueryBuilder<SocialMessage, String, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<SocialMessage, String, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<SocialMessage, String, QQueryOperations> senderNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderName');
    });
  }

  QueryBuilder<SocialMessage, String?, QQueryOperations>
      sharedContentJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sharedContentJson');
    });
  }

  QueryBuilder<SocialMessage, String?, QQueryOperations> sharedTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sharedType');
    });
  }

  QueryBuilder<SocialMessage, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<SocialMessage, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
