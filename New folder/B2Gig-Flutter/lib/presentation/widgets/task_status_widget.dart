import 'package:flutter/material.dart';

class TaskStatusWidget extends StatelessWidget {
  final String status;

  TaskStatusWidget({@required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Row(
        children: [
          Text("Task Status: ",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.5),
          Text(status,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.5),
        ],
      ),
    );
  }
}
