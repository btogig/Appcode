import 'package:b2gig_flutter/data/models/customer_model.dart';
import 'package:b2gig_flutter/data/models/service_model.dart';

class Invoice{
  final String invNumber, date;
  final Customer customer;
  final List<Labor> laborList;
  final List<Parts> partsList;

  Invoice({this.invNumber, this.date, this.customer, this.laborList, this.partsList});
}