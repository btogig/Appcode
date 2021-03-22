import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'employee_home_screen.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController passEditingController = TextEditingController();
TextEditingController userEditingController = TextEditingController();

class LoginScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    userEditingController.clear();
    passEditingController.clear();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // FlutterLogo(
                      //   size: 120.0,
                      // ),
                      Image.asset(
                        'assets/images/b2gig_logo.png',
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "B2Gig",
                        textAlign: TextAlign.center,
                        textScaleFactor: 5.0,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: userEditingController,
                        decoration: new InputDecoration(
                          labelText: "Username",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        // onSaved: (String value) {
                        //   password = value;
                        // },
                        controller: passEditingController,
                        decoration: new InputDecoration(
                          labelText: "Password",
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.0),
                      new FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Theme.of(context).primaryColor,
                        height: 45.0,
                        minWidth: 200.0,
                        onPressed: () async {
                          // DataAccessObject dao = DataAccessObject();
                          B2gigRepository repo = B2gigRepository();
                          if (_formKey.currentState.validate()) {
                            List<Map<String, dynamic>> queryRows =
                                await repo.getAuthDetails(
                                    userEditingController.text.trim());
                            if (queryRows.isEmpty) {
                              print('IF BLOCK');
                              final snackBar = SnackBar(
                                content: Text(
                                    'Could not find a user with this username.'),
                                backgroundColor: Colors.black54,
                                behavior: SnackBarBehavior.floating,
                              );
                              _scaffoldKey.currentState.showSnackBar(
                                snackBar,
                              );
                            } else {
                              print('ELSE BLOCK');
                              print(queryRows);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('userName',
                                  userEditingController.text.trim());
                              if (passEditingController.text ==
                                  queryRows[0]['Password']) {
                                Navigator.of(context).pushReplacementNamed(
                                  EmployeeHomeScreen.routeName,
                                );
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Invalid password.'),
                                  backgroundColor: Colors.black54,
                                  behavior: SnackBarBehavior.floating,
                                );
                                _scaffoldKey.currentState.showSnackBar(
                                  snackBar,
                                );
                              }
                            }
                          }
                        },
                        child: new Text(
                          "Login",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
