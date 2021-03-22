import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewScreen extends StatefulWidget {
  static const routeName = '/pdf_view_screen';

  @override
  _PDFViewScreenState createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  bool _isLoading = true;
  PDFDocument document;

  // @override
  // void initState() {
  //   super.initState();
  //   loadDocument();
  // }

  loadDocument(String file) async {
    document = await PDFDocument.fromAsset('$file.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    loadDocument(args);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Invoice'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
        :PDFViewer(
          document: document,
          zoomSteps: 1,
        ),
      ),
    );
  }
}
