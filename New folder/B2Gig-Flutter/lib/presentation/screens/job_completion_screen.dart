import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:b2gig_flutter/data/user_tasks_model.dart';
import 'package:flutter/material.dart';

import '../widgets/attachment_widget.dart';
import 'employee_home_screen.dart';
import 'generate_invoice_screen.dart';

UserTasksModel task;
TextEditingController commentsEditingController = TextEditingController();

class JobCompletionScreen extends StatefulWidget {
  static const routeName = '/job_completion';
  JobCompletionScreen(UserTasksModel data) {
    task = data;
  }
  @override
  State createState() => new JobCompletionScreenState();
}

class JobCompletionScreenState extends State<JobCompletionScreen> {
  int radioButtonGroup = 1;
  int updateResult = 0;

  Future updateStatusComments(BuildContext context) async {
    print('Inside update');
    print(commentsEditingController.text);
    print(radioButtonGroup);
    if (commentsEditingController.text.isNotEmpty) {
      task.comments = commentsEditingController.text;
    }
    if (radioButtonGroup == 1) {
      task.status = 'Pending';
    } else {
      task.status = 'Completed';
    }
    Map<String, dynamic> row = toMap(task);
    print('Row: $row');
    B2gigRepository repo = B2gigRepository();
    updateResult = await repo.updateStatusComments(row);
    if (updateResult == 1) {
      alertDialog(context, 'Successfully saved to database.');
    } else {
      alertDialog(context, 'Some error occurred while saving to database.');
    }
  }

  Map<String, dynamic> toMap(UserTasksModel task) {
    final map = Map<String, dynamic>();
    map['id'] = task.id;
    map['userName'] = task.userName;
    map['customerName'] = task.customerName;
    map['customerContact'] = task.customerContact;
    map['Title'] = task.title;
    map['Date'] = task.date;
    map['Time'] = task.time;
    map['Hrs'] = task.hrs;
    map['shortAddress'] = task.shortAdd;
    map['longAddress'] = task.longAdd;
    map['Status'] = task.status;
    map['Comments'] = task.comments;
    return map;
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   commentsEditingController.dispose();
  //   super.dispose();
  // }

  alertDialog(BuildContext context, String message) {
    // This is the ok button
    Widget ok = FlatButton(
      child: Text("Okay"),
      onPressed: () {
        // Navigator.of(context).pop();
        if (radioButtonGroup == 1) {
          Navigator.of(context).pushReplacementNamed(
            EmployeeHomeScreen.routeName,
          );
        } else {
          Navigator.of(context).pushReplacementNamed(
            GenerateInvoice.routeName,
          );
        }
      },
    );
    // show the alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Job Completion Process"),
          content: Text(message),
          actions: [
            ok,
          ],
          elevation: 5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Job Completion Process"),
      ),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.only(top: 40.0), children: [
          // JobStatusWidget(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text('Job status:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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
          ]),
          // CommentsWidget(),
          Container(
            // child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
                controller: commentsEditingController,
                decoration: new InputDecoration(
                  labelText: "Comments",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null),
            // ),
          ),
          AttachmentWidget(),
          SizedBox(height: 25),
          // EndJobTimerWidget(
          //   title: 'End Job',
          //   routeName: GenerateInvoice.routeName,
          // )
          Container(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaterialButton(
              height: 120.0,
              minWidth: double.infinity,
              color: Theme.of(context).accentColor,
              onPressed: () {
                updateStatusComments(context);
              },
              textColor: Colors.white,
              child: Text(
                'End Job',
                textScaleFactor: 1.5,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ),
          )),
        ]),
      ),
    );
  }
}
