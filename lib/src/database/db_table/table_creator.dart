import '../../../a0002_easy_sqlite_crud_op.dart';

class TableCreator {
  static Future<void> createTable(String tableName, List<String> fields) async {
    final db = await DatabaseCreator.database;
    try {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $tableName (${fields.join(', ')})');
      print("Table $tableName created successfully");
    } catch (ex) {
      print('Error creating table: $ex');
    }
  }
}
