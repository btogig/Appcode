import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:b2gig_flutter/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

import 'data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  B2gigRepository repo = B2gigRepository();
  List<Map<String, dynamic>> queryRows = await repo.queryAllUsersDetails();

  if (queryRows.isEmpty) {
    int id = await repo.insertUsersDetails({
      DatabaseHelper.userNameColumn: 'user1',
      DatabaseHelper.passwordColumn: '123',
    });
    print('Inserted id is $id');

    id = await repo.insertAssignedTasks({
      DatabaseHelper.userNameColumn: 'user1',
      DatabaseHelper.custNameColumn: 'Mike',
      DatabaseHelper.custContactColumn: '7066412424',
      DatabaseHelper.titleColumn: 'Fertilization',
      DatabaseHelper.dateColumn: 'Mon, Nov 23, 2020',
      DatabaseHelper.timeColumn: '10:00 AM',
      DatabaseHelper.hrsColumn: '1 hr',
      DatabaseHelper.shortAddColumn: '72 Dodge St, Omaha NE',
      DatabaseHelper.longAddColumn:
          '929, APT # 2, 72nd and Pacific St, Omaha, NE 68106',
      DatabaseHelper.statusColumn: 'Pending',
      // DatabaseHelper.commentsColumn: '',
    });
    print('Inserted id is $id');

    id = await repo.insertAssignedTasks({
      DatabaseHelper.userNameColumn: 'user1',
      DatabaseHelper.custNameColumn: 'Jim',
      DatabaseHelper.custContactColumn: '7066412424',
      DatabaseHelper.titleColumn: 'Plumbing',
      DatabaseHelper.dateColumn: 'Mon, Nov 23, 2020',
      DatabaseHelper.timeColumn: '02:00 PM',
      DatabaseHelper.hrsColumn: '1 hr',
      DatabaseHelper.shortAddColumn: '72 Dodge St, Omaha NE',
      DatabaseHelper.longAddColumn:
          '929, APT # 2, 72nd and Pacific St, Omaha, NE 68106',
      DatabaseHelper.statusColumn: 'Pending',
      // DatabaseHelper.commentsColumn: '',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Plumbing',
      DatabaseHelper.details: 'Visiting Fees',
      DatabaseHelper.cost: '\$ 45',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Plumbing',
      DatabaseHelper.details: 'Basic Cost',
      DatabaseHelper.cost: '\$ 95',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Plumbing',
      DatabaseHelper.details: 'Material Cost',
      DatabaseHelper.cost: '\$ 70',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Fertilization',
      DatabaseHelper.details: 'Visiting Fees',
      DatabaseHelper.cost: '\$ 45',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Fertilization',
      DatabaseHelper.details: 'Basic Cost',
      DatabaseHelper.cost: '\$ 105',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Fertilization',
      DatabaseHelper.details: 'Material Cost',
      DatabaseHelper.cost: '\$ 130',
    });
    print('Inserted id is $id');

    id = await repo.insertGenerateInvoice({
      DatabaseHelper.taskName: 'Fertilization',
      DatabaseHelper.details: 'Additional Fees',
      DatabaseHelper.cost: '\$ 30',
    });
    print('Inserted id is $id');
  } else {
    print('No need to add data');
  }

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // home: new LoginScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey[700],
        accentColor: Colors.amber[600],
        backgroundColor: Colors.grey[100],
        // disabledColor: Colors.blueGrey[200],
      ),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
