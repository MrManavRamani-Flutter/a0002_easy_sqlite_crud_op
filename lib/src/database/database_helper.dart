import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_creator.dart';
import 'table_creator.dart';

class DatabaseHelper {
  static late final String dbName;
  static late final String tableName;

  static Future<bool> isDatabaseCreated(dbName, tableName) async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return database.isOpen;
  }

  static Future<void> createDatabaseAndTable({
    required BuildContext context,
    required String dbName,
    required String tableName,
    required Map<String, String> columns,
  }) async {
    dbName = dbName ?? 'default.db';
    tableName = tableName ?? 'default_table';
    final isCreated = await isDatabaseCreated(dbName, tableName);
    if (isCreated) {
      final databasesPath = await getDatabasesPath();
      final databasePath = join(databasesPath, dbName);
      print('Database created at: $databasePath');

      final database = await DatabaseCreator.createDatabase(dbName: dbName);
      await TableCreator.createTable(
        db: database,
        tableName: tableName,
        columns: columns,
      );

      Fluttertoast.showToast(
        msg: 'Database and table created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Error creating database',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  static Future<int> insert({
    required Map<String, dynamic> values,
  }) async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return await database.insert(tableName, values);
  }

  static Future<List<Map<String, dynamic>>> queryAll() async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return await database.query(tableName);
  }

  static Future<int> update({
    required Map<String, dynamic> values,
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return await database.update(tableName, values,
        where: whereClause, whereArgs: whereArgs);
  }

  static Future<int> delete({
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return await database.delete(tableName,
        where: whereClause, whereArgs: whereArgs);
  }
}
