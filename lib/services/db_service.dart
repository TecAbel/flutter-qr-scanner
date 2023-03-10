import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qr_scanner/models/qr_model.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _database;

  static final DbService db = DbService._();

  DbService._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();

    return _database!;
  }

  Future<Database> initDb() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDir.path, 'qr_db.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
          ''');
      },
    );
  }

  Future<int> newScanRaw(QrModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, type, value)
      VALUES($id, '$type', '$value');
      ''');

    return res;
  }

  Future<int> newScan(QrModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  Future<QrModel?> getScanById(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? QrModel.fromJson(res.first) : null;
  }

  Future<List<QrModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((x) => QrModel.fromJson(x)).toList() : [];
  }

  Future<List<QrModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    return res.isNotEmpty ? res.map((x) => QrModel.fromJson(x)).toList() : [];
  }

  Future<int> updateScan(QrModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}

class ScanType {
  static const url = 'url';
  static const geo = 'geo';
}
