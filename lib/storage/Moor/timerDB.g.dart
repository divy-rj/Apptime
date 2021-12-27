// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timerDB.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final String appname;
  final DateTime dueDate;
  final bool completed;
  Task({@required this.appname, this.dueDate, @required this.completed});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      appname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}appname']),
      dueDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || appname != null) {
      map['appname'] = Variable<String>(appname);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      appname: appname == null && nullToAbsent
          ? const Value.absent()
          : Value(appname),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      appname: serializer.fromJson<String>(json['appname']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appname': serializer.toJson<String>(appname),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  Task copyWith({String appname, DateTime dueDate, bool completed}) => Task(
        appname: appname ?? this.appname,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('appname: $appname, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(appname.hashCode, $mrjc(dueDate.hashCode, completed.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.appname == this.appname &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> appname;
  final Value<DateTime> dueDate;
  final Value<bool> completed;
  const TasksCompanion({
    this.appname = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TasksCompanion.insert({
    @required String appname,
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  }) : appname = Value(appname);
  static Insertable<Task> custom({
    Expression<String> appname,
    Expression<DateTime> dueDate,
    Expression<bool> completed,
  }) {
    return RawValuesInsertable({
      if (appname != null) 'appname': appname,
      if (dueDate != null) 'due_date': dueDate,
      if (completed != null) 'completed': completed,
    });
  }

  TasksCompanion copyWith(
      {Value<String> appname, Value<DateTime> dueDate, Value<bool> completed}) {
    return TasksCompanion(
      appname: appname ?? this.appname,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appname.present) {
      map['appname'] = Variable<String>(appname.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('appname: $appname, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _appnameMeta = const VerificationMeta('appname');
  GeneratedColumn<String> _appname;
  @override
  GeneratedColumn<String> get appname =>
      _appname ??= GeneratedColumn<String>('appname', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedColumn<DateTime> _dueDate;
  @override
  GeneratedColumn<DateTime> get dueDate =>
      _dueDate ??= GeneratedColumn<DateTime>('due_date', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedColumn<bool> _completed;
  @override
  GeneratedColumn<bool> get completed =>
      _completed ??= GeneratedColumn<bool>('completed', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (completed IN (0, 1))',
          defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [appname, dueDate, completed];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('appname')) {
      context.handle(_appnameMeta,
          appname.isAcceptableOrUnknown(data['appname'], _appnameMeta));
    } else if (isInserting) {
      context.missing(_appnameMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {appname};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    return Task.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}
