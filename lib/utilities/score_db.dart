import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hangman/utilities/user_scores.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'scores_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE score(id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT, userScore INTEGER)",
      );
    },
    version: 1,
  );
  return database;
}

Future<void> insertScore(Score score, final database) async {
  final Database db = await database;

  await db.insert(
    'score',
    score.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<List<Score>> score(final database) async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('score');

  return List.generate(maps.length, (i) {
    return Score(
      id: maps[i]['id'],
      scoreDate: maps[i]['scoreDate'],
      userScore: maps[i]['userScore'],
    );
  });
}

Future<void> updateScore(Score score, final database) async {
  final db = await database;

  await db.update(
    'score',
    score.toMap(),
    where: "id = ?",
    whereArgs: [score.id],
  );
}

Future<void> deleteScore(int id, final database) async {
  final db = await database;

  await db.delete(
    'score',
    where: "id = ?",
    whereArgs: [id],
  );
}

void manipulateDatabase(Score scoreObject, final database) async {
  await insertScore(scoreObject, database);
  List<Score> data = await score(database);
  debugPrint(data.toString());
}
