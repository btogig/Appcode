import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = "b2gigDatabase.db";
  static final _dbVersion = 1;
  static final _userDetailsTable = 'usersDetails';
  static final _assignedTasksTable = 'assignedTasks';
  static final columnID = 'id';
  static final userNameColumn = 'userName';
  static final passwordColumn = 'Password';
  static final dateColumn = 'Date';
  static final timeColumn = 'Time';
  static final hrsColumn = 'Hrs';
  static final titleColumn = 'Title';
  static final shortAddColumn = 'shortAddress';
  static final longAddColumn = 'longAddress';
  static final custNameColumn = 'customerName';
  static final _invoiceTable = 'generateInvoice';
  static final taskName = 'Task';
  static final details = 'Details';
  static final cost = 'Cost';
  static final statusColumn = 'Status';
  static final commentsColumn = 'Comments';
  static final custContactColumn = 'customerContact';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _intiateDatabase();
    return _database;
  }

  _intiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_userDetailsTable (
      $userNameColumn TEXT PRIMARY KEY,
      $passwordColumn TEXT NOT NULL)
      ''');
    db.execute('''
      CREATE TABLE $_assignedTasksTable (
      $columnID INTEGER PRIMARY KEY,
      $userNameColumn TEXT NOT NULL,
      $custNameColumn TEXT NOT NULL,
      $custContactColumn TEXT NOT NULL,
      $titleColumn TEXT NOT NULL,
      $dateColumn TEXT NOT NULL,
      $timeColumn TEXT NOT NULL,
      $hrsColumn TEXT NOT NULL,
      $shortAddColumn TEXT NOT NULL,
      $longAddColumn TEXT NOT NULL,
      $statusColumn TEXT NOT NULL, 
      $commentsColumn TEXT
      )
      ''');
    db.execute('''
      CREATE TABLE $_invoiceTable (
      $columnID INTEGER PRIMARY KEY,
      $taskName TEXT NOT NULL,
      $details TEXT NOT NULL, 
      $cost TEXT NOT NULL)
      ''');
  }
}
