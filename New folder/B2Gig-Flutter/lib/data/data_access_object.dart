import 'package:b2gig_flutter/data/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DataAccessObject {
  static final _userDetailsTable = 'usersDetails';
  static final _assignedTasksTable = 'assignedTasks';
  static final _generateInvoiceTable = 'generateInvoice';
  static final columnID = 'id';
  static final userNameColumn = 'userName';
  static final passwordColumn = 'Password';
  static final _invoiceTable = 'generateInvoice';
  static final taskNameColumn = 'Task';
  static final statusColumn = 'Status';

  final instance = DatabaseHelper.instance;

  Future<int> insertUsersDetails(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_userDetailsTable, row);
  }

  Future<int> insertAssignedTasks(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_assignedTasksTable, row);
  }

  Future<int> insertGenerateInvoice(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_generateInvoiceTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllUsersDetails() async {
    Database db = await instance.database;
    return await db.query(_userDetailsTable);
  }

  Future<List<Map<String, dynamic>>> queryAllAssignedTasks() async {
    Database db = await instance.database;
    return await db.query(_assignedTasksTable);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    return await db.update(
      _assignedTasksTable,
      row,
      where: '$columnID = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _userDetailsTable,
      where: '$columnID = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAuthDetails(String userName) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT $passwordColumn FROM $_userDetailsTable WHERE $userNameColumn = ?',
        ['$userName']);
  }

  Future<List<Map<String, dynamic>>> getTasks(String userName) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT * FROM $_assignedTasksTable WHERE $userNameColumn = ? and $statusColumn = ?',
        ['$userName', 'Pending']);
  }

  Future<List<Map<String, dynamic>>> getInvoiceDetails(String taskName) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT * FROM $_invoiceTable WHERE $taskNameColumn = ?',
        ['$taskName']);
  }
}
