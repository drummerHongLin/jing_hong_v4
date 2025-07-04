import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/service/db/chat_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDb extends ChatDb {
  // 创建单例对象
  static final SqliteDb _instance = SqliteDb._internal();
  factory SqliteDb() => _instance;
  SqliteDb._internal();

  // 获取数据库对象
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // 默认数据库路径
    String path = join(await getDatabasesPath(), 'jinghong.db');
    // 保证应用已经挂靠
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // 创建会话表
    await db.execute('''
      CREATE TABLE sessions(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        model TEXT NOT NULL,
        createTime TEXT NOT NULL
      )
    ''');

    // 创建消息表
    await db.execute('''
      CREATE TABLE messages(
        id TEXT PRIMARY KEY,
        mId INTEGER NOT NULL,
        content TEXT NOT NULL,
        role TEXT NOT NULL,
        state TEXT NOT NULL,
        showingContent TEXT NOT NULL,
        sendTime TEXT NOT NULL,
        sessionId TEXT NOT NULL,
        FOREIGN KEY (sessionId) REFERENCES sessions (id)
      )
    ''');
  }

  // 数据库的增删改查
  // 1. 插入会话

  @override
  Future<int> insertSession(List<Session> session) async {
    final db = await database;
    final batch = db.batch();
    
    for (var e in session) {
      batch.insert('sessions', e.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    }

   await batch.commit();
    
    

    return session.length;
  }

  // 2. 根据model获取session列表
  @override
  Future<List<Session>> getSessionsByModel(ChatModel model) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: "model = ?",
      whereArgs: [model.name],
    );
    return List.generate(maps.length, (i) => Session.fromMap(maps[i]));
  }

  // 3. 删除session
  @override
  Future<void> deleteSession(String id) async {
    final db = await database;
    await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
    await deleteMessagesBySessionId(id);
  }

  // 4. 插入消息
  @override
  Future<int> insertMessage(List<Message>  message) async {
    final db = await database;

     final batch = db.batch();

     for (var m in message) {
        batch.insert(
      'messages',
      m.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await batch.commit();

     }return message.length;
  }

  // 5. 通过会话id获取消息
  @override
  Future<List<Message>> getMessageBySessionId(String sessionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
    return List.generate(maps.length, (i) => Message.fromMap(maps[i]));
  }

  // 6. 通过会话id删除消息

  Future<void> deleteMessagesBySessionId(String sessionId) async {
    final db = await database;
    await db.delete('messages', where: 'sessionId = ?', whereArgs: [sessionId]);
  }

  // 关闭数据库链接
  @override
  Future<void> close() async {
    if(_database != null){
      await _database!.close();
    }
  }

  Future<void> truncate() async {
     final db = await database;
    await db.rawQuery("DELETE FROM sessions");
    await db.rawQuery("DELETE FROM messages");
  }
  
  @override
  Future<List<Message>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
    );
    return List.generate(maps.length, (i) => Message.fromMap(maps[i]));
  }
  
  @override
  Future<List<Session>> getAllSessions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
    );
    return List.generate(maps.length, (i) => Session.fromMap(maps[i]));
  }

}
