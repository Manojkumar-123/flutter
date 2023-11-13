import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/services/storage_service.dart';
import 'package:first_app/widgets/pdf_item.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  void addDocument(FilePickerResult result) async {
    const uuid = Uuid();
    final did = uuid.v4();
    await StorageService().addDocument(
        uid: FirebaseAuth.instance.currentUser!.uid,
        did: did,
        fileName: result.files.first.name,
        doc: result.files.first.path);
  }

  @override
  void initState() {
    super.initState();
    getFromCloud();
  }

  void getDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      addDocument(result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pick a valid PDF file. '),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  Map<String, String> fileUrls = {};
  bool isLoading = false;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
              onPressed: () {
                getDocument(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: PdfItem(files: fileUrls),
            ),
    );
  }
}
