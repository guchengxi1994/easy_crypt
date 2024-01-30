// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_records.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProcessRecordsCollection on Isar {
  IsarCollection<ProcessRecords> get processRecords => this.collection();
}

const ProcessRecordsSchema = CollectionSchema(
  name: r'ProcessRecords',
  id: -2465134969608781000,
  properties: {
    r'createAt': PropertySchema(
      id: 0,
      name: r'createAt',
      type: IsarType.long,
    ),
    r'decryptConfig': PropertySchema(
      id: 1,
      name: r'decryptConfig',
      type: IsarType.object,
      target: r'CryptConfig',
    ),
    r'done': PropertySchema(
      id: 2,
      name: r'done',
      type: IsarType.bool,
    ),
    r'encryptConfig': PropertySchema(
      id: 3,
      name: r'encryptConfig',
      type: IsarType.object,
      target: r'CryptConfig',
    ),
    r'jobType': PropertySchema(
      id: 4,
      name: r'jobType',
      type: IsarType.byte,
      enumMap: _ProcessRecordsjobTypeEnumValueMap,
    ),
    r'transferConfig': PropertySchema(
      id: 5,
      name: r'transferConfig',
      type: IsarType.object,
      target: r'TransferConfig',
    )
  },
  estimateSize: _processRecordsEstimateSize,
  serialize: _processRecordsSerialize,
  deserialize: _processRecordsDeserialize,
  deserializeProp: _processRecordsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'CryptConfig': CryptConfigSchema,
    r'TransferConfig': TransferConfigSchema
  },
  getId: _processRecordsGetId,
  getLinks: _processRecordsGetLinks,
  attach: _processRecordsAttach,
  version: '3.1.0+1',
);

int _processRecordsEstimateSize(
  ProcessRecords object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.decryptConfig;
    if (value != null) {
      bytesCount += 3 +
          CryptConfigSchema.estimateSize(
              value, allOffsets[CryptConfig]!, allOffsets);
    }
  }
  {
    final value = object.encryptConfig;
    if (value != null) {
      bytesCount += 3 +
          CryptConfigSchema.estimateSize(
              value, allOffsets[CryptConfig]!, allOffsets);
    }
  }
  {
    final value = object.transferConfig;
    if (value != null) {
      bytesCount += 3 +
          TransferConfigSchema.estimateSize(
              value, allOffsets[TransferConfig]!, allOffsets);
    }
  }
  return bytesCount;
}

void _processRecordsSerialize(
  ProcessRecords object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createAt);
  writer.writeObject<CryptConfig>(
    offsets[1],
    allOffsets,
    CryptConfigSchema.serialize,
    object.decryptConfig,
  );
  writer.writeBool(offsets[2], object.done);
  writer.writeObject<CryptConfig>(
    offsets[3],
    allOffsets,
    CryptConfigSchema.serialize,
    object.encryptConfig,
  );
  writer.writeByte(offsets[4], object.jobType.index);
  writer.writeObject<TransferConfig>(
    offsets[5],
    allOffsets,
    TransferConfigSchema.serialize,
    object.transferConfig,
  );
}

