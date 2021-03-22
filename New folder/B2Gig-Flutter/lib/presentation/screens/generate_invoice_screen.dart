import 'package:b2gig_flutter/data/b2gig_repository.dart';
import 'package:b2gig_flutter/data/invoice_details_model.dart';
import 'package:b2gig_flutter/data/models/customer_model.dart';
import 'package:b2gig_flutter/data/models/invoice_model.dart';
import 'package:b2gig_flutter/data/models/service_model.dart';
import 'package:b2gig_flutter/presentation/screens/pdf_view_screen.dart';
import 'package:b2gig_flutter/utils/pdf_generator.dart';
import 'package:b2gig_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee_home_screen.dart';

List<Map<String, dynamic>> queryRows;

class GenerateInvoice extends StatefulWidget {
  static const routeName = '/generate_invoice';

  @override
  State createState() => new GenerateInvoiceState();
}

class GenerateInvoiceState extends State<GenerateInvoice> {
  Future getInvoiceDetails() async {
    String taskName = 'Plumbing';
    B2gigRepository repo = B2gigRepository();
    queryRows = await repo.getInvoiceDetails(taskName);
    print('Invoice Details: ');
    print(queryRows);
    return queryRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Generate Invoice"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            FutureBuilder(
              future: getInvoiceDetails(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: queryRows.length,
                            itemBuilder: (context, position) {
                              InvoiceDetailsModel details = InvoiceDetailsModel(
                                queryRows[position]['_id'],
                                queryRows[position]['Task'],
                                queryRows[position]['Details'],
                                queryRows[position]['Cost'],
                              );
                              return ListView(shrinkWrap: true, children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          details.details,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.5,
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 80,
                                          height: 40,
                                          child: TextField(
                                            controller: TextEditingController()
                                              ..text = details.cost,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]);
                            }),
                      )
                    : new CircularProgressIndicator();
              },
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                height: 45.0,
                child: Text(
                  "Generate Invoice",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  // TODO: call generate invoice PDF
                  PDFWriter writer = PDFWriter();
                  final file = await writer.writeFile(
                    Invoice(
                      invNumber: generateInvoiceNumber(DateTime.now().toString()),
                      customer: Customer(
                        address: '54 rue de Rivoli\n75001 Paris, France',
                        contact: '+1 235 456',
                        email: 'ab.swe@outlook.fr',
                        name: 'Abraham Swearegin',
                      ),
                      date: formatDate(DateTime.now()),
                      laborList: <Labor>[
                        Labor('description', 23.4, 2, 46.8, 0.0),
                      ],
                      partsList: <Parts>[
                        Parts('description', 23.4, 2, 46.8, 0.0),
                        Parts('description', 23.4, 2, 46.8, 0.0),
                        Parts('description', 23.4, 2, 46.8, 0.0),
                      ],
                    )
                  );

                  Navigator.of(context).pushReplacementNamed(
                    PDFViewScreen.routeName,
                    arguments: file,
                  );
                  print('Push');
                }),
          ],
        )));
  }
}
