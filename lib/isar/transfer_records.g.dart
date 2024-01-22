// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_records.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransferRecordsCollection on Isar {
  IsarCollection<TransferRecords> get transferRecords => this.collection();
}

const TransferRecordsSchema = CollectionSchema(
  name: r'TransferRecords',
  id: 5777133830152154412,
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
      enumMap: _TransferRecordsfromTypeEnumValueMap,
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
      enumMap: _TransferRecordstoTypeEnumValueMap,
    )
  },
  estimateSize: _transferRecordsEstimateSize,
  serialize: _transferRecordsSerialize,
  deserialize: _transferRecordsDeserialize,
  deserializeProp: _transferRecordsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'account': LinkSchema(
      id: 8810575621791628230,
      name: r'account',
      target: r'Account',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transferRecordsGetId,
  getLinks: _transferRecordsGetLinks,
  attach: _transferRecordsAttach,
  version: '3.1.0+1',
);

int _transferRecordsEstimateSize(
  TransferRecords object,
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

void _transferRecordsSerialize(
  TransferRecords object,
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

TransferRecords _transferRecordsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransferRecords();
  object.createAt = reader.readLong(offsets[0]);
  object.done = reader.readBool(offsets[1]);
  object.from = reader.readStringOrNull(offsets[2]);
  object.fromType =
      _TransferRecordsfromTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          StorageType.S3;
  object.id = id;
  object.to = reader.readStringOrNull(offsets[4]);
  object.toType =
      _TransferRecordstoTypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          StorageType.S3;
  return object;
}

P _transferRecordsDeserializeProp<P>(
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
      return (_TransferRecordsfromTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          StorageType.S3) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_TransferRecordstoTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          StorageType.S3) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransferRecordsfromTypeEnumValueMap = {
  'S3': 0,
  'Webdav': 1,
  'Local': 2,
};
const _TransferRecordsfromTypeValueEnumMap = {
  0: StorageType.S3,
  1: StorageType.Webdav,
  2: StorageType.Local,
};
const _TransferRecordstoTypeEnumValueMap = {
  'S3': 0,
  'Webdav': 1,
  'Local': 2,
};
const _TransferRecordstoTypeValueEnumMap = {
  0: StorageType.S3,
  1: StorageType.Webdav,
  2: StorageType.Local,
};

Id _transferRecordsGetId(TransferRecords object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transferRecordsGetLinks(TransferRecords object) {
  return [object.account];
}

void _transferRecordsAttach(
    IsarCollection<dynamic> col, Id id, TransferRecords object) {
  object.id = id;
  object.account.attach(col, col.isar.collection<Account>(), r'account', id);
}

extension TransferRecordsQueryWhereSort
    on QueryBuilder<TransferRecords, TransferRecords, QWhere> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransferRecordsQueryWhere
    on QueryBuilder<TransferRecords, TransferRecords, QWhereClause> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterWhereClause>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterWhereClause> idBetween(
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

extension TransferRecordsQueryFilter
    on QueryBuilder<TransferRecords, TransferRecords, QFilterCondition> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      doneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'done',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromEqualTo(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromLessThan(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromBetween(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromEndsWith(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      fromTypeEqualTo(StorageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toEqualTo(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toGreaterThan(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toLessThan(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toBetween(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toStartsWith(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toEndsWith(
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'to',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toTypeEqualTo(StorageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
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

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      toTypeBetween(
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

extension TransferRecordsQueryObject
    on QueryBuilder<TransferRecords, TransferRecords, QFilterCondition> {}

extension TransferRecordsQueryLinks
    on QueryBuilder<TransferRecords, TransferRecords, QFilterCondition> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition> account(
      FilterQuery<Account> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'account');
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterFilterCondition>
      accountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'account', 0, true, 0, true);
    });
  }
}

extension TransferRecordsQuerySortBy
    on QueryBuilder<TransferRecords, TransferRecords, QSortBy> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> sortByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByFromTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> sortByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> sortByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> sortByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      sortByToTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.desc);
    });
  }
}

extension TransferRecordsQuerySortThenBy
    on QueryBuilder<TransferRecords, TransferRecords, QSortThenBy> {
  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByFromTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromType', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy> thenByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.asc);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QAfterSortBy>
      thenByToTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toType', Sort.desc);
    });
  }
}

extension TransferRecordsQueryWhereDistinct
    on QueryBuilder<TransferRecords, TransferRecords, QDistinct> {
  QueryBuilder<TransferRecords, TransferRecords, QDistinct>
      distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QDistinct> distinctByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'done');
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QDistinct> distinctByFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QDistinct>
      distinctByFromType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromType');
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QDistinct> distinctByTo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'to', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransferRecords, TransferRecords, QDistinct> distinctByToType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toType');
    });
  }
}

extension TransferRecordsQueryProperty
    on QueryBuilder<TransferRecords, TransferRecords, QQueryProperty> {
  QueryBuilder<TransferRecords, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransferRecords, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<TransferRecords, bool, QQueryOperations> doneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'done');
    });
  }

  QueryBuilder<TransferRecords, String?, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<TransferRecords, StorageType, QQueryOperations>
      fromTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromType');
    });
  }

  QueryBuilder<TransferRecords, String?, QQueryOperations> toProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'to');
    });
  }

  QueryBuilder<TransferRecords, StorageType, QQueryOperations>
      toTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toType');
    });
  }
}
