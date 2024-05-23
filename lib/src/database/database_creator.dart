import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCreator {
  static Future<Database> createDatabase({required String dbName}) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print("Database created at: $path");
      },
    );
  }
}
// src/database/database_creator.dart
