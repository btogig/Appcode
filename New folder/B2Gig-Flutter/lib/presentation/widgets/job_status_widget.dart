import 'package:flutter/material.dart';

// TextEditingController commentsEditingController = TextEditingController();

class JobStatusWidget extends StatefulWidget {
  @override
  State createState() => new JobStatusWidgetState();
}

class JobStatusWidgetState extends State<JobStatusWidget> {
  int radioButtonGroup = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Job status:',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Radio(
                value: 1,
                groupValue: radioButtonGroup,
                onChanged: (T) {
                  print(T);

                  setState(() {
                    radioButtonGroup = T;
                  });
                },
              ),
              Text(
                'Pending',
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: 0,
                groupValue: radioButtonGroup,
                onChanged: (T) {
                  print(T);

                  setState(() {
                    radioButtonGroup = T;
                  });
                },
              ),
              Text(
                'Completed',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]));
  }
}
