import 'package:sqflite/sqflite.dart';

class TableCreator {
  static Future<void> createTable({
    required Database db,
    required String tableName,
    required Map<String, String> columns,
  }) async {
    // Ensure 'id' column is always included
    columns['id'] = 'INTEGER PRIMARY KEY';

    final columnDefinitions =
        columns.entries.map((e) => '${e.key} ${e.value}').join(', ');
    await db.execute('CREATE TABLE $tableName ($columnDefinitions)');
  }
}
// src/database/table_creator.dart
