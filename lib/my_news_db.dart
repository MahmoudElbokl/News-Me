import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:news_me/utilites.dart';

class MyNewsTopicsDb {
  Database _db;
  final String _sourcesTable = "sourcestable";
  final String _id = "id";
  final String _topicIndex = "topicindex";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Todo.dp");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_sourcesTable($_id INTEGER PRIMARY KEY, $_topicIndex INTEGER)");
  }

  Future<int> saveTopic(int id) async {
    Database dbClient = await db;
    Map<String, int> toMap = {_topicIndex: id};
    int res = await dbClient.insert(_sourcesTable, toMap);
    dpChanged = true;
    return res;
  }

  Future<List> getAllSavedTopics() async {
    var dbClient = await db;
    List allItems = await dbClient.query("$_sourcesTable");
    return allItems;
  }

  Future<int> deleteTable() async {
    var dbClient = await db;
    return await dbClient.delete("$_sourcesTable");
  }
}
