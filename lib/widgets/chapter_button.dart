import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../utils/pdf_utils.dart';

class ChapterButton extends StatelessWidget {
  final Chapter chapter;

  const ChapterButton({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        PdfUtils.openPdf(context, chapter.filePath);
      },
      child: Text(chapter.title),
    );
  }
}