// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ReminderTableTable extends ReminderTable
    with TableInfo<$ReminderTableTable, ReminderTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, description, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      ),
    );
  }

  @override
  $ReminderTableTable createAlias(String alias) {
    return $ReminderTableTable(attachedDatabase, alias);
  }
}

class ReminderTableData extends DataClass
    implements Insertable<ReminderTableData> {
  final int id;
  final String title;
  final String description;
  final DateTime? time;
  const ReminderTableData({
    required this.id,
    required this.title,
    required this.description,
    this.time,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    return map;
  }

  ReminderTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderTableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
    );
  }

  factory ReminderTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      time: serializer.fromJson<DateTime?>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'time': serializer.toJson<DateTime?>(time),
    };
  }

  ReminderTableData copyWith({
    int? id,
    String? title,
    String? description,
    Value<DateTime?> time = const Value.absent(),
  }) => ReminderTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    time: time.present ? time.value : this.time,
  );
  ReminderTableData copyWithCompanion(ReminderTableCompanion data) {
    return ReminderTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.time == this.time);
}

class ReminderTableCompanion extends UpdateCompanion<ReminderTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime?> time;
  const ReminderTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.time = const Value.absent(),
  });
  ReminderTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    this.time = const Value.absent(),
  }) : title = Value(title),
       description = Value(description);
  static Insertable<ReminderTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (time != null) 'time': time,
    });
  }

  ReminderTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime?>? time,
  }) {
    return ReminderTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $ReminderWeekdaysTableTable extends ReminderWeekdaysTable
    with TableInfo<$ReminderWeekdaysTableTable, ReminderWeekdaysTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderWeekdaysTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reminderIDMeta = const VerificationMeta(
    'reminderID',
  );
  @override
  late final GeneratedColumn<int> reminderID = GeneratedColumn<int>(
    'reminder_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reminder_table (id)',
    ),
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, reminderID, weekday];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_weekdays_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderWeekdaysTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reminder_i_d')) {
      context.handle(
        _reminderIDMeta,
        reminderID.isAcceptableOrUnknown(
          data['reminder_i_d']!,
          _reminderIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderIDMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderWeekdaysTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderWeekdaysTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reminderID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_i_d'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
    );
  }

  @override
  $ReminderWeekdaysTableTable createAlias(String alias) {
    return $ReminderWeekdaysTableTable(attachedDatabase, alias);
  }
}

