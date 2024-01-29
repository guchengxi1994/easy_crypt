// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFilesCollection on Isar {
  IsarCollection<Files> get files => this.collection();
}

const FilesSchema = CollectionSchema(
  name: r'Files',
  id: -6626793096959534753,
  properties: {
    r'createAt': PropertySchema(
      id: 0,
      name: r'createAt',
      type: IsarType.long,
    ),
    r'encryptedSavePath': PropertySchema(
      id: 1,
      name: r'encryptedSavePath',
      type: IsarType.string,
    ),
    r'filePath': PropertySchema(
      id: 2,
      name: r'filePath',
      type: IsarType.string,
    ),
    r'jobType': PropertySchema(
      id: 3,
      name: r'jobType',
      type: IsarType.byte,
      enumMap: _FilesjobTypeEnumValueMap,
    ),
    r'key': PropertySchema(
      id: 4,
      name: r'key',
      type: IsarType.string,
    )
  },
  estimateSize: _filesEstimateSize,
  serialize: _filesSerialize,
  deserialize: _filesDeserialize,
  deserializeProp: _filesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'transferRecords': LinkSchema(
      id: -7719623784852598776,
      name: r'transferRecords',
      target: r'TransferRecords',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _filesGetId,
  getLinks: _filesGetLinks,
  attach: _filesAttach,
  version: '3.1.0+1',
);

int _filesEstimateSize(
  Files object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.encryptedSavePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.filePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.key;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _filesSerialize(
  Files object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createAt);
  writer.writeString(offsets[1], object.encryptedSavePath);
  writer.writeString(offsets[2], object.filePath);
  writer.writeByte(offsets[3], object.jobType.index);
  writer.writeString(offsets[4], object.key);
}

Files _filesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Files();
  object.createAt = reader.readLong(offsets[0]);
  object.encryptedSavePath = reader.readStringOrNull(offsets[1]);
  object.filePath = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.jobType =
      _FilesjobTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          JobType.encrypt;
  object.key = reader.readStringOrNull(offsets[4]);
  return object;
}

P _filesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_FilesjobTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          JobType.encrypt) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FilesjobTypeEnumValueMap = {
  'encrypt': 0,
  'decrypt': 1,
  'encryptAndTransfer': 2,
  'transfer': 3,
};
const _FilesjobTypeValueEnumMap = {
  0: JobType.encrypt,
  1: JobType.decrypt,
  2: JobType.encryptAndTransfer,
  3: JobType.transfer,
};

Id _filesGetId(Files object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _filesGetLinks(Files object) {
  return [object.transferRecords];
}

void _filesAttach(IsarCollection<dynamic> col, Id id, Files object) {
  object.id = id;
  object.transferRecords.attach(
      col, col.isar.collection<TransferRecords>(), r'transferRecords', id);
}

extension FilesQueryWhereSort on QueryBuilder<Files, Files, QWhere> {
  QueryBuilder<Files, Files, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FilesQueryWhere on QueryBuilder<Files, Files, QWhereClause> {
  QueryBuilder<Files, Files, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Files, Files, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Files, Files, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Files, Files, QAfterWhereClause> idBetween(
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

extension FilesQueryFilter on QueryBuilder<Files, Files, QFilterCondition> {
  QueryBuilder<Files, Files, QAfterFilterCondition> createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> createAtGreaterThan(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> createAtLessThan(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> createAtBetween(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedSavePath',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      encryptedSavePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedSavePath',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      encryptedSavePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedSavePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'encryptedSavePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'encryptedSavePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> encryptedSavePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedSavePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      encryptedSavePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'encryptedSavePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'filePath',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'filePath',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> filePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Files, Files, QAfterFilterCondition> jobTypeEqualTo(
      JobType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobType',
        value: value,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> jobTypeGreaterThan(
    JobType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobType',
        value: value,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> jobTypeLessThan(
    JobType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobType',
        value: value,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> jobTypeBetween(
    JobType lower,
    JobType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }
}

extension FilesQueryObject on QueryBuilder<Files, Files, QFilterCondition> {}

extension FilesQueryLinks on QueryBuilder<Files, Files, QFilterCondition> {
  QueryBuilder<Files, Files, QAfterFilterCondition> transferRecords(
      FilterQuery<TransferRecords> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transferRecords');
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      transferRecordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transferRecords', length, true, length, true);
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition> transferRecordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transferRecords', 0, true, 0, true);
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      transferRecordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transferRecords', 0, false, 999999, true);
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      transferRecordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transferRecords', 0, true, length, include);
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      transferRecordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'transferRecords', length, include, 999999, true);
    });
  }

  QueryBuilder<Files, Files, QAfterFilterCondition>
      transferRecordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'transferRecords', lower, includeLower, upper, includeUpper);
    });
  }
}

extension FilesQuerySortBy on QueryBuilder<Files, Files, QSortBy> {
  QueryBuilder<Files, Files, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByEncryptedSavePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptedSavePath', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByEncryptedSavePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptedSavePath', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByJobTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }
}

extension FilesQuerySortThenBy on QueryBuilder<Files, Files, QSortThenBy> {
  QueryBuilder<Files, Files, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByEncryptedSavePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptedSavePath', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByEncryptedSavePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptedSavePath', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByJobTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.desc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<Files, Files, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }
}

extension FilesQueryWhereDistinct on QueryBuilder<Files, Files, QDistinct> {
  QueryBuilder<Files, Files, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<Files, Files, QDistinct> distinctByEncryptedSavePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encryptedSavePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Files, Files, QDistinct> distinctByFilePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'filePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Files, Files, QDistinct> distinctByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobType');
    });
  }

  QueryBuilder<Files, Files, QDistinct> distinctByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }
}

extension FilesQueryProperty on QueryBuilder<Files, Files, QQueryProperty> {
  QueryBuilder<Files, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Files, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<Files, String?, QQueryOperations> encryptedSavePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encryptedSavePath');
    });
  }

  QueryBuilder<Files, String?, QQueryOperations> filePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'filePath');
    });
  }

  QueryBuilder<Files, JobType, QQueryOperations> jobTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobType');
    });
  }

  QueryBuilder<Files, String?, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }
}
