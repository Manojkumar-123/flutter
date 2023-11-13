import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/widgets/pdf_item.dart';
import 'package:flutter/material.dart';

class HomeScreenDocuments extends StatefulWidget {
  const HomeScreenDocuments({super.key});

  @override
  State<HomeScreenDocuments> createState() => _HomeScreenDocumentsState();
}

class _HomeScreenDocumentsState extends State<HomeScreenDocuments> {
  @override
  void initState() {
    super.initState();
    getFromCloud();
  }

  bool isLoading = false;
  Map<String, String> fileUrls = {};

  void getFromCloud() async {
    setState(() {
      isLoading = true;
    });
    Reference storageFolder =
        FirebaseStorage.instance.ref('documents/q581gxaddZeD1f4gBxJEfjgKC4z2');

    try {
      final ListResult result = await storageFolder.listAll();
      for (final Reference ref in result.items) {
        String downloadURL = await ref.getDownloadURL();
        fileUrls[ref.name] = downloadURL;
      }
    } catch (e) {
      //some
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      height: 300,
      child: Card(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: PdfItem(files: fileUrls),
              ),
      ),
    );
  }
}
