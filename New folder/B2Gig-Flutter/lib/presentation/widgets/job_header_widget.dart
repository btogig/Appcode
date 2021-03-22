import 'package:flutter/material.dart';

class JobHeaderWidget extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String address;

  JobHeaderWidget(
      {@required this.title,
      @required this.date,
      @required this.time,
      @required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 2.0,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.calendar_today_outlined,
                          color: Colors.redAccent)),
                  Text(date, style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.access_time, color: Colors.redAccent)),
                  Text(time, style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.location_on_outlined,
                          color: Colors.redAccent)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(address,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
