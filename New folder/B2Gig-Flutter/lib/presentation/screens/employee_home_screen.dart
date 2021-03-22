import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:b2gig_flutter/data/user_tasks_model.dart';
import 'package:b2gig_flutter/presentation/widgets/jobs_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'job_home_screen.dart';
import 'login_screen.dart';

String userName;
List<Map<String, dynamic>> queryRows;

class EmployeeHomeScreen extends StatefulWidget {
  static const routeName = '/employee_home';
  @override
  State createState() => new EmployeeHomeState();
}

class EmployeeHomeState extends State<EmployeeHomeScreen> {
  Future getUserTasks() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? 0;
    print(userName);
    B2gigRepository repo = B2gigRepository();
    queryRows = await repo.getTasks(userName);
    print('QueryRows:');
    print(queryRows);
    return queryRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          // leading: Container(),
          title: Text("Dashboard"),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    LoginScreen.routeName,
                  );
                })
          ],
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: getUserTasks(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: queryRows.length,
                    itemBuilder: (context, position) {
                      UserTasksModel task = UserTasksModel(
                          queryRows[position]['id'],
                          queryRows[position]['userName'],
                          queryRows[position]['customerName'],
                          queryRows[position]['customerContact'],
                          queryRows[position]['Title'],
                          queryRows[position]['Date'],
                          queryRows[position]['Time'],
                          queryRows[position]['Hrs'],
                          queryRows[position]['shortAddress'],
                          queryRows[position]['longAddress'],
                          queryRows[position]['Status'],
                          queryRows[position]['Comments']);
                      return ListView(shrinkWrap: true, children: [
                        JobsDashboardWidget(
                            title: task.title,
                            address: task.shortAdd,
                            hours: task.hrs,
                            time: task.time,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, JobHomeScreen.routeName,
                                  arguments: task);
                            })
                      ]);
                    })
                : new CircularProgressIndicator();
          },
        )));
  }
}
