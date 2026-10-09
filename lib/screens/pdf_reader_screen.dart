import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfReaderScreen extends StatefulWidget {
  const PdfReaderScreen({super.key});

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();

    pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/pdfs/poetry.pdf'),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আমার প্রিয় কবিতা'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: PdfViewPinch(controller: pdfController),
    );
  }
}
