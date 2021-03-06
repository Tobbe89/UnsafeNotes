import 'package:unsafenote/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDb {
  static final NoteDb instance = NoteDb._init();

  static Database? _database;

  NoteDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('note.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);

    return await openDatabase(
      path,
      onConfigure: onConfigure,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    const primaryIdType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNote (
      ${NoteFields.id} $primaryIdType,
      ${NoteFields.header} $textTypeNull, 
      ${NoteFields.content} $textType,
      ${NoteFields.createdTime} $textType
    )
    ''');
  }

  Future<NoteModel> createNote(NoteModel note) async {
    final db = await instance.database;
    final id = await db.insert(tableNote, note.toJson());

    return note.copy(id: id);
  }

  Future<NoteModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableNote,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;

    final orderByTime = '${NoteFields.createdTime} ASC';

    final result = await db.query(tableNote, orderBy: orderByTime);

    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<int> update(NoteModel note) async {
    final db = await instance.database;

    return db.update(tableNote, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db
        .delete(tableNote, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future clore() async {
    final db = await instance.database;
    db.close();
  }
}
