import 'package:flutter/material.dart';

class JobsDashboardWidget extends StatelessWidget {
  final String title;
  final String time;
  final String hours;
  final String address;
  final Function onTap;

  JobsDashboardWidget(
      {@required this.title,
      @required this.time,
      @required this.hours,
      @required this.address,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Card(
        elevation: 2.0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        time,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '($hours)',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        address,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
