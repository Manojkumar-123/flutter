import 'dart:io';

import 'package:first_app/pages/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PdfItem extends StatelessWidget {
  const PdfItem({super.key, required this.files});

  final Map<String, String> files;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (ctx, index) => Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          onTap: () {},
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(files.keys.elementAt(index)),
                  ],
                )),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
