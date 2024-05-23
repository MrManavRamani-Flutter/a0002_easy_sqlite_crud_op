import 'package:sqflite/sqflite.dart';

class TableCreator {
  static Future<void> createTable({
    required Database db,
    required String tableName,
    required List<String> columns,
  }) async {
    final columnDefinitions = columns.join(', ');
    await db.execute('CREATE TABLE $tableName ($columnDefinitions)');
  }
}
// src/database/table_creator.dart
