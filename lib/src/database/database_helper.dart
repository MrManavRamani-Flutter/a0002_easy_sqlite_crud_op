import 'package:a0002_easy_sqlite_crud_op/a0002_easy_sqlite_crud_op.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<bool> isDatabaseCreated({required String dbName}) async {
    final database = await DatabaseCreator.createDatabase(dbName: dbName);
    return database.isOpen;
  }

  static Future<void> createDatabaseAndTable({
    required BuildContext context,
    required String dbName,
    required String tableName,
    required Map<String, String> columns,
  }) async {
    final isCreated = await isDatabaseCreated(dbName: dbName);
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
}
// src/database/database_helper.dart
