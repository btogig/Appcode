import 'package:b2gig_flutter/data/user_tasks_model.dart';
import 'package:b2gig_flutter/presentation/screens/employee_home_screen.dart';
import 'package:b2gig_flutter/presentation/screens/generate_invoice_screen.dart';
import 'package:b2gig_flutter/presentation/screens/job_completion_screen.dart';
import 'package:b2gig_flutter/presentation/screens/job_home_screen.dart';
import 'package:b2gig_flutter/presentation/screens/login_screen.dart';
import 'package:b2gig_flutter/presentation/screens/pdf_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case EmployeeHomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeeHomeScreen());
        break;
      case JobHomeScreen.routeName:
        var data = routeSettings.arguments as UserTasksModel;
        return MaterialPageRoute(builder: (_) => JobHomeScreen(data));
        break;
      case JobCompletionScreen.routeName:
        var data = routeSettings.arguments as UserTasksModel;
        return MaterialPageRoute(builder: (_) => JobCompletionScreen(data));
        break;
      case GenerateInvoice.routeName:
        return MaterialPageRoute(builder: (_) => GenerateInvoice());
        break;
      case PDFViewScreen.routeName:
        return MaterialPageRoute(builder: (_) => PDFViewScreen());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return null;
    }
  }
}
