class Notes {
  final String nid;
  final String notes;
  final String title;

  const Notes({required this.nid, required this.notes, required this.title});

  Map<String, dynamic> toJson() => {"nid": nid, "notes": notes, "title": title};
}
