import 'package:b2gig_flutter/data/data_access_object.dart';

class B2gigRepository {
  final b2gigDao = DataAccessObject();

  Future getAuthDetails(String userName) => b2gigDao.getAuthDetails(userName);
  Future queryAllUsersDetails() => b2gigDao.queryAllUsersDetails();
  Future insertUsersDetails(Map<String, dynamic> row) =>
      b2gigDao.insertUsersDetails(row);
  Future insertAssignedTasks(Map<String, dynamic> row) =>
      b2gigDao.insertAssignedTasks(row);
  Future insertGenerateInvoice(Map<String, dynamic> row) =>
      b2gigDao.insertGenerateInvoice(row);
  Future getTasks(String userName) => b2gigDao.getTasks(userName);
  Future getInvoiceDetails(String taskTitle) =>
      b2gigDao.getInvoiceDetails(taskTitle);
  // Future updateStatusComments(Map<String, dynamic> row) => b2gigDao.update(row);
  Future updateStatusComments(Map<String, dynamic> row) => b2gigDao.update(row);
}
