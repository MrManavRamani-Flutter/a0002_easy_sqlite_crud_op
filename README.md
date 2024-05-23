# SQLite CRUD Operations in Flutter

This Flutter project demonstrates how to perform SQLite CRUD operations using the `a0002_easy_sqlite_crud_op` package. The project includes code for creating a database and tables dynamically with named parameters and default primary keys.

## Dependencies

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  a0002_easy_sqlite_crud_op:
    git:
      url: https://github.com/MrManavRamani-Flutter/a0002_easy_sqlite_crud_op.git
      ref: master
```

## Usage
### Example Code
Below is a complete example of how to use the provided package to create a database and a table in a Flutter app:

### Step-by-Step Explanation
### 1. Import Packages:

```dart
import 'package:a0002_easy_sqlite_crud_op/a0002_easy_sqlite_crud_op.dart';
import 'package:flutter/material.dart';

```

a0002_easy_sqlite_crud_op is the custom package for SQLite operations.
flutter/material.dart is used to build the UI.


## Example For Create Database, Table, Column Filed :

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await DatabaseHelper.createDatabaseAndTable(
              context: context,
              dbName: 'man_db.db',
              tableName: 'manav',
              columns: {
                'name': 'TEXT',
                'city': 'TEXT',
              },
            );
          },
          child: const Text('Create Database and Table'),
        ),
      ),
    );
  }
}

```

#### HomeScreen is a StatelessWidget that serves as the main screen.
#### It uses a Scaffold to provide a basic structure with an AppBar and a centered button.
#### When the button is pressed, it calls DatabaseHelper.createDatabaseAndTable to create the database and table.
