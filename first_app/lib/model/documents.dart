import 'dart:typed_data';

class Documents {
  final String did;
  final String uid;
  final Uint8List document;

  const Documents(
      {required this.did, required this.uid, required this.document});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "did": did,
        "document": document,
      };
}
