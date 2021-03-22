import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsWidget extends StatelessWidget {
  final String name;
  final Function onTapCall;

  CustomerDetailsWidget({@required this.name, this.onTapCall});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.account_box, color: Theme.of(context).primaryColor),
        iconSize: 35.0,
      ),
      title: Text(name,
          style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5),
      trailing: IconButton(
        icon: Icon(Icons.call, color: Theme.of(context).primaryColor),
        iconSize: 35.0,
        onPressed: () => launch("tel://7066412424"),
      ),
    );
  }
}
