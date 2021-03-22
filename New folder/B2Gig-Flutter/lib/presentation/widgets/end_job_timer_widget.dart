import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:flutter/material.dart';

class EndJobTimerWidget extends StatelessWidget {
  final String title;
  final String routeName;

  EndJobTimerWidget({@required this.title, @required this.routeName});
  Future updateStatusComments() async {
    B2gigRepository repo = B2gigRepository();
    // int result = await repo.updateStatusComments(row);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        height: 120.0,
        minWidth: double.infinity,
        color: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            routeName,
          );
        },
        textColor: Colors.white,
        child: Text(
          title,
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
    ));
  }
}