ProcessRecords _processRecordsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProcessRecords();
  object.createAt = reader.readLong(offsets[0]);
  object.decryptConfig = reader.readObjectOrNull<CryptConfig>(
    offsets[1],
    CryptConfigSchema.deserialize,
    allOffsets,
  );
  object.done = reader.readBool(offsets[2]);
  object.encryptConfig = reader.readObjectOrNull<CryptConfig>(
    offsets[3],
    CryptConfigSchema.deserialize,
    allOffsets,
  );
  object.id = id;
  object.jobType =
      _ProcessRecordsjobTypeValueEnumMap[reader.readByteOrNull(offsets[4])] ??
          JobType.encrypt;
  object.transferConfig = reader.readObjectOrNull<TransferConfig>(
    offsets[5],
    TransferConfigSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _processRecordsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<CryptConfig>(
        offset,
        CryptConfigSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<CryptConfig>(
        offset,
        CryptConfigSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (_ProcessRecordsjobTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          JobType.encrypt) as P;
    case 5:
      return (reader.readObjectOrNull<TransferConfig>(
        offset,
        TransferConfigSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ProcessRecordsjobTypeEnumValueMap = {
  'encrypt': 0,
  'decrypt': 1,
  'encryptAndTransfer': 2,
  'transfer': 3,
};
const _ProcessRecordsjobTypeValueEnumMap = {
  0: JobType.encrypt,
  1: JobType.decrypt,
  2: JobType.encryptAndTransfer,
  3: JobType.transfer,
};

Id _processRecordsGetId(ProcessRecords object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _processRecordsGetLinks(ProcessRecords object) {
  return [];
}

void _processRecordsAttach(
    IsarCollection<dynamic> col, Id id, ProcessRecords object) {
  object.id = id;
}

extension ProcessRecordsQueryWhereSort
    on QueryBuilder<ProcessRecords, ProcessRecords, QWhere> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProcessRecordsQueryWhere
    on QueryBuilder<ProcessRecords, ProcessRecords, QWhereClause> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterWhereClause> idBetween(
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

extension ProcessRecordsQueryFilter
    on QueryBuilder<ProcessRecords, ProcessRecords, QFilterCondition> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      decryptConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'decryptConfig',
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      decryptConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'decryptConfig',
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      doneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'done',
        value: value,
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      encryptConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptConfig',
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      encryptConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptConfig',
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      jobTypeEqualTo(JobType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobType',
        value: value,
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      jobTypeGreaterThan(
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      jobTypeLessThan(
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      jobTypeBetween(
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

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      transferConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transferConfig',
      ));
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      transferConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transferConfig',
      ));
    });
  }
}

extension ProcessRecordsQueryObject
    on QueryBuilder<ProcessRecords, ProcessRecords, QFilterCondition> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      decryptConfig(FilterQuery<CryptConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'decryptConfig');
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      encryptConfig(FilterQuery<CryptConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'encryptConfig');
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterFilterCondition>
      transferConfig(FilterQuery<TransferConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transferConfig');
    });
  }
}

extension ProcessRecordsQueryLinks
    on QueryBuilder<ProcessRecords, ProcessRecords, QFilterCondition> {}

extension ProcessRecordsQuerySortBy
    on QueryBuilder<ProcessRecords, ProcessRecords, QSortBy> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> sortByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> sortByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> sortByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy>
      sortByJobTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.desc);
    });
  }
}

extension ProcessRecordsQuerySortThenBy
    on QueryBuilder<ProcessRecords, ProcessRecords, QSortThenBy> {
  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy> thenByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.asc);
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QAfterSortBy>
      thenByJobTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobType', Sort.desc);
    });
  }
}

extension ProcessRecordsQueryWhereDistinct
    on QueryBuilder<ProcessRecords, ProcessRecords, QDistinct> {
  QueryBuilder<ProcessRecords, ProcessRecords, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QDistinct> distinctByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'done');
    });
  }

  QueryBuilder<ProcessRecords, ProcessRecords, QDistinct> distinctByJobType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobType');
    });
  }
}

extension ProcessRecordsQueryProperty
    on QueryBuilder<ProcessRecords, ProcessRecords, QQueryProperty> {
  QueryBuilder<ProcessRecords, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProcessRecords, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<ProcessRecords, CryptConfig?, QQueryOperations>
      decryptConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'decryptConfig');
    });
  }

  QueryBuilder<ProcessRecords, bool, QQueryOperations> doneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'done');
    });
  }

  QueryBuilder<ProcessRecords, CryptConfig?, QQueryOperations>
      encryptConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encryptConfig');
    });
  }

  QueryBuilder<ProcessRecords, JobType, QQueryOperations> jobTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobType');
    });
  }

  QueryBuilder<ProcessRecords, TransferConfig?, QQueryOperations>
      transferConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferConfig');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CryptConfigSchema = Schema(
  name: r'CryptConfig',
  id: 2168638499685609423,
  properties: {
    r'datasourceId': PropertySchema(
      id: 0,
      name: r'datasourceId',
      type: IsarType.long,
    ),
    r'key': PropertySchema(
      id: 1,
      name: r'key',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 2,
      name: r'path',
      type: IsarType.string,
    ),
    r'savedPath': PropertySchema(
      id: 3,
      name: r'savedPath',
      type: IsarType.string,
    )
  },
  estimateSize: _cryptConfigEstimateSize,
  serialize: _cryptConfigSerialize,
  deserialize: _cryptConfigDeserialize,
  deserializeProp: _cryptConfigDeserializeProp,
);

