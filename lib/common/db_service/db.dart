import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  static Database? _database;

  DBService._();

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('markerpoints.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE markerPoints ( 
  id INTEGER PRIMARY KEY, 
  label TEXT NOT NULL,
  lat REAL NOT NULL
  lng REAL NOT NULL
  )
''');
  }
}
