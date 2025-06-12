import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChatDb {
  // 创建单例对象
  static final ChatDb _instance = ChatDb._internal();
  factory ChatDb() => _instance;
  ChatDb._internal();

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
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        model TEXT NOT NULL
      )
    ''');

    // 创建消息表
    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY,
        mId INTEGER NOT NULL,
        content TEXT NOT NULL,
        role TEXT NOT NULL,
        state TEXT NOT NULL,
        showingContent TEXT NOT NULL,
        sendTime TEXT NOT NULL,
        sessionId INTEGER NOT NULL,
        FOREIGN KEY (sessionId) REFERENCES sessions (id)
      )
    ''');
  }

  // 数据库的增删改查
  // 1. 插入会话

  Future<int> insertSession(Session session) async {
    final db = await database;
    return await db.insert(
      'sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. 根据model获取session列表
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
  Future<void> deleteSession(int id) async {
    final db = await database;
    await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
  }

  // 4. 插入消息
  Future<int> insertMessage(Message message) async {
    final db = await database;
    return await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // 5. 通过会话id获取消息
  Future<List<Message>> getMessageBySessionId(int sessionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
    return List.generate(maps.length, (i) => Message.fromMap(maps[i]));
  }

  // 6. 通过会话id删除消息
  Future<void> deleteMessagesBySessionId(int sessionId) async {
    final db = await database;
    await db.delete('messages', where: 'sessionId = ?', whereArgs: [sessionId]);
  }

  // 关闭数据库链接
  Future<void> close() async {
    if(_database != null){
      await _database!.close();
    }
  }

}
