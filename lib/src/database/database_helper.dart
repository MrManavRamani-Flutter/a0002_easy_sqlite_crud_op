import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_creator.dart';
import 'table_creator.dart';

class DatabaseHelper {
  static const String _dbName = 'ad.db';
  static const String _tableName = 'u_table';

  static Future<bool> isDatabaseCreated() async {
    final database = await DatabaseCreator.createDatabase(dbName: _dbName);
    return database.isOpen;
  }

  static Future<void> createDatabaseAndTable({
    required BuildContext context,
    required Map<String, String> columns,
  }) async {
    final isCreated = await isDatabaseCreated();
    if (isCreated) {
      final databasesPath = await getDatabasesPath();
      final databasePath = join(databasesPath, _dbName);
      print('Database created at: $databasePath');

      final database = await DatabaseCreator.createDatabase(dbName: _dbName);
      await TableCreator.createTable(
        db: database,
        tableName: _tableName,
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
    final database = await DatabaseCreator.createDatabase(dbName: _dbName);
    return await database.insert(_tableName, values);
  }

  static Future<List<Map<String, dynamic>>> queryAll() async {
    final database = await DatabaseCreator.createDatabase(dbName: _dbName);
    return await database.query(_tableName);
  }

  static Future<int> update({
    required Map<String, dynamic> values,
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    final database = await DatabaseCreator.createDatabase(dbName: _dbName);
    return await database.update(_tableName, values,
        where: whereClause, whereArgs: whereArgs);
  }

  static Future<int> delete({
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    final database = await DatabaseCreator.createDatabase(dbName: _dbName);
    return await database.delete(_tableName,
        where: whereClause, whereArgs: whereArgs);
  }
}