int _cryptConfigEstimateSize(
  CryptConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.key;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.savedPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cryptConfigSerialize(
  CryptConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.datasourceId);
  writer.writeString(offsets[1], object.key);
  writer.writeString(offsets[2], object.path);
  writer.writeString(offsets[3], object.savedPath);
}

CryptConfig _cryptConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CryptConfig();
  object.datasourceId = reader.readLongOrNull(offsets[0]);
  object.key = reader.readStringOrNull(offsets[1]);
  object.path = reader.readStringOrNull(offsets[2]);
  object.savedPath = reader.readStringOrNull(offsets[3]);
  return object;
}

P _cryptConfigDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CryptConfigQueryFilter
    on QueryBuilder<CryptConfig, CryptConfig, QFilterCondition> {
  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'datasourceId',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'datasourceId',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      datasourceIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datasourceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyEqualTo(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyGreaterThan(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyLessThan(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyBetween(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyStartsWith(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyEndsWith(
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

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'savedPath',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'savedPath',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savedPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'savedPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedPath',
        value: '',
      ));
    });
  }

  QueryBuilder<CryptConfig, CryptConfig, QAfterFilterCondition>
      savedPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'savedPath',
        value: '',
      ));
    });
  }
}

extension CryptConfigQueryObject
    on QueryBuilder<CryptConfig, CryptConfig, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TransferConfigSchema = Schema(
  name: r'TransferConfig',
  id: 756298842456259421,
  properties: {
    r'from': PropertySchema(
      id: 0,
      name: r'from',
      type: IsarType.string,
    ),
    r'fromDatasourceId': PropertySchema(
      id: 1,
      name: r'fromDatasourceId',
      type: IsarType.long,
    ),
    r'key': PropertySchema(
      id: 2,
      name: r'key',
      type: IsarType.string,
    ),
    r'to': PropertySchema(
      id: 3,
      name: r'to',
      type: IsarType.string,
    ),
    r'toDatasourceId': PropertySchema(
      id: 4,
      name: r'toDatasourceId',
      type: IsarType.long,
    )
  },
  estimateSize: _transferConfigEstimateSize,
  serialize: _transferConfigSerialize,
  deserialize: _transferConfigDeserialize,
  deserializeProp: _transferConfigDeserializeProp,
);

int _transferConfigEstimateSize(
  TransferConfig object,
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
    final value = object.key;
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

void _transferConfigSerialize(
  TransferConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.from);
  writer.writeLong(offsets[1], object.fromDatasourceId);
  writer.writeString(offsets[2], object.key);
  writer.writeString(offsets[3], object.to);
  writer.writeLong(offsets[4], object.toDatasourceId);
}

TransferConfig _transferConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransferConfig();
  object.from = reader.readStringOrNull(offsets[0]);
  object.fromDatasourceId = reader.readLongOrNull(offsets[1]);
  object.key = reader.readStringOrNull(offsets[2]);
  object.to = reader.readStringOrNull(offsets[3]);
  object.toDatasourceId = reader.readLongOrNull(offsets[4]);
  return object;
}

P _transferConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TransferConfigQueryFilter
    on QueryBuilder<TransferConfig, TransferConfig, QFilterCondition> {
  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromDatasourceId',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromDatasourceId',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      fromDatasourceIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromDatasourceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyEqualTo(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyGreaterThan(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyLessThan(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyBetween(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyStartsWith(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyEndsWith(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition> toEqualTo(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition> toBetween(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition> toMatches(
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

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toDatasourceId',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toDatasourceId',
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toDatasourceId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferConfig, TransferConfig, QAfterFilterCondition>
      toDatasourceIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toDatasourceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransferConfigQueryObject
    on QueryBuilder<TransferConfig, TransferConfig, QFilterCondition> {}
