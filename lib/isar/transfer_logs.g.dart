// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_logs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransferLogsCollection on Isar {
  IsarCollection<TransferLogs> get transferLogs => this.collection();
}

const TransferLogsSchema = CollectionSchema(
  name: r'TransferLogs',
  id: 4131052000494426427,
  properties: {
    r'createAt': PropertySchema(
      id: 0,
      name: r'createAt',
      type: IsarType.long,
    ),
    r'done': PropertySchema(
      id: 1,
      name: r'done',
      type: IsarType.bool,
    ),
    r'from': PropertySchema(
      id: 2,
      name: r'from',
      type: IsarType.string,
    ),
    r'fromType': PropertySchema(
      id: 3,
      name: r'fromType',
      type: IsarType.byte,
      enumMap: _TransferLogsfromTypeEnumValueMap,
    ),
    r'to': PropertySchema(
      id: 4,
      name: r'to',
      type: IsarType.string,
    ),
    r'toType': PropertySchema(
      id: 5,
      name: r'toType',
      type: IsarType.byte,
      enumMap: _TransferLogstoTypeEnumValueMap,
    )
  },
  estimateSize: _transferLogsEstimateSize,
  serialize: _transferLogsSerialize,
  deserialize: _transferLogsDeserialize,
  deserializeProp: _transferLogsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'account': LinkSchema(
      id: -2949433770348038579,
      name: r'account',
      target: r'Account',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transferLogsGetId,
  getLinks: _transferLogsGetLinks,
  attach: _transferLogsAttach,
  version: '3.1.0+1',
);

int _transferLogsEstimateSize(
  TransferLogs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.from;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.to;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transferLogsSerialize(
  TransferLogs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createAt);
  writer.writeBool(offsets[1], object.done);
  writer.writeString(offsets[2], object.from);
  writer.writeByte(offsets[3], object.fromType.index);
  writer.writeString(offsets[4], object.to);
  writer.writeByte(offsets[5], object.toType.index);
}

TransferLogs _transferLogsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransferLogs();
  object.createAt = reader.readLong(offsets[0]);
  object.done = reader.readBool(offsets[1]);
  object.from = reader.readStringOrNull(offsets[2]);
  object.fromType =
      _TransferLogsfromTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          StorageType.S3;
  object.id = id;
  object.to = reader.readStringOrNull(offsets[4]);
  object.toType =
      _TransferLogstoTypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          StorageType.S3;
  return object;
}

P _transferLogsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_TransferLogsfromTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          StorageType.S3) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_TransferLogstoTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          StorageType.S3) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransferLogsfromTypeEnumValueMap = {
  'S3': 0,
  'Webdav': 1,
  'Local': 2,
};
const _TransferLogsfromTypeValueEnumMap = {
  0: StorageType.S3,
  1: StorageType.Webdav,
  2: StorageType.Local,
};
const _TransferLogstoTypeEnumValueMap = {
  'S3': 0,
  'Webdav': 1,
  'Local': 2,
};
const _TransferLogstoTypeValueEnumMap = {
  0: StorageType.S3,
  1: StorageType.Webdav,
  2: StorageType.Local,
};

Id _transferLogsGetId(TransferLogs object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transferLogsGetLinks(TransferLogs object) {
  return [object.account];
}

void _transferLogsAttach(
    IsarCollection<dynamic> col, Id id, TransferLogs object) {
  object.id = id;
  object.account.attach(col, col.isar.collection<Account>(), r'account', id);
}

extension TransferLogsQueryWhereSort
    on QueryBuilder<TransferLogs, TransferLogs, QWhere> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransferLogsQueryWhere
    on QueryBuilder<TransferLogs, TransferLogs, QWhereClause> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TransferLogs, TransferLogs, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterWhereClause> idBetween(
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

extension TransferLogsQueryFilter
    on QueryBuilder<TransferLogs, TransferLogs, QFilterCondition> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      createAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      createAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      createAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> doneEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'done',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'from',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> fromMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromTypeEqualTo(StorageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromTypeGreaterThan(
    StorageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromTypeLessThan(
    StorageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      fromTypeBetween(
    StorageType lower,
    StorageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      toIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'to',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'to',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      toIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toTypeEqualTo(
      StorageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      toTypeGreaterThan(
    StorageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      toTypeLessThan(
    StorageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> toTypeBetween(
    StorageType lower,
    StorageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransferLogsQueryObject
    on QueryBuilder<TransferLogs, TransferLogs, QFilterCondition> {}

extension TransferLogsQueryLinks
    on QueryBuilder<TransferLogs, TransferLogs, QFilterCondition> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition> account(
      FilterQuery<Account> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'account');
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterFilterCondition>
      accountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'account', 0, true, 0, true);
    });
  }
}

extension TransferLogsQuerySortBy
    on QueryBuilder<TransferLogs, TransferLogs, QSortBy> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByFromTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> sortByToTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.desc);
    });
  }
}

extension TransferLogsQuerySortThenBy
    on QueryBuilder<TransferLogs, TransferLogs, QSortThenBy> {
  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByFromTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.asc);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QAfterSortBy> thenByToTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.desc);
    });
  }
}

extension TransferLogsQueryWhereDistinct
    on QueryBuilder<TransferLogs, TransferLogs, QDistinct> {
  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'done');
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromType');
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByTo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'to', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransferLogs, TransferLogs, QDistinct> distinctByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toType');
    });
  }
}

extension TransferLogsQueryProperty
    on QueryBuilder<TransferLogs, TransferLogs, QQueryProperty> {
  QueryBuilder<TransferLogs, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransferLogs, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<TransferLogs, bool, QQueryOperations> doneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'done');
    });
  }

  QueryBuilder<TransferLogs, String?, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<TransferLogs, StorageType, QQueryOperations> fromTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromType');
    });
  }

  QueryBuilder<TransferLogs, String?, QQueryOperations> toProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'to');
    });
  }

  QueryBuilder<TransferLogs, StorageType, QQueryOperations> toTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toType');
    });
  }
}
