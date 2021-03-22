import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

String contactNumber;

class NotifyCustomerWidget extends StatefulWidget {
  NotifyCustomerWidget({@required contactNumber});
  @override
  State createState() => new NotifyCustomerState();
}

class NotifyCustomerState extends State<NotifyCustomerWidget> {
  final Function onTapOnTheWay;
  final Function onTapHere;
  final double width;
  bool _enabledHere = false;
  bool _enabledWay = true;

  NotifyCustomerState({
    this.onTapOnTheWay,
    this.onTapHere,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    alertDialog(BuildContext context) {
      // This is the ok button
      Widget ok = FlatButton(
        child: Text("Okay"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      // show the alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notify Customer"),
            content: Text("SMS sent successfully!"),
            actions: [
              ok,
            ],
            elevation: 5,
          );
        },
      );
    }

    void _sendSMS(String message, List<String> recipents) async {
      String _result = await sendSMS(message: message, recipients: recipents)
          .catchError((onError) {
        print(onError);
      });
      print(_result);
    }

    onTheWayButton() {
      String message = "I'm on the way";
      List<String> recipients = ["4028808900"];
      print('Contact number: $contactNumber');
      // List<String> recipients = ["$contactNumber"];
      _sendSMS(message, recipients);
      // alertDialog(context);
      setState(() {
        _enabledHere = true;
        _enabledWay = false;
      });
    }

    iAmHereButton() {
      // SmsSender sender = SmsSender();
      // String address = '7066412424';
      //
      // SmsMessage message = SmsMessage(address, 'I am here');
      // message.onStateChanged.listen((state) {
      //   if (state == SmsMessageState.Sent) {
      //     print("SMS is sent!");
      //   } else if (state == SmsMessageState.Delivered) {
      //     print("SMS is delivered!");
      //   }
      // });
      // sender.sendSms(message);

      String message = "I'm on the way";
      List<String> recipients = ["4028808900"];
      // List<String> recipients = [contactNumber];
      _sendSMS(message, recipients);
      // alertDialog(context);
      setState(() {
        _enabledHere = false;
      });
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Notify Customer',
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.message_rounded, color: Colors.white),
                      iconSize: 35.0,
                    ),
                    Text(
                      "I'm on the way",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // height: 45.0,
                onPressed: _enabledWay ? () => onTheWayButton() : null,
                // () {
                // String message = "I'm on the way";
                // List<String> recipients = ["7066412424"];
                // _sendSMS(message, recipients);
                // alertDialog(context);
                // setState(() {
                //   _enabledHere = true;
                // });
                // }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.message_rounded, color: Colors.white),
                      iconSize: 35.0,
                    ),
                    Text(
                      "I'm here",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // height: 45.0,
                onPressed: _enabledHere ? () => iAmHereButton() : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