class ReminderWeekdaysTableData extends DataClass
    implements Insertable<ReminderWeekdaysTableData> {
  final int id;
  final int reminderID;
  final int weekday;
  const ReminderWeekdaysTableData({
    required this.id,
    required this.reminderID,
    required this.weekday,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reminder_i_d'] = Variable<int>(reminderID);
    map['weekday'] = Variable<int>(weekday);
    return map;
  }

  ReminderWeekdaysTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderWeekdaysTableCompanion(
      id: Value(id),
      reminderID: Value(reminderID),
      weekday: Value(weekday),
    );
  }

  factory ReminderWeekdaysTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderWeekdaysTableData(
      id: serializer.fromJson<int>(json['id']),
      reminderID: serializer.fromJson<int>(json['reminderID']),
      weekday: serializer.fromJson<int>(json['weekday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reminderID': serializer.toJson<int>(reminderID),
      'weekday': serializer.toJson<int>(weekday),
    };
  }

  ReminderWeekdaysTableData copyWith({
    int? id,
    int? reminderID,
    int? weekday,
  }) => ReminderWeekdaysTableData(
    id: id ?? this.id,
    reminderID: reminderID ?? this.reminderID,
    weekday: weekday ?? this.weekday,
  );
  ReminderWeekdaysTableData copyWithCompanion(
    ReminderWeekdaysTableCompanion data,
  ) {
    return ReminderWeekdaysTableData(
      id: data.id.present ? data.id.value : this.id,
      reminderID: data.reminderID.present
          ? data.reminderID.value
          : this.reminderID,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderWeekdaysTableData(')
          ..write('id: $id, ')
          ..write('reminderID: $reminderID, ')
          ..write('weekday: $weekday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reminderID, weekday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderWeekdaysTableData &&
          other.id == this.id &&
          other.reminderID == this.reminderID &&
          other.weekday == this.weekday);
}

class ReminderWeekdaysTableCompanion
    extends UpdateCompanion<ReminderWeekdaysTableData> {
  final Value<int> id;
  final Value<int> reminderID;
  final Value<int> weekday;
  const ReminderWeekdaysTableCompanion({
    this.id = const Value.absent(),
    this.reminderID = const Value.absent(),
    this.weekday = const Value.absent(),
  });
  ReminderWeekdaysTableCompanion.insert({
    this.id = const Value.absent(),
    required int reminderID,
    required int weekday,
  }) : reminderID = Value(reminderID),
       weekday = Value(weekday);
  static Insertable<ReminderWeekdaysTableData> custom({
    Expression<int>? id,
    Expression<int>? reminderID,
    Expression<int>? weekday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderID != null) 'reminder_i_d': reminderID,
      if (weekday != null) 'weekday': weekday,
    });
  }

  ReminderWeekdaysTableCompanion copyWith({
    Value<int>? id,
    Value<int>? reminderID,
    Value<int>? weekday,
  }) {
    return ReminderWeekdaysTableCompanion(
      id: id ?? this.id,
      reminderID: reminderID ?? this.reminderID,
      weekday: weekday ?? this.weekday,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reminderID.present) {
      map['reminder_i_d'] = Variable<int>(reminderID.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderWeekdaysTableCompanion(')
          ..write('id: $id, ')
          ..write('reminderID: $reminderID, ')
          ..write('weekday: $weekday')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $ReminderTableTable reminderTable = $ReminderTableTable(this);
  late final $ReminderWeekdaysTableTable reminderWeekdaysTable =
      $ReminderWeekdaysTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    reminderTable,
    reminderWeekdaysTable,
  ];
}

typedef $$ReminderTableTableCreateCompanionBuilder =
    ReminderTableCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      Value<DateTime?> time,
    });
typedef $$ReminderTableTableUpdateCompanionBuilder =
    ReminderTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime?> time,
    });

final class $$ReminderTableTableReferences
    extends BaseReferences<_$Database, $ReminderTableTable, ReminderTableData> {
  $$ReminderTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ReminderWeekdaysTableTable,
    List<ReminderWeekdaysTableData>
  >
  _reminderWeekdaysTableRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.reminderWeekdaysTable,
        aliasName: $_aliasNameGenerator(
          db.reminderTable.id,
          db.reminderWeekdaysTable.reminderID,
        ),
      );

  $$ReminderWeekdaysTableTableProcessedTableManager
  get reminderWeekdaysTableRefs {
    final manager = $$ReminderWeekdaysTableTableTableManager(
      $_db,
      $_db.reminderWeekdaysTable,
    ).filter((f) => f.reminderID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reminderWeekdaysTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReminderTableTableFilterComposer
    extends Composer<_$Database, $ReminderTableTable> {
  $$ReminderTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reminderWeekdaysTableRefs(
    Expression<bool> Function($$ReminderWeekdaysTableTableFilterComposer f) f,
  ) {
    final $$ReminderWeekdaysTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reminderWeekdaysTable,
          getReferencedColumn: (t) => t.reminderID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReminderWeekdaysTableTableFilterComposer(
                $db: $db,
                $table: $db.reminderWeekdaysTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReminderTableTableOrderingComposer
    extends Composer<_$Database, $ReminderTableTable> {
  $$ReminderTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderTableTableAnnotationComposer
    extends Composer<_$Database, $ReminderTableTable> {
  $$ReminderTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  Expression<T> reminderWeekdaysTableRefs<T extends Object>(
    Expression<T> Function($$ReminderWeekdaysTableTableAnnotationComposer a) f,
  ) {
    final $$ReminderWeekdaysTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reminderWeekdaysTable,
          getReferencedColumn: (t) => t.reminderID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReminderWeekdaysTableTableAnnotationComposer(
                $db: $db,
                $table: $db.reminderWeekdaysTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReminderTableTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ReminderTableTable,
          ReminderTableData,
          $$ReminderTableTableFilterComposer,
          $$ReminderTableTableOrderingComposer,
          $$ReminderTableTableAnnotationComposer,
          $$ReminderTableTableCreateCompanionBuilder,
          $$ReminderTableTableUpdateCompanionBuilder,
          (ReminderTableData, $$ReminderTableTableReferences),
          ReminderTableData,
          PrefetchHooks Function({bool reminderWeekdaysTableRefs})
        > {
  $$ReminderTableTableTableManager(_$Database db, $ReminderTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
              }) => ReminderTableCompanion(
                id: id,
                title: title,
                description: description,
                time: time,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                Value<DateTime?> time = const Value.absent(),
              }) => ReminderTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                time: time,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReminderTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderWeekdaysTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reminderWeekdaysTableRefs) db.reminderWeekdaysTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reminderWeekdaysTableRefs)
                    await $_getPrefetchedData<
                      ReminderTableData,
                      $ReminderTableTable,
                      ReminderWeekdaysTableData
                    >(
                      currentTable: table,
                      referencedTable: $$ReminderTableTableReferences
                          ._reminderWeekdaysTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ReminderTableTableReferences(
                            db,
                            table,
                            p0,
                          ).reminderWeekdaysTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.reminderID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReminderTableTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ReminderTableTable,
      ReminderTableData,
      $$ReminderTableTableFilterComposer,
      $$ReminderTableTableOrderingComposer,
      $$ReminderTableTableAnnotationComposer,
      $$ReminderTableTableCreateCompanionBuilder,
      $$ReminderTableTableUpdateCompanionBuilder,
      (ReminderTableData, $$ReminderTableTableReferences),
      ReminderTableData,
      PrefetchHooks Function({bool reminderWeekdaysTableRefs})
    >;
typedef $$ReminderWeekdaysTableTableCreateCompanionBuilder =
    ReminderWeekdaysTableCompanion Function({
      Value<int> id,
      required int reminderID,
      required int weekday,
    });
typedef $$ReminderWeekdaysTableTableUpdateCompanionBuilder =
    ReminderWeekdaysTableCompanion Function({
      Value<int> id,
      Value<int> reminderID,
      Value<int> weekday,
    });

final class $$ReminderWeekdaysTableTableReferences
    extends
        BaseReferences<
          _$Database,
          $ReminderWeekdaysTableTable,
          ReminderWeekdaysTableData
        > {
  $$ReminderWeekdaysTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReminderTableTable _reminderIDTable(_$Database db) =>
      db.reminderTable.createAlias(
        $_aliasNameGenerator(
          db.reminderWeekdaysTable.reminderID,
          db.reminderTable.id,
        ),
      );

  $$ReminderTableTableProcessedTableManager get reminderID {
    final $_column = $_itemColumn<int>('reminder_i_d')!;

    final manager = $$ReminderTableTableTableManager(
      $_db,
      $_db.reminderTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reminderIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReminderWeekdaysTableTableFilterComposer
    extends Composer<_$Database, $ReminderWeekdaysTableTable> {
  $$ReminderWeekdaysTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  $$ReminderTableTableFilterComposer get reminderID {
    final $$ReminderTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderID,
      referencedTable: $db.reminderTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderTableTableFilterComposer(
            $db: $db,
            $table: $db.reminderTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderWeekdaysTableTableOrderingComposer
    extends Composer<_$Database, $ReminderWeekdaysTableTable> {
  $$ReminderWeekdaysTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReminderTableTableOrderingComposer get reminderID {
    final $$ReminderTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderID,
      referencedTable: $db.reminderTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderTableTableOrderingComposer(
            $db: $db,
            $table: $db.reminderTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderWeekdaysTableTableAnnotationComposer
    extends Composer<_$Database, $ReminderWeekdaysTableTable> {
  $$ReminderWeekdaysTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  $$ReminderTableTableAnnotationComposer get reminderID {
    final $$ReminderTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderID,
      referencedTable: $db.reminderTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderTableTableAnnotationComposer(
            $db: $db,
            $table: $db.reminderTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderWeekdaysTableTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ReminderWeekdaysTableTable,
          ReminderWeekdaysTableData,
          $$ReminderWeekdaysTableTableFilterComposer,
          $$ReminderWeekdaysTableTableOrderingComposer,
          $$ReminderWeekdaysTableTableAnnotationComposer,
          $$ReminderWeekdaysTableTableCreateCompanionBuilder,
          $$ReminderWeekdaysTableTableUpdateCompanionBuilder,
          (ReminderWeekdaysTableData, $$ReminderWeekdaysTableTableReferences),
          ReminderWeekdaysTableData,
          PrefetchHooks Function({bool reminderID})
        > {
  $$ReminderWeekdaysTableTableTableManager(
    _$Database db,
    $ReminderWeekdaysTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderWeekdaysTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReminderWeekdaysTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReminderWeekdaysTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reminderID = const Value.absent(),
                Value<int> weekday = const Value.absent(),
              }) => ReminderWeekdaysTableCompanion(
                id: id,
                reminderID: reminderID,
                weekday: weekday,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reminderID,
                required int weekday,
              }) => ReminderWeekdaysTableCompanion.insert(
                id: id,
                reminderID: reminderID,
                weekday: weekday,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReminderWeekdaysTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reminderID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reminderID,
                                referencedTable:
                                    $$ReminderWeekdaysTableTableReferences
                                        ._reminderIDTable(db),
                                referencedColumn:
                                    $$ReminderWeekdaysTableTableReferences
                                        ._reminderIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReminderWeekdaysTableTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ReminderWeekdaysTableTable,
      ReminderWeekdaysTableData,
      $$ReminderWeekdaysTableTableFilterComposer,
      $$ReminderWeekdaysTableTableOrderingComposer,
      $$ReminderWeekdaysTableTableAnnotationComposer,
      $$ReminderWeekdaysTableTableCreateCompanionBuilder,
      $$ReminderWeekdaysTableTableUpdateCompanionBuilder,
      (ReminderWeekdaysTableData, $$ReminderWeekdaysTableTableReferences),
      ReminderWeekdaysTableData,
      PrefetchHooks Function({bool reminderID})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$ReminderTableTableTableManager get reminderTable =>
      $$ReminderTableTableTableManager(_db, _db.reminderTable);
  $$ReminderWeekdaysTableTableTableManager get reminderWeekdaysTable =>
      $$ReminderWeekdaysTableTableTableManager(_db, _db.reminderWeekdaysTable);
}
