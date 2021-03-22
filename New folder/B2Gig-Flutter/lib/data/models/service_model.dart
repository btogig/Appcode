import 'package:b2gig_flutter/utils/utils.dart';

class Service{
  final String description;
  final double amount, price;
  final double tax;

  const Service(this.description, this.price, this.amount, this.tax);

  getIndex(int index) {
    switch (index) {
      case 0:
        return description;
      case 1:
        return formatCurrency(price);
      case 2:
        return formatCurrency(amount);
      case 3:
        return formatCurrency(tax);
    }
    return '';
  }

}

class Labor extends Service{

  final int hours;

  const Labor(String description, double price, int hours, double amount, double tax) : hours = hours, super(description, price, amount, tax);

  String getIndex(int index) {
    switch (index) {
      case 0:
        return description;
      case 1:
        return formatCurrency(price);
      case 2:
        return hours.toString();
      case 3:
        return formatCurrency(amount);
      case 4:
        return formatCurrency(tax);
    }
    return '';
  }
}

class Parts extends Service{
  final int quantity;

  const Parts(String description, double price, int quantity, double amount, double tax) : quantity = quantity, super(description, price, amount, tax);

  String getIndex(int index) {
    switch (index) {
      case 0:
        return description;
      case 1:
        return formatCurrency(price);
      case 2:
        return quantity.toString();
      case 3:
        return formatCurrency(amount);
      case 4:
        return formatCurrency(tax);
    }
    return '';
  }
}