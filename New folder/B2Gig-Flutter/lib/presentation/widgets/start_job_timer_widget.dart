import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:b2gig_flutter/data/user_tasks_model.dart';
import 'package:flutter/material.dart';

class StartJobTimerWidget extends StatelessWidget {
  final String buttonLabel;
  final String routeName;
  UserTasksModel task;

  StartJobTimerWidget(
      {@required this.buttonLabel,
      @required this.routeName,
      @required this.task});
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
          updateStatusComments();
          Navigator.of(context).pushNamed(
            routeName,
            arguments: task,
          );
        },
        textColor: Colors.white,
        child: Text(
          buttonLabel,
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
    ));
  }
}
