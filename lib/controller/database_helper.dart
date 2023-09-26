import 'package:my_checklist/controller/filePublish.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_checklist/model/rung.dart';

class DatabaseHelper {
  static const dbName = 'taskdatabase.db';
  static const dbVersion = 1;
  static const dbTable = 'tasktable';
  static const colId = 'id';
  static const colTask = 'colTask';
  static const colDone = 'coldone';
  static const colBold = 'colbold';
  static const colInfo = "colInfo";
  static const colArchive = 'colArchive';
  int rowCount = 0;

  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  Future<Object?> get database async {

    bool dbExists = await databaseExists(join(await getDatabasesPath(), 'taskdatabase.db'));
    _database = await initDB();
    dev.log('A!! taskdatabase.db is $dbExists and _database is: $_database');
    dev.log('getcount value is now: $rowCount');

    if (_database != null && rowCount! > 0) {
      dev.log('A4 DB NOT NULL');

      if (dbTable.isNotEmpty) {
        dev.log('A5 - DB table NOT EMPTY - $dbTable');
        // dev.log('Db query ${_database!.query(dbTable).toString()}');
        Rung.myList = []; // Initialised back to empty because we are reading from the db and not from the file anymore
        final List<Map<String, dynamic>> maps = await _database!.query(dbTable);
        Rung.myList.addAll(List.generate(maps.length, (i) {
          return Rung(
            rungId: maps[i]['colid'] ?? '',
            name: maps[i]['colTask'] ?? '',
            done: maps[i]['colDone'] == 0,
            boldTitle: maps[i]['colBold'] == 0,
            info: maps[i]['colInfo'] ?? '',
            archive: maps[i]['colArchive'] == 0,
          );
        }));
        return _database;
      }
    } else {
      dev.log('DB null go initDB ');
      _database = await initDB();
      dev.log('DB NULL back after initDB(): $_database and now going to readFile()',
          name: 'db_helper.dart');
      FilePublish fb = FilePublish();
      dev.log('this read');
      await fb.readFile();
      dev.log('DB 2 back from FilePublish. Length of rungs is ${Rung.myList.length}');
      dev.log('b4 fillDb()');
      fillDb(Rung.myList);
      return _database;
    }
    return null;
  }

  initDB() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //this only works on a mobile phone not browser

    if (!await directory.exists()) {
      dev.log('Directory does not exist so CREATE RECURSIVE');
      await directory.create(recursive: true);
    }

    String path = join(directory.path, dbName);
    getCount();
    dev.log('DB initDB countRow: $rowCount');
    dev.log('2--DB initDB The directory is : $directory and the path is : $path',
        name: 'db_helper.dart initDB()');
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    dev.log('3 -- DB ONCREATE() TO CREATE THE TABLE AND ITS VERSION');
    db.execute('''
      CREATE TABLE $dbTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      colTask TEXT, 
      colDone INTEGER CHECK (colDone IN (0, 1)), 
      colBold INTEGER CHECK (colDone IN (0, 1)), 
      colInfo TEXT, 
      colArchive INTEGER CHECK (colDone IN (0, 1))
      )
    ''');
  }

  insert(Map<String, dynamic> row) async {
    Database? db = (await instance.database) as Database?;
    // dev.log('DB insert', name: 'db_helper insert()');
    return await db!.insert(dbTable, row);
  }

  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = (await instance.database) as Database?;
    // dev.log('DB query', name: 'db_helper query()');
    return await db!.query(dbTable);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = (await instance.database) as Database?;
    String id = row[colId];
    // dev.log('DB update', name: 'db_helper update()');
    return await db!.update(dbTable, row, where: '$colId=?', whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    Database? db = (await instance.database) as Database?;
    // dev.log('DB delete', name: 'db_helper delete()');
    db!.delete(dbTable, where: '$colId = ?', whereArgs: [id]);
  }

  //FILE TO DB SHOULD ONLY DO ONCE
  Future<void> fillDb(List<Rung> myObjects) async {
    dev.log(
        'fillDb This is file contents to db. Only first time ever. After that info must be read from database');
    final Database? db = _database;
    dev.log('9--DB - fillDB() - my rung object length: ${myObjects.length}');

    for (int i = 0; i < myObjects.length; i++) {
      await db?.insert(
        'tasktable',
        {
          ...myObjects[i].toMap(),
          // 'id': int.parse(myObjects[i].rungId),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    getCount();
  }


  Future<void> getCount() async {
    dev.log('Inside getCount()');
    Database? db = (await instance.database) as Database?;
     List<Map<String, Object?>>? result = await db?.query(dbTable);
     rowCount = result!.length;
    dev.log('The db file count is $rowCount');
  }

}
