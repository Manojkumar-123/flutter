class Notes {
  final String nid;
  final String notes;
  final String title;
  final DateTime dateTime;

  const Notes(
      {required this.nid,
      required this.notes,
      required this.title,
      required this.dateTime});

  Map<String, dynamic> toJson() =>
      {"nid": nid, "notes": notes, "title": title, "date": dateTime};
}
