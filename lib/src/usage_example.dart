import 'package:flutter/material.dart';

import 'database/database_creator.dart';
import 'database/db_table/table_creator.dart';
import 'notification_manager/notification_manager.dart';

void main() async {
  runApp(const MyApp());
}

Future<void> createDatabaseAndTable(BuildContext context) async {
  final database = await DatabaseCreator.createDatabase();
  if (database != null) {
    await TableCreator.createTable(
        'example_table', ['id INTEGER PRIMARY KEY', 'name TEXT']);
    NotificationManager.showNotification(
        context, 'Database and table created successfully');
  } else {
    NotificationManager.showNotification(context, 'Error creating database');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await createDatabaseAndTable(context); // Pass context here
            },
            child: const Text('Create Database and Table'),
          ),
        ),
      ),
    );
  }
}
