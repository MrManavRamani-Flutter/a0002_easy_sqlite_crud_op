import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCreator {
  static const databaseName = 'dynamic_database.db';
  static late Database _database;

  static Future<Database> get database async {
    _database = await createDatabase();
    return _database;
  }

  static Future<Database> createDatabase() async {
    try {
      String path = join(await getDatabasesPath(), databaseName);
      var database = await openDatabase(path, version: 1, onCreate: _onCreate);
      return database;
    } catch (ex) {
      print('Error creating database: $ex');
      throw Exception('Failed to create database');
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Add code here to initialize tables or perform any other setup
    print("Database created successfully");
  }
}
