import 'package:b2gig_flutter/data/models/invoice_model.dart';
import 'package:b2gig_flutter/data/models/service_model.dart';
import 'package:b2gig_flutter/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;

enum ServiceType { SERVICE, EQUIPMENT }

class PDFWriter {
  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;
  static const baseColor = PdfColors.teal;
  static const accentColor = PdfColors.blueGrey900;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  // double get _total =>
  //     products.map<double>((p) => p.total).reduce((a, b) => a + b);

  // double get _grandTotal => _total * (1 + tax);

  String _logo;
  Invoice _invoice;

  writeFile(Invoice invoice) async {
    _invoice = invoice;
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
          header: _buildHeader,
          footer: _buildFooter,
          build: (pw.Context context) => [
                _contentHeader(context),
                if (invoice.laborList.length > 0)
                  _contentTable(
                      context, ServiceType.SERVICE, invoice.laborList),
                pw.SizedBox(height: 20),
                if (invoice.partsList.length > 0)
                  _contentTable(
                      context, ServiceType.EQUIPMENT, invoice.partsList),
                pw.SizedBox(height: 20),
                _contentFooter(context),
              ]),
    );

    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    new Directory(appDocDirectory.path+'/'+'Invoice').create(recursive: true)
// The created directory is returned as a Future.
        .then((Directory directory) async {
      print('Path of New Dir: '+ directory.path);
      var fileName = directory.path + '/' + invoice.invNumber;
      final file = File('$fileName.pdf');
      await file.writeAsBytes(await doc.save());
      return fileName;
    });
    // final file = File('${invoice.invNumber}.pdf');
    // await file.writeAsBytes(await doc.save());
    // return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(_invoice.invNumber),
                          pw.Text('Date:'),
                          pw.Text(_invoice.date),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child:
                        _logo != null ? pw.SvgImage(svg: _logo) : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Total Placeholder',
                // 'Total: ${formatCurrency(_grandTotal)}', // TODO: calculate
                style: pw.TextStyle(
                  color: baseColor,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                    text: pw.TextSpan(
                      text: '${_invoice.customer.name}\n',
                      style: pw.TextStyle(
                        color: _darkColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: _invoice.customer.address,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        pw.TextSpan(
                          text: _invoice.customer.contact,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        pw.TextSpan(
                          text: _invoice.customer.email,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for your business',
                style: pw.TextStyle(
                  // color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Sub Total:'),
                    // pw.Text(formatCurrency(_total)), // TODO: calculate
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    // pw.Text('${(tax * 100).toStringAsFixed(1)}%'), // TODO: calculate
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      // pw.Text(formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(
      pw.Context context, ServiceType type, List<Service> serviceList) {
    var tableHeaders;

    if (type == ServiceType.EQUIPMENT) {
      tableHeaders = ['Description', 'Hours', 'Price', 'Amount'];
    } else {
      tableHeaders = ['Description', 'Price', 'Quantity', 'Amount'];
    }

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.center,
        3: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        serviceList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => serviceList[row].getIndex(col),
        ),
      ),
    );
  }
}
