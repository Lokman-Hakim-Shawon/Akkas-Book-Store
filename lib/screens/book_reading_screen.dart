import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class BookReadingScreen extends StatefulWidget {
  final String pdfPath;
  final String bookTitle;

  const BookReadingScreen({
    super.key,
    required this.pdfPath,
    required this.bookTitle,
  });

  @override
  State<BookReadingScreen> createState() => _BookReadingScreenState();
}

class _BookReadingScreenState extends State<BookReadingScreen> {
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();

    pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.pdfPath),
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
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(
          widget.bookTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: PdfViewPinch(
        controller: pdfController,
        scrollDirection: Axis.vertical,
        padding: 8,
      ),
    );
  }
}
