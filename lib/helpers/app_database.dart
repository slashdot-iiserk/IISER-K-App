import "package:sqflite/sqflite.dart";
import "dart:async";
import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import 'package:iiserk_app/models/lms_category.dart';
import "package:iiserk_app/utils/constants.dart";

class AppDatabase {
  static AppDatabase? appDatabase; // Singleton DatabaseHelper
  static Database? appDb; // Singleton Database

  AppDatabase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory AppDatabase() {
    if (appDatabase == null) {
      appDatabase = AppDatabase
          ._createInstance(); // This is executed only once, singleton object
    }
    return appDatabase!;
  }

  Future<Database> get database async {
    if (appDb == null) {
      appDb = await initializeDatabase();
    }
    return appDb!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, 'LearnAtHome.db');

    // Open/create the database at a given path
    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(Queries.createCategoriesTable);
    await db.execute(Queries.createCoursesTable);
  }

  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await this.database;

    var result =
        await db.query(Tables.categories, orderBy: Columns.id + " ASC");
    return result;
  }

  Future<int> insertCategory(LmsCategory category) async {
    Database db = await this.database;
    var result = await db.insert(Tables.categories, category.toMap());
    return result;
  }

  Future<int> updateCategory(LmsCategory category) async {
    var db = await this.database;
    var result = await db.update(Tables.categories, category.toMap(),
        where: Columns.id + " = ?", whereArgs: [category.id]);
    return result;
  }
}
