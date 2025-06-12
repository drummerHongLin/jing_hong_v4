class Session {
  final int id;
  final String title;
  final String model;

  const Session({required this.id, required this.title, required this.model});

  factory Session.fromMap(Map<String, dynamic> m) {
    return Session(id: m['id'], title: m['title'], model: m['model']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'model': model};
  }
}
