import 'package:b2gig_flutter/data/user_tasks_model.dart';
import 'package:b2gig_flutter/presentation/widgets/customer_details_widget.dart';
import 'package:b2gig_flutter/presentation/widgets/job_header_widget.dart';
import 'package:b2gig_flutter/presentation/widgets/notify_customer_widget.dart';
import 'package:b2gig_flutter/presentation/widgets/task_status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/start_job_timer_widget.dart';
import 'job_completion_screen.dart';

UserTasksModel task;

class JobHomeScreen extends StatefulWidget {
  static const routeName = '/job_home';

  JobHomeScreen(UserTasksModel data) {
    task = data;
  }

  @override
  State createState() => JobHomeScreenState();
}

class JobHomeScreenState extends State<JobHomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("hhhhhhhhhhhhhhhhhhhhhhhhh");
    print(task);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Job'),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              JobHeaderWidget(
                title: task.title,
                date: task.date,
                time: task.time,
                address: task.longAdd,
              ),
              SizedBox(height: 15.0),
              TaskStatusWidget(status: task.status),
              SizedBox(height: 12.0),
              Divider(
                thickness: 3.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              CustomerDetailsWidget(name: task.customerName),
              Divider(
                thickness: 3.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              NotifyCustomerWidget(contactNumber: task.customerContact),

              // SizedBox(height: 8.0),
              Divider(
                thickness: 3.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              // SizedBox(height: 6.0),
              StartJobTimerWidget(
                buttonLabel: 'Start Job',
                routeName: JobCompletionScreen.routeName,
                task: task,
              )
            ],
          ),
        ));
  }
}
