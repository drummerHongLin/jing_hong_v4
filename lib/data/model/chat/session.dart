class Session {
  final String id;
  final String title;
  final String model;
  final String createTime;

  const Session( {required this.id, required this.title, required this.model,required this.createTime,});

  factory Session.fromMap(Map<String, dynamic> m) {
    return Session(id: m['id'], title: m['title'], model: m['model'], createTime:m['createTime']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'model': model,'createTime':createTime};
  }
}
