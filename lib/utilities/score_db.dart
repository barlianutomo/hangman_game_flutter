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
        "CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT, userScore INTEGER)",
      );
    },
    version: 1,
  );
  return database;
}

Future<void> insertScore(Score score, final database) async {
  final Database db = await database;

  await db.insert(
    'scores',
    score.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<List<Score>> scores(final database) async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('scores');

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
    'scores',
    score.toMap(),
    where: "id = ?",
    whereArgs: [score.id],
  );
}

Future<void> deleteScore(int id, final database) async {
  final db = await database;

  await db.delete(
    'scores',
    where: "id = ?",
    whereArgs: [id],
  );
}

void manipulateDatabase(Score scoreObject, final database) async {
  await insertScore(scoreObject, database);
  List<Score> data = await scores(database);
  debugPrint(data.toString());
}
